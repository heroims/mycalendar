//
//  CalView.m
//  MyCalendar
//
//  Created by hero on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalView.h"

@implementation CalView

@synthesize year;
@synthesize month;
@synthesize day;

@synthesize Nyear;
@synthesize Nmonth;

@synthesize passTable;
@synthesize passArr;
@synthesize passDate;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.view.backgroundColor=[UIColor whiteColor];
    
    for (UIView *str in self.view.subviews) {
		[str removeFromSuperview];
	}
    
    UIImageView *cal=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    [cal setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",month]]];
    [self.view addSubview:cal];
    [cal release];
    
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd hh:mm:ss Z"];
    passDate=[dateFormater dateFromString:[NSString stringWithFormat:@"%d-%d-1 00:00:00 +0000",year,month]];
    NSLog(@"%@",passDate);
    cd=[[CalDal alloc] init];
    Nyear=[NSString stringWithFormat:@"%@ %@ 年",[cd cyclical:year-1900+36],[cd CAnimals:year]];
    
    [cd Lunar:passDate];
   
    Nmonth=[NSString stringWithFormat:@"%@%@月",[cd isLeap]?@"闰":@"",[cd cMonth]];
    
//    UIImageView *calMonth=[[UIImageView alloc] initWithFrame:CGRectMake(210, 125, 100, 30)];
//    [calMonth setImage:[UIImage imageNamed:[NSString stringWithFormat:@"月份%d.png",month]]];
//    [self.view addSubview:calMonth];
//    [calMonth release];
    
    @autoreleasepool {
        NSUInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
        NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *now=[calendar components:unitFlags fromDate:[NSDate date]];
        
        int cmonth=cd.month;
        int firstX=[cd firstWeekMonth:year m:month];
        int y=0;
        int x=(firstX-1)*46;
        int m=1;
        int cM=cd.day+1;
        for (int i=firstX; i<firstX+[cd solarDays:year m:month]; i++) {
            
            UIView *btn=[[UIView alloc] initWithFrame:CGRectMake(x, y, 46, 25)];
            btn.tag=100+m;
            btn.backgroundColor=[UIColor clearColor];
            UIButton *btnBack=[UIButton buttonWithType:UIButtonTypeCustom];
            btnBack.frame=CGRectMake(8, 0, 32, 25);
            btnBack.tag=m;
            [btnBack addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn addSubview:btnBack];
            if (m==day) {
                [btnBack setImage:[UIImage imageNamed:@"日期按钮0.png"] forState:UIControlStateNormal];
            }
            if (m==[now day]&&month==[now month]&&year==[now year]) {
                [btnBack setImage:[UIImage imageNamed:@"日期按钮.png"] forState:UIControlStateNormal];
            }
            
            UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 46, 15)];
            [lbl1 setTextAlignment:UITextAlignmentCenter];
            [lbl1 setFont:[UIFont systemFontOfSize:15]];
            lbl1.text=[NSString stringWithFormat:@"%d",m++];
            lbl1.backgroundColor=[UIColor clearColor];
            [btn addSubview:lbl1];
            
            int monthC=[cd leapMonth:year];
            
            int assin=0;
            
            if (cM>(cd.isLeap?[cd leapDays:year]:[cd monthDays:year m:cmonth])) {
                cM=1;
                
                
                
                if (assin==0) {
                    if (cmonth==monthC) {
                        assin+=1;
                        cmonth-=1;
                    }
                }
                cmonth+=1;


                if (cmonth>12) {
                    cmonth=1;
                }
                if (cmonth<1) {
                    cmonth=13;
                }
            }
            UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(0, 15, 46, 10)];
            [lbl2 setTextAlignment:UITextAlignmentCenter];
            [lbl2 setFont:[UIFont systemFontOfSize:10]];
            lbl2.text=[NSString stringWithFormat:@"%@",[cd cDay:cM]];
            if ([cd Mfestival:month d:m-1]!=nil) {
                lbl2.text=[cd Mfestival:month d:m-1];
            }
            if ([cd CMfestival:cmonth d:cM]!=nil) {
                lbl2.text=[cd CMfestival:cmonth d:cM];
            }
            if ([cd BlackFridyFestival:m-1]!=nil) {
                lbl2.text=[cd BlackFridyFestival:m-1];
            }
            if ([cd STermDay:year m:month d:m-1]!=nil) {
                lbl2.text=[cd STermDay:year m:month d:m-1];
            }
            if ([cd MotherFestival:year m:month d:m-1]!=nil) {
                lbl2.text=[cd MotherFestival:year m:month d:m-1];
            }
            lbl2.backgroundColor=[UIColor clearColor];
            [btn addSubview:lbl2];
            
            cM+=1;
            
            [self.view addSubview:btn];

            
            x+=46;
            if (i%7==0) {
                x=0;
                y+=25;
            }
            
            if (i%7==0||i%7==1) {
                lbl1.textColor=[UIColor redColor];
                lbl2.textColor=[UIColor redColor];
            }
        }
    } 
    [self.delegate ShowNyearMonth];
    [super viewDidLoad];
    
    [dateFormater release];
}

-(void)showRicheng:(NSString*)dateKey{
    scheduleDal *sd=[[scheduleDal alloc] init];
    passArr=[sd selectSql:dateKey];
    [sd release];
}

-(void)btnBackClick:(id)sender{
    for (UIView *btn in self.view.subviews) {
        if (btn.tag!=0) {
            [((UIButton*)[btn.subviews objectAtIndex:0]) setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    [(UIButton*)sender setBackgroundImage:[UIImage imageNamed:@"日期按钮0.png"] forState:UIControlStateNormal];

    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd hh:mm:ss Z"];
    passDate=[dateFormater dateFromString:[NSString stringWithFormat:@"%d-%d-%d 00:00:00 +0000",year,month,[(UIButton*)sender tag]]];   
    
       
    tempcd=[[CalDal alloc] init];
    [tempcd Lunar:passDate];
    Nyear=[NSString stringWithFormat:@"%@ %@ 年",[tempcd cyclical:year-1900+36],[tempcd CAnimals:year]]; 
    Nmonth=[NSString stringWithFormat:@"%@%@月",[tempcd isLeap]?@"闰":@"",[tempcd cMonth]];
   
    [self.delegate ShowNyearMonth];
    
    [self showRicheng:[NSString stringWithFormat:@"%04d年%02d月%02d日",year,month,[(UIButton*)sender tag]]];
    [passTable reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [tempcd release];
    [passDate release];
    [passArr release];
    [passTable release];
    [cd release];
    [Nyear release];
    [Nmonth release];
    [super dealloc];
}
@end
