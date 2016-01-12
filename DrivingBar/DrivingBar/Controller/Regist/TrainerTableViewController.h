//
//  TrainerTableViewController.h
//  DrivingBar
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "AddDataTableViewController.h"
#import <UIKit/UIKit.h>

@interface TrainerTableViewController : UITableViewController
//delegate
@property (nonatomic,assign) NSObject<PassValueDelegate> *delegate;

@end
