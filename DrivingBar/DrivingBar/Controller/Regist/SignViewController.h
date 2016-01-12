//
//  SignViewController.h
//  DrivingBar
//
//  Created by admin on 15/12/15.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddDataTableViewController.h"

@interface SignViewController : UIViewController
//delegate
@property (nonatomic,assign) NSObject<PassValueDelegate> *delegate;
@property(nonatomic, strong) NSString *sign;
@end
