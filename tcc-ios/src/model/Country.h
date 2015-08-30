//
//  Country.h
//  tcc-ios
//
//  Created by Diego on 8/23/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class State;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSNumber * country_id;
@property (nonatomic, retain) State *has_many_state;

@end
