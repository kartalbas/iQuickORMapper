# iQuickORMapper

## Overview
iQuickORMapper is a lightweight Object-Relational Mapping (ORM) library for SQLite in Objective-C. It provides a simple way to map Objective-C objects to SQLite database tables with minimal configuration.

## Features
- Simple and fast SQLite database access
- Automatic mapping between database tables and Objective-C objects
- Support for complex queries with joins
- SQL aggregation functions (SUM, COUNT, etc.)
- Dynamic SQL generation
- Minimal configuration required

## Requirements
- Objective-C
- Foundation Framework
- SQLite3

## Installation
1. Add all iQuickORMapper files to your project.
2. Import the main header file:
    ```objective-c
    #import "iQuickORMapper.h"
    ```
3. Link against `libsqlite3.dylib`.

## Usage Examples

### Basic Query
```objective-c
// Create entity object
Entity_adresses *entity = [[Entity_adresses alloc] init];

// Initialize the ORM with database path and entity
iQuickORMapper *sql = [[iQuickORMapper alloc]
     initWithDatabase:@"path/to/database.db"
             withEntity:entity
         withFromTable:@"adresses"
              withJoins:nil
             withFilter:nil
            withGroupBy:nil
            withOrderBy:nil
];

// Get results
NSMutableArray *result = [sql find];

// Process results
for (int i = 0; i < [result count]; i++) {
     Entity_adresses *adress = (Entity_adresses *)[result objectAtIndex:i];
     NSLog(@"%@, %@", adress.name1, adress.street);
     [adress release];
}

[result release];
[entity release];
[sql release];
```

### Query with Join and Aggregation
```objective-c
// Create an aggregation entity
Entity_aggregates *entity = [[Entity_aggregates alloc] init];

// Initialize with complex query
iQuickORMapper *sql = [[iQuickORMapper alloc]
     initWithDatabase:@"path/to/database.db"
             withEntity:entity
         withFromTable:@"offeneposten"
              withJoins:@"LEFT OUTER JOIN adresses ON offeneposten.customernr = adresses.customernr"
             withFilter:nil
            withGroupBy:@"GROUP BY adresses.customernr"
            withOrderBy:@"ORDER BY adresses.customernr ASC"
];

// Get and process results
NSMutableArray *result = [sql find];
// ... process results
```

### Insert or Update
```objective-c
// Create and populate entity
Entity_groups *entity = [[Entity_groups alloc] init];
entity.groupsid = [NSNumber numberWithInt:2];
entity.type = @"PRICE";
entity.name = @"Preisgruppe2";
entity.value = [NSNumber numberWithInt:999];
entity.ts = [NSDate date];

// Initialize ORM
iQuickORMapper *sql = [[iQuickORMapper alloc]
     initWithDatabase:@"path/to/database.db"
             withEntity:entity
         withFromTable:@"groups"
              withJoins:nil
             withFilter:nil
            withGroupBy:nil
            withOrderBy:nil
];

// Save the entity (will update if ID exists, insert if new)
[sql save];
```

## Entity Mapping
Entities are defined as Objective-C classes with properties that map to database columns:
```objective-c
@interface Entity_adresses : NSObject {
     NSNumber *adressesid;
     NSNumber *customernr;
     NSString *name1;
     NSString *street;
     // Other properties...
}

@property(retain) NSNumber *adressesid;
@property(retain) NSNumber *customernr;
@property(retain) NSString *name1;
@property(retain) NSString *street;
// Other property declarations...

@end
```

## Property Naming Conventions
iQuickORMapper uses special naming conventions to map properties:
- Table and field names are separated by `99` (e.g., `adresses99customernr` maps to `adresses.customernr`).
- SQL functions use `$9` and `9$` to represent parentheses (e.g., `SUM$9offeneposten99open9$` maps to `SUM(offeneposten.open)`).

## API Reference

### iQuickORMapper
Main class that handles database operations.

#### Methods
- `initWithDatabase:withEntity:withFromTable:withJoins:withFilter:withGroupBy:withOrderBy:` - Initialize with query parameters.
- `find` - Execute query and return results.
- `save` - Insert or update entity.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.