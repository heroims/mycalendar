//
//  scheduleDal.h
//  MyCalendar
//
//  Created by hero on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlHelp.h"
#define TableName @"scheduleTab"

@interface scheduleDal : NSObject{
    sqlHelp *SH;
}

-(void)insertScheduleList:(NSString*)title context:(NSString*)context dateKey:(NSString*)dateKey;
-(void)deleteScheduleList:(NSString*)deleteKey;
-(NSMutableArray*)selectSql:(NSString*)dateKey;
-(void)updateScheduleList:(NSString*)title context:(NSString*)context dateKey:(NSString*)dateKey scheduleKey:(NSString*)scheduleKey;
-(int)getScaraSql;

@end
