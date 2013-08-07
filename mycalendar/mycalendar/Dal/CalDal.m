//
//  CalDal.m
//  MyCalendar
//
//  Created by hero on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalDal.h"

@implementation CalDal

@synthesize dayCyl;
@synthesize monCyl;
@synthesize year;
@synthesize yearCyl;
@synthesize month;
@synthesize day;
@synthesize isLeap;
@synthesize length;
@synthesize firstWeek;

-(id)init{
    
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd hh:mm:ss Z"];
    
    date1 = [dateFormater dateFromString:@"1900-1-31 00:00:00 +0000"];
    date2 = [dateFormater dateFromString:@"1900-1-6 02:05:00 +0000"];
    
    [dateFormater release];
        
    lunarInfo=[[NSMutableArray alloc] initWithObjects:@"19416",@"19168",@"42352",@"21717",@"53856",@"55632",@"91476",@"22176",@"39632",
               @"21970",@"19168",@"42422",@"42192",@"53840",@"119381",@"46400",@"54944",@"44450",@"38320",@"84343",@"18800",@"42160",
               @"46261",@"27216",@"27968",@"109396",@"11104",@"38256",@"21234",@"18800",@"25958",@"54432",@"59984",@"28309",@"23248",
               @"11104",@"100067",@"37600",@"116951",@"51536",@"54432",@"120998",@"46416",@"22176",@"107956",@"9680",@"37584",@"53938",
               @"43344",@"46423",@"27808",@"46416",@"86869",@"19872",@"42448",@"83315",@"21200",@"43432",@"59728",@"27296",@"44710",
               @"43856",@"19296",@"43748",@"42352",@"21088",@"62051",@"55632",@"23383",@"22176",@"38608",@"19925",@"19152",@"42192",
               @"54484",@"53840",@"54616",@"46400",@"46496",@"103846",@"38320",@"18864",@"43380",@"42160",@"45690",@"27216",@"27968",
               @"44870",@"43872",@"38256",@"19189",@"18800",@"25776",@"29859",@"59984",@"27480",@"21952",@"43872",@"38613",@"37600",
               @"51552",@"55636",@"54432",@"55888",@"30034",@"22176",@"43959",@"9680",@"37584",@"51893",@"43344",@"46240",@"47780",
               @"44368",@"21977",@"19360",@"42416",@"86390",@"21168",@"43312",@"31060",@"27296",@"44368",@"23378",@"19296",@"42726",
               @"42208",@"53856",@"60005",@"54576",@"23200",@"30371",@"38608",@"19415",@"19152",@"42192",@"118966",@"53840",@"54560",
               @"56645",@"46496",@"22224",@"21938",@"18864",@"42359",@"42160",@"43600",@"111189",@"27936",@"44448", nil];
    solarMonth=[[NSMutableArray alloc] initWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    Gan=[[NSMutableArray alloc] initWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
    Zhi=[[NSMutableArray alloc] initWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥", nil];
    Animals=[[NSMutableArray alloc] initWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪", nil];
    solarTerm=[[NSMutableArray alloc] initWithObjects:@"小寒",@"大寒",@"立春",@"雨水",@"惊蛰",@"春分",@"清明",@"谷雨",@"立夏",
                               @"小满",@"芒种",@"夏至",@"小暑",@"大暑",@"立秋",@"处暑",@"白露",@"秋分",@"寒露",@"霜降",@"立冬",@"小雪",@"大雪",@"冬至", nil];
    sTermInfo=[[NSMutableArray alloc] initWithObjects:@"0",@"21208",@"42467",@"63836",@"85337",@"107014",@"128867",
                               @"150921",@"173149",@"195551",@"218072",@"240693",@"263343",@"285989",@"308563",@"331033",@"353350",
                               @"375494",@"397447",@"419210",@"440795",@"462224",@"483532",@"504758", nil];
    nStr1=[[NSMutableArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十", nil];
    nStr2=[[NSMutableArray alloc] initWithObjects:@"初",@"十",@"廿",@"卅",@"　", nil];
    monthName=[[NSMutableArray alloc] initWithObjects:@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊", nil];

    //国历节日 *表示放假日
    sFtvD=[[NSMutableArray alloc] initWithObjects:@"0101",
           @"0214",
           @"0308",
           @"0312",
           @"0315",
           @"0401",
           @"0501",
           @"0504",
           @"0512",
           @"0601",
           @"0701",
           @"0801",
           @"0808",
           @"0909",
           @"0910",
           @"0928",
           @"1001",
           @"1006",
           @"1024",
           @"1112",
           @"1220",
           @"1225",
           @"1226", nil];
    sFtv=[[NSMutableArray alloc] initWithObjects:@"元旦",
                          @"情人节",
                          @"妇女节",
                          @"植树节",
                          @"消费者权益日",
                          @"愚人节",
                          @"劳动节",
                          @"青年节",
                          @"护士节",
                          @"儿童节",
                          @"建党节",
                          @"建军节",
                          @"父亲节",
                          @"毛泽东逝世纪念",
                          @"教师节",
                          @"孔子诞辰",
                          @"国庆节",
                          @"老人节",
                          @"联合国日",
                          @"孙中山诞辰",
                          @"澳门回归",
                          @"圣诞节",
                          @"毛泽东诞辰", nil];
    //农历节日 *表示放假日
    lFtvD=[[NSMutableArray alloc] initWithObjects:@"0101",
           @"0115",
           @"0505",
           @"0707",
           @"0815",
           @"0909",
           @"1208",
           @"1224",
           @"0100", nil];
    lFtv=[[NSMutableArray alloc] initWithObjects:@"农历春节",
                          @"元宵节",
                          @"端午节",
                          @"七夕情人节",
                          @"中秋节",
                          @"重阳节",
                          @"腊八节",
                          @"小年",
                          @"除夕", nil];
    //某月的第几个星期几
    wFtv=[[NSMutableArray alloc] initWithObjects:@"0520 母亲节", nil];
    
    return self;
}

//====================================== 传回农历 y年的总天数
-(NSInteger)lYearDays:(NSInteger)y {
    NSInteger i, sum = 348;
    for(i=32768; i>8; i>>=1) {
        sum += ([[lunarInfo objectAtIndex:y-1900] integerValue] & i)? 1: 0;
    }
    return (sum+[self leapDays:y]);
}

//====================================== 传回农历 y年闰月的天数
-(NSInteger)leapDays:(NSInteger)y {
    if([self leapMonth:y])  
    {
        return(([[lunarInfo objectAtIndex:y-1900] integerValue] & 65536)? 30: 29);
    }
    else {
        return 0;
    }
}

//====================================== 传回农历 y年闰哪个月 1-12 , 没闰传回 0
-(NSInteger)leapMonth:(NSInteger)y {
    
    return([[lunarInfo objectAtIndex:y-1900] integerValue] & 15);
}

//====================================== 传回农历 y年m月的总天数
-(NSInteger)monthDays:(NSInteger)y m:(NSInteger)m {
    return( ([[lunarInfo objectAtIndex:y-1900] integerValue] & (65536>>m))? 30: 29 );
}

//====================================== 传回天数 日期天数差
-(NSInteger)muDateToDate:(NSDate*)startDate enddate:(NSDate*)endDate{    
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate toDate:endDate  options:0];
    return [comps day];
}

//====================================== 算出农历, 传入日期物件, 传回农历日期物件
-(void)Lunar:(NSDate*)objDate {
    
    NSInteger i, leap=0, temp=0;
    NSDate *baseDate = date1;
    NSInteger offset   = [self muDateToDate:baseDate enddate:objDate];
    dayCyl = offset + 40;
    monCyl = 14;
    
    for(i=1900; i<2050 && offset>0; i++) {
        temp = [self lYearDays:i];
        offset -= temp;
        monCyl += 12;
    }
    
    if(offset<0) {
        offset += temp;
        i--;
        monCyl -= 12;
    }
    
    year = i;
    yearCyl = i-1864;
    
    leap = [self leapMonth:i]; //闰哪个月
    isLeap = false;
    
    for(i=1; i<13 && offset>0; i++) {
        //闰月
        if(leap>0 && i==(leap+1) && isLeap==false)
        { --i; isLeap = true; temp = [self leapDays:year]; }
        else
        { temp = [self monthDays:year m:i]; }
        
        //解除闰月
        if(isLeap==true && i==(leap+1)) isLeap = false;
            
        offset -= temp;
        if(isLeap == false) monCyl ++;
                }
    
    if(offset==0 && leap>0 && i==leap+1)
        if(isLeap)
        { isLeap = false; }
        else
        { isLeap = true; --i; --monCyl;}
    
    if(offset<0){ offset += temp; --i; --monCyl; }
    
    month = i;
    day = offset + 1;
}

//==============================传回国历 y年某m月的天数
-(NSInteger)solarDays:(NSInteger)y m:(NSInteger)m {
    m-=1;
    if(m==1)
        return((((y%4==0) && (y%100!=0))||(y%400 == 0))?29:28);
        else
            return([[solarMonth objectAtIndex:m] integerValue]);

}

//============================== 传入 offset 传回干支, 0=甲子 num-1900+36
-(NSString*)cyclical:(NSInteger)num {
    return([[Gan objectAtIndex:num%10] stringByAppendingString:[Zhi objectAtIndex:num%12]]);
}


//===== 某年的第n个节气为几日(从0小寒起算)
-(NSInteger)sTerm:(NSInteger)y n:(NSInteger)n {
    NSDate *offDate=[[NSDate alloc] initWithTimeInterval:( 31556925.9747*(y-1900) + [[sTermInfo objectAtIndex:n] integerValue]*60  ) sinceDate:date2];
    NSUInteger unitFlags=NSDayCalendarUnit;
	NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *now=[calendar components:unitFlags fromDate:offDate];
    [offDate release];
    [calendar release];
    return [now day];
}

//====================== 中文日期
-(NSString*)cDay:(int)d{
    NSString *s;
    
    switch (d) {
        case 10:
            s = @"初十"; break;
        case 20:
            s = @"二十"; break;
            break;
        case 30:
            s = @"三十"; break;
            break;
        default :
            s = [nStr2 objectAtIndex:floor(d/10)];
            s =[s stringByAppendingString:[nStr1 objectAtIndex:d%10]];
    }
    return s;
}

//====================== 中文月份
-(NSString*)cMonth{
    return [monthName objectAtIndex:month-1];
}

//====================== 公历节日
-(NSString*)Mfestival:(NSInteger)m d:(NSInteger)d{
    for (int i=0; i<[sFtvD count]; i++) {
        if ([[sFtvD objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%02d%02d",m,d]]) {
            return [sFtv objectAtIndex:i];
        }
    }
    return nil;
}

//====================== 黑色星期五
-(NSString*)BlackFridyFestival:(NSInteger)d{
    if (d==13&&d%7==5) {
        return @"黑色星期五";
    }
    return nil;
}

//====================== 母亲节
-(NSString*)MotherFestival:(NSInteger)y m:(NSInteger)m d:(NSInteger)d{
    if (m==5) {
        if ((1+(7-[self firstWeekMonth:y m:m])+7+1)==d) {
            return @"母亲节";
        } 
    }
    return nil;
}

//====================== 农历节日
-(NSString*)CMfestival:(NSInteger)m d:(NSInteger)d{
    for (int i=0; i<[lFtvD count]; i++) {
        if ([[lFtvD objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%02d%02d",m,d]]) {
            return [lFtv objectAtIndex:i];
        }
    }
    return nil;
}

//====================== 24节气
-(NSString*)STermDay:(NSInteger)y m:(NSInteger)m d:(NSInteger)d{
    NSMutableArray *dayArr=[[[NSMutableArray alloc] init] autorelease];
    for (int i=0; i<24; i++) {
        [dayArr addObject:[NSString stringWithFormat:@"%ld",[self sTerm:y n:i]]];
    }
    if ([[dayArr objectAtIndex:m*2-2] integerValue]==d) {
        return [solarTerm objectAtIndex:m*2-2];
    }
    if ([[dayArr objectAtIndex:m*2-1] integerValue]==d) {
        return [solarTerm objectAtIndex:m*2-1];
    }
    
    return nil;
}

//====================== 第一天周几
-(NSInteger)firstWeekMonth:(NSInteger)y m:(NSInteger)m{
    NSDateFormatter* dateFormater = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormater setDateFormat:@"yyyy-MM-dd hh:mm:ss Z"];
    
    NSDate *tempdate = [dateFormater dateFromString:[NSString stringWithFormat:@"%ld-%ld-1 00:00:00 +0000",y,m]];
    NSUInteger unitFlags=NSWeekdayCalendarUnit;
	NSCalendar *calendar=[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDateComponents *now=[calendar components:unitFlags fromDate:tempdate];
    
    return [now weekday];
}

//====================== 返回农历属相
-(NSString*)CAnimals:(NSInteger)y{
    return [Animals objectAtIndex:(y-4)%12];
}

-(void)dealloc{
    [lunarInfo release];
    [solarMonth release];
    [Gan release];
    [Zhi release];
    [Animals release];
    [solarTerm release];
    [sTermInfo release];
    [nStr1 release];
    [nStr2 release];
    [monthName release];
    [sFtv release];
    [lFtv release];
    [wFtv release];
    
    [date1 release];
    [date2 release];
    
    [super dealloc];
}

@end
