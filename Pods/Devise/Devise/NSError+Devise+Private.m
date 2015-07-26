//
//  NSError+Devise.m
//  Devise
//
//  Created by Patryk Kaczmarek on 05.03.2015.
//  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
//

#import "NSError+Devise+Private.h"

@implementation NSError (Devise)

+ (instancetype)errorWithJSONDictionary:(NSDictionary *)json code:(NSInteger)code {
    
    NSString *value;
    
    if ([json[@"error"] isKindOfClass:[NSString class]]) {
        value = json[@"error"];
    } else {
        value = json[@"error"][@"message"];
    }
    
    if (!value) {
        value = @"Unrecognized error did appear.";
    }
    
    return [NSError errorWithDomain:NSURLErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: value}];
}

@end
