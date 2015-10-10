//
//  Entity_agregates.h
//  sqltest
//
//  Created by kartalbas on 03.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Entity_aggregates : NSObject {
	NSNumber *adresses99customernr;
	NSString *adresses99name1;
	NSNumber *SUM$9offeneposten99open9$;
	NSNumber *COUNT$9offeneposten99open9$;
}

@property(retain) NSNumber *adresses99customernr;
@property(retain) NSString *adresses99name1;
@property(retain) NSNumber *SUM$9offeneposten99open9$;
@property(retain) NSNumber *COUNT$9offeneposten99open9$;

-(id) init;
-(void) dealloc;
-(id) copyWithZone: (NSZone *) zone;

@end
