//
//  NSURLSession+Devise_Private.m
//  Devise
//
//  Created by Patryk Kaczmarek on 22/06/15.
//  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
//

#import "NSURLSession+Devise+Private.h"
#import "NSError+Devise+Private.h"

@implementation NSURLSession (Devise)

- (void)performDataTaskWithRequest:(NSURLRequest *)request completion:(void (^)(id responseObject, NSError *error))completion {
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (completion == NULL) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                completion(nil, error);
                
            } else {
                NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                
                if (statusCode > 204) {
                    completion(nil, [NSError errorWithJSONDictionary:json code:statusCode]);
                } else {
                    completion(json, nil);
                }
            }
        });
    }];
    
    [task resume];
}


@end
