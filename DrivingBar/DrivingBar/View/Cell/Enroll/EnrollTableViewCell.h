//
//  EnrollTableViewCell.h
//  DrivingBar
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinalStarRatingBar.h"

@interface EnrollTableViewCell : UITableViewCell


// 用户图像
@property (nonatomic, strong) UIImageView *userImageView;
// 用户图标
@property (nonatomic, strong) UIImageView *userNameImageView;

// 用户名
@property (nonatomic, strong) UILabel *userNameLabel;
// 详情
@property (nonatomic, strong) UILabel *detailLabel;
// 位置
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) FinalStarRatingBar *bar;
@end
