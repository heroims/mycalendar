//
//  scheduleDal.m
//  MyCalendar
//
//  Created by hero on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "scheduleDal.h"

@implementation scheduleDal

-(void)insertScheduleList:(NSString*)title context:(NSString*)context dateKey:(NSString*)dateKey{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
    [dateFormatter setDateFormat:@"yyyyMMddHHmmsssss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(title TEXT,context TEXT,dateKey TEXT,scheduleKey TEXT)",TableName];
    NSString *insertUser = [NSString stringWithFormat:@"INSERT INTO %@(title,context,dateKey,scheduleKey) VALUES('%@','%@','%@','%@')",TableName,title,context,dateKey,dateString];
    [SH insertSql:insertUser createSql:createSQL];
}

-(void)updateScheduleList:(NSString*)title context:(NSString*)context dateKey:(NSString*)dateKey scheduleKey:(NSString*)scheduleKey{
    int i=0;
    i=[self getScaraSql];
    if (i!=0) {
        NSString *deleteSQL = [NSString stringWithFormat:@"update %@ set title='%@' where scheduleKey='%@'",TableName,title,scheduleKey];
        [SH updateSql:deleteSQL];
        deleteSQL = [NSString stringWithFormat:@"update %@ set context='%@' where scheduleKey='%@'",TableName,context,scheduleKey];
        [SH updateSql:deleteSQL];
        deleteSQL = [NSString stringWithFormat:@"update %@ set dateKey='%@' where scheduleKey='%@'",TableName,dateKey,scheduleKey];
        [SH updateSql:deleteSQL];
    }
}

-(void)deleteScheduleList:(NSString*)deleteKey{
    int i=0;
    i=[self getScaraSql];
    if (i!=0) {
        NSString *deleteSQL = [NSString stringWithFormat:@"delete from %@ where scheduleKey='%@'",TableName,deleteKey];
        [SH updateSql:deleteSQL];
    }
}

-(NSMutableArray*)selectSql:(NSString*)dateKey{
    NSString *countSQL = [NSString stringWithFormat:@"SELECT title,context,dateKey,scheduleKey FROM %@ where dateKey='%@'",TableName,dateKey];
    return [SH selectSql:countSQL];
}

-(int)getScaraSql{
    return [SH getScaraSql:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@",TableName]];
}

-(id)init{
    SH=[[sqlHelp alloc] init];
    SH.DataFile=@"schedule.db";
    return self;
}

-(void)dealloc{
    [SH release];
    [super dealloc];
}

@end
