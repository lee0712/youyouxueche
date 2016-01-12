//
//  PaihangTableViewCell.h
//  DrivingBar
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "FinalStarRatingBar.h"
#import <UIKit/UIKit.h>

@interface PaihangTableViewCell : UITableViewCell
// 用户图像
@property (nonatomic, strong) UILabel *userNum;
// 用户名
@property (nonatomic, strong) UILabel *userNameLabel;
// 评级
@property (nonatomic, strong) FinalStarRatingBar *bar;
// 详情
@property (nonatomic, strong) UILabel *detailLabel;
@end
