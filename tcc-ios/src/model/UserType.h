//
//  UserType.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserType : NSManagedObject

@property (nonatomic, retain) NSNumber * user_type_id;
@property (nonatomic, retain) User *has_many_users;

@end
