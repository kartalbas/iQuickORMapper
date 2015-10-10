//
//  Entity_easyaggregate.h
//  sqltest
//
//  Created by kartalbas on 03.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Entity_easyaggregate : NSObject {
	NSNumber *SUM$9open9$;
	NSNumber *COUNT$9open9$;
}

@property(retain) NSNumber *SUM$9open9$;
@property(retain) NSNumber *COUNT$9open9$;

-(id) init;
-(void) dealloc;
-(id) copyWithZone: (NSZone *) zone;

@end
