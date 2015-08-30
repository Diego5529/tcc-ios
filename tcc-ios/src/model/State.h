//
//  State.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface State : NSManagedObject

@property (nonatomic, retain) NSNumber * state_id;
@property (nonatomic, retain) NSNumber * id_country;
@property (nonatomic, retain) NSManagedObject *has_many_city;
@property (nonatomic, retain) NSManagedObject *belongs_to_country;

@end
