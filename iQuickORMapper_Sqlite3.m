//
//  SQLSqlite3.m
//  sqltest
//
//  Created by kartalbas on 04.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

// ToDo:
// -- implement try/catch
// -- implement own exceptions
// -- implement detail exception loggings

#import <objc/objc-class.h>
#import <objc/runtime.h>
#import <objc/message.h>

#include <stdio.h>
#import "iQuickORMapper.h"
#import "Entity_adresses.h"
#import "HelperString.h"

@implementation iQuickORMapper

-(id) initWithDatabase:(NSString *) dbconnection
			withEntity:(NSObject *) entity
		 withFromTable:(NSString *) table
			 withJoins:(NSString *) joins
			withFilter:(NSString *) filter
		   withGroupBy:(NSString *) groupby
		   withOrderBy:(NSString *) orderby {

	self = [super init];

	m_dbconnection = dbconnection;
	m_entity = entity;
	m_fromtable = table;
	m_filter = filter;
	m_joins = joins;
	m_orderby = orderby;
	m_groupby = groupby;

	return self;
}

-(void) dealloc {	
	[super dealloc];
}

-(void) TEST: (NSObject *) entity {
	
	NSString* x1 = [self getClassname: entity];
	NSLog(@"%@", x1);
	[x1 release];
	
	NSString* x2 = [self getClassPropertiesInString: entity];
	NSLog(@"%@", x2);
	[x2 release];
	
	NSDictionary* x3 = [self getClassPropertieTypes: entity];
	NSLog(@"%@", x3);	
	[x3 release];

//	[self dumpInfo];
}

// ***************************************************************************************************
// Purpose		:	find an entity or get a bunch of entities in an array
// Method		:	find
// Arguments	:	void
// Result		:	NSMutableArray

-(NSMutableArray *) find {
	//Columns
	NSString *columns = [self getClassPropertiesInString: m_entity];

	//Create statement 'SELECT' + fields + 'FROM' + filter + joins + groupby + orderby
	NSMutableString *sql = [[NSMutableString alloc] initWithString: @""];
	
	[sql appendString: @"SELECT "];
	[sql appendString: columns];
	[sql appendString: @" FROM "];

	if (m_fromtable != nil) {
		[sql appendString: m_fromtable];
		[sql appendString: @" "];
	}

	if (m_joins != nil) {
		[sql appendString: m_joins];
		[sql appendString: @" "];
	}
	
	if (m_filter != nil) {
		[sql appendString: @" WHERE "];
		[sql appendString: m_filter];
		[sql appendString: @" "];
	}
	
	if (m_groupby != nil) {
		[sql appendString: m_groupby];
		[sql appendString: @" "];
	}

	if (m_orderby != nil) {
		[sql appendString: m_orderby];
		[sql appendString: @" "];
	}

	NSLog(@"%@", sql);

	//fire statement against database
	[self openDB: m_dbconnection];

	int dbrc;
	sqlite3_stmt *stmt;
	char *_sql = (char *) [sql UTF8String];
	if(sqlite3_prepare_v2(m_db, _sql, -1, &stmt, NULL) == SQLITE_OK) {
		NSLog(@"Statement is okey!");
	} else {
		NSLog(@"Error in statement!");
	}

	[sql release];
	
	//fill the result to an array
	NSMutableArray *aResult = [[NSMutableArray alloc] init];
	NSMutableArray *aProperties = [self getClassPropertiesInArray:m_entity];
	NSDictionary *dMemberTypes = [self getClassPropertieTypes:m_entity];

//	for (id key in dMemberTypes) {
//       NSLog(@"key: %@, value: %@", key, [dMemberTypes objectForKey:key]);		
//    }
	
	while ((dbrc = sqlite3_step(stmt)) == SQLITE_ROW) {

		NSObject *newEntity = [m_entity copy];

		// Iterate over all of the columns. Determine their type and retrieve its value
		int colCount = sqlite3_column_count(stmt);

		for(int i=0; i<colCount; i++) {

			int type = sqlite3_column_type(stmt, i);

			NSString *nextProperty = (NSString *)[aProperties objectAtIndex: i];
			NSString *memberType = (NSString *) [dMemberTypes objectForKey:(NSObject *) nextProperty];

			if (type == SQLITE_INTEGER) {
				NSNumber *value = [[NSNumber alloc] initWithFloat:sqlite3_column_double(stmt, i)];
				object_setInstanceVariable(newEntity, [nextProperty cStringUsingEncoding:NSASCIIStringEncoding], value);
				
			} else if (type == SQLITE_FLOAT) {
				NSNumber *value = [[NSNumber alloc] initWithFloat:sqlite3_column_double(stmt, i)];
				object_setInstanceVariable(newEntity, [nextProperty cStringUsingEncoding:NSASCIIStringEncoding], value);
				
			} else if (type == SQLITE_TEXT && [memberType isEqualToString: NSDATE]) {
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"CET"]];
				[dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];

				NSString *value = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, i)];
				NSDate *dateValue = [dateFormatter dateFromString: value];
				[dateFormatter release];
				object_setInstanceVariable(newEntity, [nextProperty cStringUsingEncoding:NSASCIIStringEncoding], dateValue);
				
			} else if (type == SQLITE_TEXT) {
				NSString *value = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, i)];
				object_setInstanceVariable(newEntity, [nextProperty cStringUsingEncoding:NSASCIIStringEncoding], value);
				
			} else if (type == SQLITE_BLOB) {
				NSData *value = [[NSData alloc] initWithBytes:sqlite3_column_blob(stmt, i) length:sqlite3_column_bytes(stmt,i)];
				object_setInstanceVariable(newEntity, [nextProperty cStringUsingEncoding:NSASCIIStringEncoding], value);
				
			} else if (type == SQLITE_BLOB) {
				NSData *value = [[NSData alloc] initWithBytes:sqlite3_column_blob(stmt, i) length:sqlite3_column_bytes(stmt,i)];
				object_setInstanceVariable(newEntity, [nextProperty cStringUsingEncoding:NSASCIIStringEncoding], value);
				
			} else if (type == SQLITE_NULL) {
				object_setInstanceVariable(newEntity, [nextProperty cStringUsingEncoding:NSASCIIStringEncoding], @"null");
				
			} else {
				NSLog(@"Type not found: %@", type);
			}
			
		}
				
		//save filled entity to array
		[aResult addObject: newEntity];
	}
	
	[dMemberTypes release];
	[aProperties release];
	
	sqlite3_finalize(stmt);
	[self closeDB: m_dbconnection];

	return aResult;
}

// ***************************************************************************************************
// Purpose		:	save or update an entity
// Method		:	save
// Arguments	:	void
// Result		:	void

-(void) save {
	
	NSDictionary *dMemberTypes = [self getClassPropertieTypes:m_entity];

	//create tableid = tablename + id then get the value for that tableid
	NSMutableString *tableIdName = [[NSMutableString alloc] initWithString: m_fromtable];
	[tableIdName appendString:@"id"];
	//lookup if this tableid exists in entity
	NSString *memberType = (NSString *) [dMemberTypes objectForKey:(NSObject *) tableIdName];
	NSNumber *tableIdValue = [m_entity valueForKey:tableIdName];
	
	//get columns
	NSString *columns = [self getClassPropertiesInString: m_entity];

	NSMutableString *sql = [[NSMutableString alloc] initWithString: @""];
	//Identify if the query should be an update or an select
	if ((memberType == nil || [tableIdValue intValue] == 0) && m_filter == nil) {
		//if id=0 the generate INSERT statement
		[tableIdName appendString:@", "];
		NSString *newColumns = [[NSString alloc] initWithString: [columns stringByReplacingOccurrencesOfString:tableIdName withString:@""]];
		[columns release];
		columns = newColumns;
		[columns retain];
		[newColumns release];
		[sql appendString: @"INSERT INTO "];
		[sql appendString: m_fromtable];
		[sql appendString: @" ("];
		[sql appendString: columns];
		[sql appendString: @") VALUES ("];
	} else {
		//if id>0 the generate UPDATE statement
		[sql appendString: @"UPDATE "];
		[sql appendString: m_fromtable];
		[sql appendString: @" SET "];
	}

	//separate the columns in an new array
	NSArray *aColumns = [columns componentsSeparatedByString:@", "];

	if ([HelperString containsSubstring:@"UPDATE " inString:sql]) {
		//continue generating UPDATE statement
		int count = [aColumns count];
		
		for(int i=0; i<count; i++) {
			memberType = (NSString *) [dMemberTypes objectForKey:[aColumns objectAtIndex:i]];
			
			[sql appendString:[aColumns objectAtIndex:i]];
			[sql appendString: @"="];

			if ([HelperString containsSubstring:@"NSNumber" inString:memberType]) {
				NSNumber *numb = [m_entity valueForKey:[aColumns objectAtIndex:i]];
				[sql appendString:[numb stringValue]];
				[numb release];
				[sql appendString: @", "];
			} else if([HelperString containsSubstring:@"NSDate" inString:memberType]) {
				[sql appendString: @"'"];
				NSDate *date = [m_entity valueForKey:(NSString *)[aColumns objectAtIndex:i]];
				[sql appendString: [date descriptionWithCalendarFormat:@"%Y-%m-%d %H:%M:%S" timeZone:nil locale:nil]];
				[sql appendString: @"', "];
			} else {
				[sql appendString: @"'"];
				[sql appendString: [m_entity valueForKey:(NSString *)[aColumns objectAtIndex:i]]];
				[sql appendString: @"', "];
			}
		}
		
	} else {
		//continue generating INSERT statement
		int count = [aColumns count];
		
		for(int i=0; i<count; i++) {
			memberType = (NSString *) [dMemberTypes objectForKey:[aColumns objectAtIndex:i]];
			if ([HelperString containsSubstring:@"NSNumber" inString:memberType]) {
				NSNumber *numb = [m_entity valueForKey:[aColumns objectAtIndex:i]];
				[sql appendString:[numb stringValue]];
				[numb release];
				[sql appendString: @", "];
			} else if([HelperString containsSubstring:@"NSDate" inString:memberType]) {
				[sql appendString: @"'"];
				NSDate *date = [m_entity valueForKey:(NSString *)[aColumns objectAtIndex:i]];
				[sql appendString: [date descriptionWithCalendarFormat:@"%Y-%m-%d %H:%M:%S" timeZone:nil locale:nil]];
				[sql appendString: @"', "];
			} else {
				[sql appendString: @"'"];
				[sql appendString: [m_entity valueForKey:(NSString *)[aColumns objectAtIndex:i]]];
				[sql appendString: @"', "];
			}
		}
	}

	NSRange range = NSMakeRange([sql length]-2, 2);
	[sql deleteCharactersInRange: range];

	if ([HelperString containsSubstring:@"INSERT INTO " inString:sql]) {
		[sql appendString: @")"];
	} else {
		//if its an INSERT then append filter if available
		if (m_filter != nil) {
			[sql appendString: @" WHERE "];
			[sql appendString: m_filter];
			[sql appendString: @" "];
		}
	}
	
	NSLog(@"%@", sql);

	//open database
	[self openDB: m_dbconnection];
	//prepare statement
	int dbrc;
	sqlite3_stmt *stmt;
	char *_sql = (char *) [sql UTF8String];
	if(sqlite3_prepare_v2(m_db, _sql, -1, &stmt, NULL) == SQLITE_OK) {
		NSLog(@"Statement is okey!");
	} else {
		NSLog(@"Error in statement!");
	}
	//execute statement
	dbrc = sqlite3_step(stmt);
	//finalize and close database
	dbrc = sqlite3_finalize(stmt);
	[self closeDB: m_dbconnection];

	//release memory
	[sql release];
	[memberType release];
	[tableIdName release];
}

// ***************************************************************************************************
// Purpose		:	Get all properties of a class in form of stringobject to a string
// Method		:	getClassPropertiesInString
// Arguments	:	(NSObject *) class
// Result		:	NSMutableArray

-(NSString *) getClassPropertiesInString:(NSObject*) class {
	
	NSMutableArray* aProperties = [self getClassPropertiesInArray: class];
	
	int count = [aProperties count];

	NSMutableString *properties = [[NSMutableString alloc] initWithString: @""];

	for(int i=0; i<count; i++) {
		NSString *s1 = (NSString *) [aProperties objectAtIndex: i];
		s1 = [s1 stringByReplacingOccurrencesOfString:@"99" withString:@"."];	
		s1 = [s1 stringByReplacingOccurrencesOfString:@"$9" withString:@"("];
		s1 = [s1 stringByReplacingOccurrencesOfString:@"9$" withString:@")"];
		[properties appendString: s1];
		[properties appendString: @", "];
	}
	
	[aProperties release];
		
	return [properties substringToIndex: [properties length] - 2];
}

// ***************************************************************************************************
// Purpose		:	Get all properties of a class in form of stringobject in a array
// Method		:	getClassPropertiesInArray
// Arguments	:	(NSObject *) class
// Result		:	NSMutableArray*

-(NSMutableArray*) getClassPropertiesInArray: (NSObject*) class {

	Class cls = [class class];
	u_int count;

    objc_property_t* properties = class_copyPropertyList(cls, &count);
    NSMutableArray* aProperty = [[NSMutableArray alloc] initWithCapacity:count];

    for (int i = count-1; i >= 0 ; i--) {
        const char* name = property_getName(properties[i]);
        [aProperty addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
    }
	
    free(properties);
	
	return aProperty;
}

// ***************************************************************************************************
// Purpose		:	Get property name and type
// Method		:	getClassPropertieTypes
// Arguments	:	(NSObject *) class
// Result		:	NSDictionary*

-(NSDictionary*) getClassPropertieTypes: (NSObject*) class {
	
	Class cls = [class class];
	u_int count;
	
    objc_property_t* properties = class_copyPropertyList(cls, &count);
	NSMutableArray *keyName = [[NSMutableArray alloc] initWithCapacity:count];
	NSMutableArray *valueType = [[NSMutableArray alloc] initWithCapacity:count];

    for (int i = 0; i < count ; i++) {
		const char *attributes = property_getAttributes(properties[i]);
		char buffer[1 + strlen(attributes)];
		strcpy(buffer, attributes);
		char *state = buffer, *attribute;

		while ((attribute = strsep(&state, ",")) != NULL) {
			if (attribute[1] == '@') {
				const char *type =[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
				const char *name =[[NSData dataWithBytes:(state + 3) length:strlen(state)] bytes];
				[valueType addObject:[NSString stringWithCString:type encoding:NSUTF8StringEncoding]];
				[keyName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
			} else if (attribute[0] == 'T') {
				const char *type =[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 0] bytes];
				const char *name = state;
				[valueType addObject:[NSString stringWithCString:type encoding:NSUTF8StringEncoding]];
				[keyName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];				
			}
		}
    }

    free(properties);

	NSDictionary *dictProperties = [[NSDictionary alloc] initWithObjects: valueType forKeys: keyName];

	return dictProperties;
}

// ***************************************************************************************************
// Purpose		:	Get name of a class
// Method		:	getClassname
// Arguments	:	(NSObject *) class
// Result		:	NSString*

-(NSString *) getClassname:(NSObject*) class {
	NSString* classname = [[NSString alloc] initWithUTF8String:class_getName([class class])];
	return classname;
}

// ***************************************************************************************************
// Purpose		:	open the databasefile and store the handler in the class member variabl m_db
// Method		:	openDB
// Arguments	:	(NSString *) path
// Result		:	BOOL

-(BOOL)openDB:(NSString *) path {
	
	NSFileManager* fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:path]) {
		
		[fileManager release];
		
		int open = sqlite3_open([path UTF8String], &m_db);
		
		if (open == SQLITE_OK) {
			printf("Database was openend at %s \n", [path UTF8String]);
			return YES;
		} else {
			printf("Database found at %s but the database couldn't be opened \n", [path UTF8String]);
		[self closeDB: path];
			return NO;
		}
	} else {
		printf("Databasefile %s couldn't be found \n", [path UTF8String]);
		return NO;
	}	
		
}

// ***************************************************************************************************
// Purpose		:	close databasefile
// Method		:	closeDB
// Arguments	:	(NSString *) path
// Result		:	void

-(void) closeDB:(NSString *) path {
	if (m_db != nil) {
		sqlite3_close(m_db);
		printf("Database was closed at %s \n", [path UTF8String]);
	}
}


// ***************************************************************************************************
-(void)dumpInfo: (NSObject *) entity
{
    Class clazz = [entity class];
    u_int count;
	
    Ivar* ivars = class_copyIvarList(clazz, &count);
    NSMutableArray* ivarArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* ivarName = ivar_getName(ivars[i]);
        [ivarArray addObject:[NSString  stringWithCString:ivarName encoding:NSUTF8StringEncoding]];
    }
    free(ivars);
	
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
	
    Method* methods = class_copyMethodList(clazz, &count);
    NSMutableArray* methodArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        SEL selector = method_getName(methods[i]);
        const char* methodName = sel_getName(selector);
        [methodArray addObject:[NSString  stringWithCString:methodName encoding:NSUTF8StringEncoding]];
    }
    free(methods);
	
    NSDictionary* classDump = [NSDictionary dictionaryWithObjectsAndKeys:
                               ivarArray, @"ivars",
                               propertyArray, @"properties",
                               methodArray, @"methods",
                               nil];
	
    NSLog(@"%@", classDump);
}

@end
