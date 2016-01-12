//
//  Kemu4VIew.h
//  DrivingBar
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Kemu4View : UIView
@property(nonatomic, strong) NSString* times;
@property(nonatomic, strong) NSString* score;
@property(nonatomic, strong) NSString* pass;
- (void)setupDataSource:(NSString *)times Score:(NSString*)score Pass:(NSString*)pass;

@end
