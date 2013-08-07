//
//  AppDelegate.h
//  mycalendar
//
//  Created by hero on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalVIewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    CalVIewController *calController;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *viewController;

@end
