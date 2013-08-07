//
//  CalVIewController.h
//  MyCalendar
//
//  Created by hero on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteDataController.h"
#import "CalView.h"
#import "scheduleDal.h"

@interface CalVIewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CalViewDelegate>{
    UITableView *comment;
    UIView *calBackground;
    CalView *calView;
    UIDatePicker *picker;
    UIView *calTempView;
    WriteDataController *wdc;
    UILabel *lblyear;
    WriteDataController *detailViewController;
    UIView *tempview;
    UIView *aboutView;
}

@end
