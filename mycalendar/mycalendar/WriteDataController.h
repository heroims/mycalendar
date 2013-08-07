//
//  WriteDataController.h
//  MyCalendar
//
//  Created by hero on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "scheduleDal.h"

@interface WriteDataController : UIViewController<UIAlertViewDelegate,UITextViewDelegate>{
    UITextField *txtTitle;
    UITextView *txtContext;
    UIDatePicker *picker;
    UIView *calTempView;
    NSDateComponents *now;
    NSString *deletekey;
    NSMutableArray *passArr;
    bool isNoInsert;
}

@property(nonatomic,retain)NSString *deletekey;
@property(nonatomic,retain)NSMutableArray *passArr;
@property(nonatomic,assign)bool isNoInsert;

@end
