//
//  City.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, State;

@interface City : NSManagedObject

@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, retain) NSNumber * id_state;
@property (nonatomic, retain) Event *has_many_event;
@property (nonatomic, retain) State *belongs_to_state;

@end
