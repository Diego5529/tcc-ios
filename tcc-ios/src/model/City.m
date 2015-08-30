//
//  City.m
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import "City.h"
#import "Event.h"
#import "State.h"


@implementation City

@dynamic city_id;
@dynamic id_state;
@dynamic has_many_event;
@dynamic belongs_to_state;

@end
