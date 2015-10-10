//
//  Entity_groups.h
//  sqltest
//
//  Created by kartalbas on 04.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Entity_groups : NSObject {
	NSNumber *groupsid;
	NSString *type;
	NSString *name;
	NSNumber *value;
	NSDate *ts;
}

@property(retain) NSNumber *groupsid;
@property(retain) NSString *type;
@property(retain) NSString *name;
@property(retain) NSNumber *value;
@property(retain) NSDate *ts;

-(id) init;
-(void) dealloc;
-(id) copyWithZone: (NSZone *) zone;

@end
