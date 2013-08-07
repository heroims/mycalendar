//
//  sqlHelp.h
//  PillRemind
//
//  Created by hero on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface sqlHelp : NSObject{
    sqlite3 *database;
    NSString *DataFile;
}

@property(nonatomic,retain)NSString *DataFile;

-(NSMutableArray*)selectSql:(NSString*)selectSql;
-(void)insertSql:(NSString*)insertSql createSql:(NSString*)createSql;
-(int)getScaraSql:(NSString*)selectSql;
-(void)updateSql:(NSString*)selectSql;

@end
