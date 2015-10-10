#import <Foundation/Foundation.h>
#import "Entity_adresses.h"
#import "Entity_offeneposten.h"
#import "Entity_aggregates.h"
#import "Entity_easyaggregate.h"
#import "Entity_groups.h"
#import "iQuickORMapper.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	//path of database
	NSString *db = @"/users/kartalbas/Documents/xcode/iorder/iorder.db";

	
/*
	//init the entity
	//Entity_adresses *entity = [[Entity_adresses alloc] init];
	Entity_offeneposten *entity = [[Entity_offeneposten alloc] init];

	//init SQLLite3 with filter, joins, group by, order by
	iQuickORMapper *sql = [[iQuickORMapper alloc]
				initWithDatabase:db
					  withEntity:entity
				   withFromTable:@"offeneposten"
					   withJoins:@"LEFT OUTER JOIN adresses ON offeneposten.customernr = adresses.customernr"
					  withFilter:@"offeneposten.customernr > 10000 AND offeneposten.customernr < 11000"
					 withGroupBy:nil
				     withOrderBy:@"ORDER BY adresses.customernr ASC"
				];

	//get result
	NSMutableArray *result = [sql find];

	int i = 0;
	int count = [result count];

	for(i = 0; i < count; i++) {
		
		Entity_offeneposten *newEntity = (Entity_offeneposten *) [result objectAtIndex: i];
		
		NSLog(@"%@, %@, %@, %@, %@, %@, %@",
			  newEntity.adresses99customernr, newEntity.adresses99name1, newEntity.adresses99name2,
			  newEntity.offeneposten99docnr, newEntity.offeneposten99docdate, newEntity.offeneposten99open, newEntity.offeneposten99sum
			  );
		
		//[newEntity releaseProperties];
		[newEntity release];
		
	}
	[result release];
*/
	
	

	//init the entity
	Entity_aggregates *entity = [[Entity_aggregates alloc] init];
	
	//init SQLLite3 with filter, joins, group by, order by
	iQuickORMapper *sql = [[iQuickORMapper alloc]
				initWithDatabase:db
				      withEntity:entity
				   withFromTable:@"offeneposten"
				       withJoins:@"LEFT OUTER JOIN adresses ON offeneposten.customernr = adresses.customernr"
				      withFilter:nil
					 withGroupBy:@"GROUP BY adresses.customernr"
				     withOrderBy:@"ORDER BY adresses.customernr ASC"
				];
	
	//get result
	NSMutableArray *result = [sql find];
	
	int i = 0;
	int count = [result count];
	
	for(i = 0; i < count; i++) {
		
		Entity_aggregates *newEntity = (Entity_aggregates *) [result objectAtIndex: i];
		
		NSLog(@"%@, %@, %@, %@",
			  newEntity.adresses99customernr, newEntity.adresses99name1,
			  newEntity.SUM$9offeneposten99open9$, newEntity.COUNT$9offeneposten99open9$
			  );
		
		[newEntity release];
	}


/*
	//init the entity
	Entity_easyaggregate *entity = [[Entity_easyaggregate alloc] init];
	 
	//init SQLLite3 with filter, joins, group by, order by
	iQuickORMapper *sql = [[iQuickORMapper alloc]
				 initWithDatabase:db
				       withEntity:entity
	   			    withFromTable:@"offeneposten"
				        withJoins:nil
				       withFilter:nil
				      withGroupBy:nil
				      withOrderBy:nil
	 ];
	 
	//get result
	NSMutableArray *result = [sql find];
	 
	int i = 0;
	int count = [result count];
	 
	for(i = 0; i < count; i++) {
	 
		Entity_easyaggregate *newEntity = (Entity_easyaggregate *) [result objectAtIndex: i];
	 
		NSLog(@"%@, %@", newEntity.SUM$9open9$, newEntity.COUNT$9open9$);
	 
		//[newEntity releaseProperties];
		[newEntity release];
	}
	
	[result release];
*/
/*
	//init the entity
	Entity_groups *entity = [[Entity_groups alloc] init];
	
	//init SQLLite3 with filter, joins, group by, order by
	iQuickORMapper *sql = [[iQuickORMapper alloc]
				initWithDatabase:db
				withEntity:entity
				withFromTable:@"groups"
				withJoins:nil
				withFilter:@"groupsid = 2"
				withGroupBy:nil
				withOrderBy:nil
				];

	entity.groupsid = [[NSNumber alloc] initWithInteger: 2];
//	entity.groupsid = nil;
	entity.type = @"PRICE";
	entity.name = @"Preisgruppe2";
	entity.value = [[NSNumber alloc] initWithInteger:999];
	entity.ts = [[NSDate alloc] init];
	[sql save];
*/

/*

	//init the entity
	Entity_groups *entity = [[Entity_groups alloc] init];

	//init SQLLite3 with filter, joins, group by, order by
	iQuickORMapper *sql = [[iQuickORMapper alloc]
				initWithDatabase:db
				withEntity:entity
				withFromTable:@"groups"
				withJoins:nil
				withFilter:nil
				withGroupBy:nil
				withOrderBy:nil
				];
	
	//get result
	NSMutableArray *result = [sql find];
	
	int i = 0;
	int count = [result count];
	
	for(i = 0; i < count; i++) {
		
		Entity_groups *newEntity = (Entity_groups *) [result objectAtIndex: i];
		
		NSLog(@"%@, %@, %@, %@, %@", newEntity.groupsid, newEntity.type, newEntity.name, newEntity.value, newEntity.ts);
		
		//[newEntity releaseProperties];
		[newEntity release];
	}
*/
	
	[result release];

	[entity release];
	[sql release];

	[pool drain];
    return 0;
}

