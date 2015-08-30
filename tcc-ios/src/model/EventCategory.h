//
//  EventCategory.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface EventCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * event_category_id;
@property (nonatomic, retain) NSManagedObject *has_many_event;

@end
