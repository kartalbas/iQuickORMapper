//
//  Entity_offeneposten.m
//  sqltest
//
//  Created by kartalbas on 29.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Entity_offeneposten.h"

@implementation Entity_offeneposten

@synthesize adresses99adressesid;
@synthesize adresses99customernr;
@synthesize adresses99name1;
@synthesize adresses99name2;
@synthesize adresses99street;
@synthesize adresses99city;
@synthesize adresses99zip;
@synthesize adresses99country;
@synthesize adresses99phone1;
@synthesize adresses99phone2;
@synthesize adresses99fax;
@synthesize adresses99mobile;
@synthesize adresses99taxkey;
@synthesize adresses99taxnr;
@synthesize offeneposten99offenepostenid;
@synthesize offeneposten99docdate;
@synthesize offeneposten99docnr;
@synthesize offeneposten99customernr;
@synthesize offeneposten99open;
@synthesize offeneposten99sum;


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
