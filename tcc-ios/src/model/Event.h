//
//  Event.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EventCategory, EventType, NSManagedObject;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * event_id;
@property (nonatomic, retain) NSManagedObject *belongs_to_city;
@property (nonatomic, retain) NSManagedObject *has_many_event;
@property (nonatomic, retain) EventType *belongs_to_event;
@property (nonatomic, retain) EventCategory *belongs_to_event_category;

@end