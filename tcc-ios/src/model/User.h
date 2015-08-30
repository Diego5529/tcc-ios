//
//  User.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSManagedObject *belongs_to_users_type;

@end
