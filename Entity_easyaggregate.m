//
//  Entity_easyaggregate.m
//  sqltest
//
//  Created by kartalbas on 03.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Entity_easyaggregate.h"

@implementation Entity_easyaggregate

@synthesize SUM$9open9$;
@synthesize COUNT$9open9$;

-(id) init {
	self = [super init];
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(id) copyWithZone: (NSZone *) zone {
	return [[[self class] allocWithZone: zone] init];
}

@end
