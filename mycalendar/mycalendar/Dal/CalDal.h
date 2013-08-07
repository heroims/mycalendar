//
//  CalDal.h
//  MyCalendar
//
//  Created by hero on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalDal : NSObject{
    NSMutableArray *lunarInfo;
    NSMutableArray *solarMonth;
    NSMutableArray *Gan;
    NSMutableArray *Zhi;
    NSMutableArray *Animals;
    NSMutableArray *solarTerm;
    NSMutableArray *sTermInfo;
    NSMutableArray *nStr1;
    NSMutableArray *nStr2;
    NSMutableArray *monthName;
    NSMutableArray *sFtv;
    NSMutableArray *sFtvD;
    NSMutableArray *lFtv;
    NSMutableArray *lFtvD;
    NSMutableArray *wFtv;
    
    NSInteger dayCyl;
    NSInteger monCyl;
    NSInteger year;
    NSInteger yearCyl;
    NSInteger month;
    NSInteger day;
    bool isLeap;
    NSInteger length;
    NSInteger firstWeek;
    
    NSDate *date1;
    NSDate *date2;
}
@property(nonatomic,assign) NSInteger dayCyl;
@property(nonatomic,assign) NSInteger monCyl;
@property(nonatomic,assign) NSInteger year;
@property(nonatomic,assign) NSInteger yearCyl;
@property(nonatomic,assign) NSInteger month;
@property(nonatomic,assign) NSInteger day;
@property(nonatomic,assign)bool isLeap;
@property(nonatomic,assign)NSInteger length;
@property(nonatomic,assign)NSInteger firstWeek;

-(NSInteger)lYearDays:(NSInteger)y;
-(NSInteger)leapDays:(NSInteger)y;
-(NSInteger)leapMonth:(NSInteger)y;
-(NSInteger)monthDays:(NSInteger)y m:(NSInteger)m;
-(void)Lunar:(NSDate*)objDate;
-(NSInteger)solarDays:(NSInteger)y m:(NSInteger)m;
-(NSString*)cyclical:(NSInteger)num;
-(NSInteger)sTerm:(NSInteger)y n:(NSInteger)n ;
-(NSString*)cDay:(int)d;
-(NSString*)cMonth;
-(NSInteger)firstWeekMonth:(NSInteger)y m:(NSInteger)m;
-(NSString*)CMfestival:(NSInteger)m d:(NSInteger)d;
-(NSString*)Mfestival:(NSInteger)m d:(NSInteger)d;
-(NSString*)BlackFridyFestival:(NSInteger)d;
-(NSString*)MotherFestival:(NSInteger)y m:(NSInteger)m d:(NSInteger)d;
-(NSString*)STermDay:(NSInteger)y m:(NSInteger)m d:(NSInteger)d;
-(NSString*)CAnimals:(NSInteger)y;

@end
