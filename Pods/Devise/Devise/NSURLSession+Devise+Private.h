//
//  NSURLSession+Devise_Private.h
//  Devise
//
//  Created by Patryk Kaczmarek on 22/06/15.
//  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSession (Devise)

- (void)performDataTaskWithRequest:(NSURLRequest *)request completion:(void (^)(id responseObject, NSError *error))completion;

@end
