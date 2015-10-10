//
//  Entity_groups.m
//  sqltest
//
//  Created by kartalbas on 04.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Entity_groups.h"


@implementation Entity_groups

@synthesize groupsid;
@synthesize type;
@synthesize name;
@synthesize value;
@synthesize ts;

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
