//
//  CalView.h
//  MyCalendar
//
//  Created by hero on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalDal.h"
#import "scheduleDal.h"

@protocol CalViewDelegate <NSObject>

@required
-(void)ShowNyearMonth;

@end

@interface CalView : UIViewController{
    NSInteger year;
    NSInteger month;
    NSInteger day;
    
    NSString *Nyear;
    NSString *Nmonth;
    
    UITableView *passTable;
    NSMutableArray *passArr;
    
    CalDal *cd;
    
    NSDate *passDate;
    
    CalDal *tempcd;
    id <CalViewDelegate> delegate;
}

@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;

@property(nonatomic,retain)NSString *Nyear;
@property(nonatomic,retain)NSString *Nmonth;

@property(nonatomic,retain)UITableView *passTable;
@property(nonatomic,retain)NSMutableArray *passArr;
@property(nonatomic,retain)NSDate *passDate;

@property(nonatomic,strong)id <CalViewDelegate> delegate;

@end
