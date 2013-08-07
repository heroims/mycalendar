//
//  sqlHelp.m
//  PillRemind
//
//  Created by hero on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "sqlHelp.h"

@implementation sqlHelp

@synthesize DataFile;

-(NSString*)databasePath
{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [path objectAtIndex:0];
	return [pathname stringByAppendingPathComponent:DataFile];
}

-(NSMutableArray*)selectSql:(NSString*)selectSql{
    @autoreleasepool {
        NSMutableArray *arrlist=[[NSMutableArray alloc] init];
        if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0,@"open database faild!");
            arrlist=nil;
        }
        
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSMutableArray *arr = [[[NSMutableArray alloc] init] autorelease];
                
                [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,0)]];
                
                [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,1)]];
                
                [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,2)]];
                
                [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,3)]];
                
                [arrlist addObject:arr];
            }
            sqlite3_finalize(statement);
        }
        
        return arrlist;
    }
    
}

-(void)insertSql:(NSString*)insertSql createSql:(NSString*)createSql{
    if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"open database faild!");
    }
    char *erroMsg;
    if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &erroMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0,@"the error is %s",erroMsg);
    }
    
    
    if (sqlite3_exec (database, [insertSql UTF8String], NULL, NULL, &erroMsg) != SQLITE_OK)
    {
        NSAssert1(0, @"Error updating tables: %s", erroMsg);
    }
}

-(int)getScaraSql:(NSString*)selectSql{
	if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0,@"open database faild!");
		return 0;
	}
    sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
		while (sqlite3_step(statement)==SQLITE_ROW) {
			int i = sqlite3_column_int(statement,0);
			sqlite3_finalize(statement);
			return i;
		}
	}
	return 0;
}

-(void)updateSql:(NSString*)selectSql{
    if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"open database faild!");
    }
    char *erroMsg;
        
    if (sqlite3_exec(database, [selectSql UTF8String], NULL, NULL, &erroMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0,@"the error is %s",erroMsg);
    }
}

-(void)dealloc{
    [DataFile release];
    [super dealloc];
}

@end
