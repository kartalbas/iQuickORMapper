//
//  SQL.h
//  sqltest
//
//  Created by kartalbas on 04.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <objc/Object.h>
#import <sqlite3.h>

#define FLOAT		@"f"
#define DOUBLE		@"d"
#define NSDATE		@"NSDate"
#define NSINTEGER	@"NSInteger"
#define NSNUMBER	@"NSNumber"
#define NSSTRING	@"NSString"

@interface iQuickORMapper: NSObject {
	sqlite3 *m_db;
	NSString *m_dbconnection;
	NSString *m_fromtable;
	NSString *m_filter;
	NSString *m_joins;
	NSString *m_orderby;
	NSString *m_groupby;
	NSObject *m_entity;
}

-(id) initWithDatabase:(NSString *) dbconnection
			withEntity:(NSObject *) entity
		 withFromTable:(NSString *) table
			 withJoins:(NSString *) joins
			withFilter:(NSString *) filter
		   withGroupBy:(NSString *) groupby
		   withOrderBy:(NSString *) orderby;
	
-(void) dealloc;

-(NSMutableArray *) find;

-(void) save;

-(void) TEST: (NSObject *) entity;

@end

@interface iQuickORMapper (private)

-(NSString *) getClassname:(NSObject*) class;
-(NSString *) getClassPropertiesInString:(NSObject*) class;
-(NSMutableArray *) getClassPropertiesInArray:(NSObject*) class;
-(NSDictionary *) getClassPropertieTypes: (NSObject*) class;

-(BOOL) openDB:(NSString *) path;
-(void) closeDB:(NSString *) path;

@end

