//
//  AddDataViewController.h
//  DrivingBar
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserEntity;
@protocol PassValueDelegate
-(void)passNickName:(NSString*)value;
-(void)passTrainer:(NSString*)value;
-(void)passSign:(NSString*)value;
@end
@interface AddDataTableViewController : UITableViewController<PassValueDelegate>
@property BOOL ifFirst;
@end
