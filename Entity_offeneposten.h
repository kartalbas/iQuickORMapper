//
//  Entity_offeneposten.h
//  sqltest
//
//  Created by kartalbas on 29.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Entity_offeneposten : NSObject {
	NSNumber *adresses99adressesid;
	NSNumber *adresses99customernr;
	NSString *adresses99name1;
	NSString *adresses99name2;
	NSString *adresses99street;
	NSString *adresses99city;
	NSString *adresses99zip;
	NSString *adresses99country;
	NSString *adresses99phone1;
	NSString *adresses99phone2;
	NSString *adresses99fax;
	NSString *adresses99mobile;
	NSNumber *adresses99taxkey;
	NSString *adresses99taxnr;
	NSNumber *offeneposten99offenepostenid;
	NSDate *offeneposten99docdate;
	NSString *offeneposten99docnr;
	NSNumber *offeneposten99customernr;
	NSNumber *offeneposten99open;
	NSNumber *offeneposten99sum;
}

@property(retain) NSNumber *adresses99adressesid;
@property(retain) NSNumber *adresses99customernr;
@property(retain) NSString *adresses99name1;
@property(retain) NSString *adresses99name2;
@property(retain) NSString *adresses99street;
@property(retain) NSString *adresses99city;
@property(retain) NSString *adresses99zip;
@property(retain) NSString *adresses99country;
@property(retain) NSString *adresses99phone1;
@property(retain) NSString *adresses99phone2;
@property(retain) NSString *adresses99fax;
@property(retain) NSString *adresses99mobile;
@property(retain) NSNumber *adresses99taxkey;
@property(retain) NSString *adresses99taxnr;
@property(retain) NSNumber *offeneposten99offenepostenid;
@property(retain) NSDate *offeneposten99docdate;
@property(retain) NSString *offeneposten99docnr;
@property(retain) NSNumber *offeneposten99customernr;
@property(retain) NSNumber *offeneposten99open;
@property(retain) NSNumber *offeneposten99sum;


-(id) init;
-(void) dealloc;
-(id) copyWithZone: (NSZone *) zone;

@end
