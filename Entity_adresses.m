/*
 *  EntityAdress.c
 *  sqltest
 *
 *  Created by kartalbas on 02.08.10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include <stdio.h>
#include "Entity_adresses.h"

@implementation Entity_adresses

@synthesize adressesid;
@synthesize customernr;
@synthesize name1;
@synthesize name2;
@synthesize street;
@synthesize city;
@synthesize zip;
@synthesize country;
@synthesize phone1;
@synthesize phone2;
@synthesize fax;
@synthesize mobile;
@synthesize taxkey;
@synthesize taxnr;

-(void) releaseProperties {
	[adressesid release];
	[customernr release];	
	[name1 release];
	[name2 release];
	[street release];
	[city release];
	[zip release];
	[country release];
	[phone1 release];
	[phone2 release];
	[fax release];
	[mobile release];
	[taxkey release];
	[taxnr release];	
}

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

