//
//  NickNameViewController.h
//  DrivingBar
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddDataTableViewController.h"

@interface NickNameViewController : UIViewController
//delegate
@property (nonatomic,assign) NSObject<PassValueDelegate> *delegate;
@property(nonatomic, strong) NSString *nickName;
@end
