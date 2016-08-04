//
//  Database.h
//  LoginProject
//
//  Created by Douglas Cavalheiro on 07/02/13.
//  Copyright (c) 2013 Douglas Cavalheiro. All rights reserved.
//

#import "sqlite3.h"
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface Database : NSObject

@property (nonatomic) sqlite3 *database;
@property (nonatomic) FMDatabase *fmDatabase;
@property (nonatomic) FMDatabaseQueue *fmDatabaseQueue;


-(void) createAndOpenDatabase:(NSString*)nomeBD;
-(void) executeInsertInicial;
-(void) apagaLogs;
-(void) copiaDatabase;
-(BOOL) executeSql:(NSString*)sql;

@end
