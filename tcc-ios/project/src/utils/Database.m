//
//  Database.m
//  LoginProject
//
//  Created by Douglas Cavalheiro on 07/02/13.
//  Copyright (c) 2013 Douglas Cavalheiro. All rights reserved.
//

#import "sqlite3.h"
#import "Database.h"
#import "AppDelegate.h"

@implementation Database

@synthesize database = _database;
@synthesize fmDatabase = _fmDatabase;
@synthesize fmDatabaseQueue = _fmDatabaseQueue;


-(void)createAndOpenDatabase:(NSString *)nomeBD {
    
    NSString *path = [@"/Documents/" stringByAppendingString:nomeBD];
    
    NSString *databasePath = [NSHomeDirectory() stringByAppendingString:path];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
    
    // usar este processo para quando corromper a base */
    /*
	if(fileExists){
		[[NSFileManager defaultManager] removeItemAtPath:databasePath error:nil];
        fileExists = NO;
	}
	*/
	
	AppDelegate * delegate = [[UIApplication sharedApplication]delegate];
	
    if(! fileExists){
		//[delegate appendLog:@"Criando base de dados"];
        [self copiaDatabase];
        
        int resultado = sqlite3_open([databasePath UTF8String], &_database);
        
        if(resultado == SQLITE_OK){
            NSLog(@"BANCO DE DADOS CRIADOS");
            
            self.fmDatabase = [FMDatabase databaseWithPath:databasePath];
			if(self.fmDatabase.open){
                //[self.fmDatabase setBusyTimeout:60.0];
            }
            
            [self executeInsertInicial];
			//[delegate appendLog:@"Executado o insert inicial da base"];
        }else{
            NSLog(@"ERRO AO CRIAR BANCO DE DADOS");
        }
        
    }
	
	
    
    if( self.database == NULL ){
        NSLog(@"Conectar ao banco de dados");
        int resultado = sqlite3_open([databasePath UTF8String], &_database);
        
        if(resultado == SQLITE_OK){
            NSLog(@"BANCO DE DADOS CONECTADO");
            self.fmDatabase = [FMDatabase databaseWithPath:databasePath];
            if(self.fmDatabase.open){
                //[self.fmDatabase setBusyRetryTimeout:60];
				[self.fmDatabase setLogsErrors:YES];
				[self.fmDatabase setCrashOnErrors:NO];
            }
        
        }else{
            NSLog(@"ERRO AO CONECTAR NO BANCO DE DADOS");
            
        }


    }else{
        NSLog(@"BANCO DE DADOS JA CONECTADO");
    }
	
	self.fmDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
	
	if(self.fmDatabase){
		//seta o formato da data
		NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
		dateFormatter.dateFormat = @"yyyy-MM-dd";
		[self.fmDatabase setDateFormat:dateFormatter];
		//exibe no log todos sqls
		/*
		[self.fmDatabase setTraceExecution:YES];
		[self.fmDatabaseQueue inDatabase:^(FMDatabase *db) {
			[db setTraceExecution:YES];
		}];
		 */
	}
	
	//apaga os logs
	[self apagaLogs];
	
}

-(void)apagaLogs
{
	[self.fmDatabase executeUpdate:@"DELETE FROM LOG where data_log < date('now','-60 day')"];
	[self.fmDatabase executeUpdate:@"DELETE FROM LAYOUT_DADOS_LOG"];
}

-(void) copiaDatabase{
    NSString *databaseFileOrigem = [[NSBundle mainBundle] pathForResource:@"firenze" ofType:@"sqlite"];
    
    if(databaseFileOrigem){
        NSLog(@" Copiando banco de dados");
        
        NSString *path = [@"/Documents/" stringByAppendingString:@"firenze.sqlite"];
        
        NSString *databasePath = [NSHomeDirectory() stringByAppendingString:path];
        
        NSData *data = [NSData dataWithContentsOfFile:databaseFileOrigem];
        
        [data writeToFile:databasePath atomically:YES];
    }
        
}


-(void)executeInsertInicial{
    [self.fmDatabase executeUpdate:@"DELETE FROM EMPRESA"];
    [self.fmDatabase executeUpdate:@"DELETE FROM CONFIGURACAO"];
    
    
    NSString *insertFile = [[NSBundle mainBundle] pathForResource:@"insert_inicial" ofType:@"sql"];
    
    
    NSString *insertString = [NSString stringWithContentsOfFile:insertFile encoding:NSISOLatin1StringEncoding error:nil];
    
    NSLog(@"CONTEUDO DA STRING : %@",insertString);
    [self executeSql:insertString];
}

-(BOOL)executeSql:(NSString *)sql{
    
	BOOL sucess = YES;
	
	char * errorMsg;
	
	sqlite3_exec(
                 self.database,
                 [@"BEGIN" UTF8String],
                 0,
                 0,
                 0);
	
	
	int resultado = sqlite3_exec(
								 self.database,
								 [sql UTF8String],
								 0,
								 0,
								 &errorMsg);
	NSLog(@"SQL: | %@ |", sql);
	
	if(resultado == SQLITE_OK){
		NSLog(@"execucao de sql foi um sucesso!");
		
		sqlite3_exec(
                     self.database,
                     [@"COMMIT" UTF8String],
                     0,
                     0,
                     0);
		
	}else{
		
		if(errorMsg != nil){
			NSString * strErro = [NSString stringWithFormat:@"%s",errorMsg];
			
			NSLog(@"execucao de sql falhou: %@",strErro);
			
			//se nao tiver o erro de duplicate entao é problema, senao o campo ja existe
			if([strErro rangeOfString:@"duplicate"].length == 0){
				sucess = NO;
			}else{
				sqlite3_exec(
							 self.database,
							 [@"ROLLBACK" UTF8String],
							 0,
							 0,
							 0);
			}

		}
		
				
		//sqlite3_close(self.database);
		//[self.fmDatabase open];
	}
	
	sql = nil;
	
	return sucess;
    
}

@end
