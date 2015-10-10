//
//  HelperString.m
//  sqltest
//
//  Created by kartalbas on 04.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HelperString.h"


@implementation HelperString
 
+ (BOOL)containsSubstring:(NSString *)substring inString:(NSString *) string {
	
	NSRange r = [string rangeOfString:substring];

	if (r.location == NSNotFound) {
		return NO;
	} else {
		return YES;
	}		
}

@end
