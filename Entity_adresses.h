/*
 *  EntityAdress.h
 *  sqltest
 *
 *  Created by kartalbas on 02.08.10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#import <objc/Object.h>

@interface Entity_adresses : NSObject {
	NSNumber *adressesid;
	NSNumber *customernr;
	NSString *name1;
	NSString *name2;
	NSString *street;
	NSString *city;
	NSString *zip;
	NSString *country;
	NSString *phone1;
	NSString *phone2;
	NSString *fax;
	NSString *mobile;
	NSNumber *taxkey;
	NSString *taxnr;
}

@property(retain) NSNumber *adressesid;
@property(retain) NSNumber *customernr;
@property(retain) NSString *name1;
@property(retain) NSString *name2;
@property(retain) NSString *street;
@property(retain) NSString *city;
@property(retain) NSString *zip;
@property(retain) NSString *country;
@property(retain) NSString *phone1;
@property(retain) NSString *phone2;
@property(retain) NSString *fax;
@property(retain) NSString *mobile;
@property(retain) NSNumber *taxkey;
@property(retain) NSString *taxnr;

-(id) init;
-(void) releaseProperties;
-(void) dealloc;
-(id) copyWithZone: (NSZone *) zone;

@end
