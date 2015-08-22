//
//  MenuViewController.m
//  tcc-ios
//
//  Created by Diego on 7/30/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import "MenuViewController.h"
#import "AFNetworking.h"
#import "Reachability.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize textFieldModel;
@synthesize textFieldPassword;
@synthesize textFieldUsername;
@synthesize textFieldURL;
@synthesize segmentedControl;
@synthesize textFieldParam1;
@synthesize textFieldParam2;
@synthesize textFieldParam3;
@synthesize textViewRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textFieldURL.text = @"http://tcc-rails.com:3000";
    textFieldModel.text = @"/schools";
    textFieldUsername.text = @"teste@gmail.com";
    textFieldPassword.text = @"123456";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - POST/GET
-(BOOL)executePOST{
    __block BOOL retorno = NO;
    
    NSString * urlSistemaOnline = @"";
    
    Reachability *reachability;
    
    @try {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    @catch (NSException *exception) {
        NSLog(@"ERRO AO VERIFICAR CONEXAO %@: ", exception.reason);
    }
    @finally {
        
    }
    
    if(reachability != nil){
        
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        if( netStatus == NotReachable){
            
            retorno = NO;
            NSLog(@"Sem conexao com a internet");
            [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
            
        }else{
            NSString * url = textFieldURL.text;
            NSString * model = textFieldModel.text;
            urlSistemaOnline = [url stringByAppendingString:model];
            NSString * username = textFieldUsername.text;
            NSString * password = textFieldPassword.text;
            
            NSDictionary * params = @{
                                      @"first_name": textFieldParam2.text,
                                      @"description": textFieldParam3.text
                                      };
            
            NSDictionary * school = @{
                                      @"school": params
                                      };
            
            //AFNETWORKING
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.requestSerializer.timeoutInterval = 300.0;
            
            [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
            
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
            
            __block NSString * responseString = [[NSString alloc] init];
            
            AFHTTPRequestOperation *operation = [manager POST:urlSistemaOnline parameters:school success:^(AFHTTPRequestOperation *operation, id responseObject) {
                responseString = [[NSString alloc] initWithData:responseObject encoding:NSISOLatin1StringEncoding];
                NSLog(@"RESPONSE STRING: %@", responseString);
                if(responseString != nil){
                    
                    retorno = [self readResponseString:responseString];
                }
                
                dispatch_semaphore_signal(semaphore);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSInteger statusCode = operation.response.statusCode;
                if(statusCode == 401) {
                } else if (statusCode == 404) {
                }
                //[self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
                NSString * erro = [NSString stringWithFormat:@"%@", [operation error]];
                NSLog(@"error: %@", erro);
                responseString = erro;
                dispatch_semaphore_signal(semaphore);
            }];
            
            [operation start];
            [operation waitUntilFinished];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            textViewRequest.text = responseString;
        }
    }else{
        [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
    }
    
    return retorno;
}

-(BOOL)executeGET{
    __block BOOL retorno = NO;
    
    NSString * urlSistemaOnline = @"";
    
    Reachability *reachability;
    
    @try {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    @catch (NSException *exception) {
        NSLog(@"ERRO AO VERIFICAR CONEXAO %@: ", exception.reason);
    }
    @finally {
        
    }
    
    if(reachability != nil){
        
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        if( netStatus == NotReachable){
            
            retorno = NO;
            NSLog(@"Sem conexao com a internet");
            [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
            
        }else{
            
            NSString * url = textFieldURL.text;
            NSString * model = textFieldModel.text;
            urlSistemaOnline = [url stringByAppendingString:model];
            if (textFieldParam1.text.length > 0) {
                urlSistemaOnline = [urlSistemaOnline stringByAppendingFormat:@"/%@", textFieldParam1.text];
            }
            NSString * username = textFieldUsername.text;
            NSString * password = textFieldPassword.text;
            
            //AFNETWORKING
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.requestSerializer.timeoutInterval = 300.0;
            
            [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
            
            __block NSString * responseString = [[NSString alloc] init];
            
            AFHTTPRequestOperation *operation = [manager GET:urlSistemaOnline parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                responseString = [[NSString alloc] initWithData:responseObject encoding:NSISOLatin1StringEncoding];
                NSLog(@"RESPONSE STRING: %@", responseString);
                if(responseString != nil){
                    
                    retorno = [self readResponseString:responseString];
                }
                
                dispatch_semaphore_signal(semaphore);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSInteger statusCode = operation.response.statusCode;
                if(statusCode == 401) {
                } else if (statusCode == 404) {
                }
                [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
                NSString * erro = [NSString stringWithFormat:@"%@", [operation error]];
                NSLog(@"error: %@", erro);
                responseString = erro;
                dispatch_semaphore_signal(semaphore);
            }];
            
            [operation start];
            [operation waitUntilFinished];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            textViewRequest.text = responseString;
        }
    }else{
        [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
    }
    
    return retorno;
}

-(BOOL)executePUT{
    __block BOOL retorno = NO;
    
    NSString * urlSistemaOnline = @"";
    
    Reachability *reachability;
    
    @try {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    @catch (NSException *exception) {
        NSLog(@"ERRO AO VERIFICAR CONEXAO %@: ", exception.reason);
    }
    @finally {
        
    }
    
    if(reachability != nil){
        
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        if( netStatus == NotReachable){
            
            retorno = NO;
            NSLog(@"Sem conexao com a internet");
            [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
            
        }else{
            
            NSString * url = textFieldURL.text;
            NSString * model = textFieldModel.text;
            urlSistemaOnline = [url stringByAppendingString:model];
            urlSistemaOnline = [urlSistemaOnline stringByAppendingFormat:@"/%@", textFieldParam1.text];
            NSString * username = textFieldUsername.text;
            NSString * password = textFieldPassword.text;
            
            NSDictionary * params = @{
                                      @"first_name": textFieldParam2.text,
                                      @"description": textFieldParam3.text
                                      };
            
            NSDictionary * school = @{
                                      @"school": params
                                      };
            
            //AFNETWORKING
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.requestSerializer.timeoutInterval = 300.0;
            
            [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
            
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
            
            __block NSString * responseString = [[NSString alloc] init];
            
            AFHTTPRequestOperation *operation = [manager PUT:urlSistemaOnline parameters:school success:^(AFHTTPRequestOperation *operation, id responseObject) {
                responseString = [[NSString alloc] initWithData:responseObject encoding:NSISOLatin1StringEncoding];
                NSLog(@"RESPONSE STRING: %@", responseString);
                if(responseString != nil){
                    
                    retorno = [self readResponseString:responseString];
                }
                
                dispatch_semaphore_signal(semaphore);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSInteger statusCode = operation.response.statusCode;
                if(statusCode == 401) {
                } else if (statusCode == 404) {
                }
                //[self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
                NSString * erro = [NSString stringWithFormat:@"%@", [operation error]];
                NSLog(@"error: %@", erro);
                responseString = erro;
                dispatch_semaphore_signal(semaphore);
            }];
            
            [operation start];
            [operation waitUntilFinished];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            textViewRequest.text = responseString;
        }
    }else{
        [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
    }
    
    return retorno;
}

-(BOOL)executeDELETE{
    __block BOOL retorno = NO;
    
    NSString * urlSistemaOnline = @"";
    
    Reachability *reachability;
    
    @try {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    @catch (NSException *exception) {
        NSLog(@"ERRO AO VERIFICAR CONEXAO %@: ", exception.reason);
    }
    @finally {
        
    }
    
    if(reachability != nil){
        
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        if( netStatus == NotReachable){
            
            retorno = NO;
            NSLog(@"Sem conexao com a internet");
            [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
            
        }else{
            
            NSString * url = textFieldURL.text;
            NSString * model = textFieldModel.text;
            urlSistemaOnline = [url stringByAppendingString:model];
            urlSistemaOnline = [urlSistemaOnline stringByAppendingFormat:@"/%@", textFieldParam1.text];
            NSString * username = textFieldUsername.text;
            NSString * password = textFieldPassword.text;
            
            //AFNETWORKING
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.requestSerializer.timeoutInterval = 300.0;
            
            [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
            
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
            
            __block NSString * responseString = [[NSString alloc] init];
            
            AFHTTPRequestOperation *operation = [manager DELETE:urlSistemaOnline parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                responseString = [[NSString alloc] initWithData:responseObject encoding:NSISOLatin1StringEncoding];
                NSLog(@"RESPONSE STRING: %@", responseString);
                if(responseString != nil){
                    
                    retorno = [self readResponseString:responseString];
                }
                
                dispatch_semaphore_signal(semaphore);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSInteger statusCode = operation.response.statusCode;
                if(statusCode == 401) {
                } else if (statusCode == 404) {
                }
                //[self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
                NSString * erro = [NSString stringWithFormat:@"%@", [operation error]];
                NSLog(@"error: %@", erro);
                responseString = erro;
                dispatch_semaphore_signal(semaphore);
            }];
            
            [operation start];
            [operation waitUntilFinished];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            textViewRequest.text = responseString;
        }
    }else{
        [self exibeMensagem:@"Sem Conexão com a Internet" withTitle:@"Atenção"];
    }
    
    return retorno;
}

-(BOOL)readResponseString:(NSString *)responseString
{
    BOOL prossegue = YES;
    
    //SEPARA O RETORNO COM BASE EM CADA LINHA PARA LER
    NSArray * arrayRetorno = [responseString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    if(arrayRetorno.count <= 1){
        prossegue = NO;
    }
    
    //PARA CADA LINHA FAZER O SEU DEVIDO TRATAMENTO
    for(NSString * line in arrayRetorno){
        
        @autoreleasepool {
            NSLog(@"\n line: %@ \n", line);
        }
    }
    
    return prossegue;
}

- (IBAction)enviarButtonTap:(id)sender {
    NSLog(@"Enviar...");
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            if (textFieldParam2.text.length > 0 && textFieldParam3.text.length > 0) {
                [self executePOST];
            }else{
                [self exibeMensagem:@"Preencha os campos 'Name' e 'Description'" withTitle:@"Ops!"];
            }
        }
            break;
        case 1:
        {
            [self executeGET];
        }
            break;
        case 2:
        {
            if (textFieldParam1.text.length > 0 && textFieldParam2.text.length > 0 && textFieldParam3.text.length > 0) {
                [self executePUT];
            }else{
                [self exibeMensagem:@"Preencha os campos 'ID' que deseja alterar e os campos novos de 'Name' e 'Description'" withTitle:@"Ops!"];
            }
        }
            break;
        case 3:
        {
            if (textFieldParam1.text.length > 0) {
                [self executeDELETE];
            }else{
                [self exibeMensagem:@"Preencha o campo 'ID' para o que deseja deletar" withTitle:@"Ops!"];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)exibeMensagem:(NSString *)mensagem withTitle:(NSString*)titulo {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:titulo
                              message:mensagem
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    });
}

@end
