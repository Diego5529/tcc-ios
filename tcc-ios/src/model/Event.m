//
//  Event.m
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import "Event.h"
#import "EventCategory.h"
#import "EventType.h"


@implementation Event

@dynamic event_id;
@dynamic belongs_to_city;
@dynamic has_many_event;
@dynamic belongs_to_event;
@dynamic belongs_to_event_category;

@end
