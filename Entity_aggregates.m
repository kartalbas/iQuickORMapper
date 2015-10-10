//
//  Entity_agregates.m
//  sqltest
//
//  Created by kartalbas on 03.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Entity_aggregates.h"

@implementation Entity_aggregates

@synthesize adresses99customernr;
@synthesize adresses99name1;
@synthesize SUM$9offeneposten99open9$;
@synthesize COUNT$9offeneposten99open9$;

-(id) init {
	self = [super init];
	return self;
}

-(void) dealloc {
	[adresses99customernr release];
	[adresses99name1 release];
	[SUM$9offeneposten99open9$ release];
	[COUNT$9offeneposten99open9$ release];
	[super dealloc];	
}

-(id) copyWithZone: (NSZone *) zone {
	return [[[self class] allocWithZone: zone] init];
}

@end
