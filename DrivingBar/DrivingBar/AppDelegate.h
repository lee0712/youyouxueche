//
//  AppDelegate.h
//  DrivingBar
//
//  Created by admin on 15/12/1.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property dispatch_queue_t serialQueue;

@end
