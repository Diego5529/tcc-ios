//
//  Guest.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, GuestType;

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSNumber * guest_id;
@property (nonatomic, retain) GuestType *belongs_to_guest_type;
@property (nonatomic, retain) Event *belongs_to_event;

@end
