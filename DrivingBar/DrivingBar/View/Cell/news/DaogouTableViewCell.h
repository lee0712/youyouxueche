//
//  DaogouTableViewCell.h
//  DrivingBar
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaogouTableViewCell : UITableViewCell
// 用户图像
@property (nonatomic, strong) UIImageView *userImageView;
// 用户名
@property (nonatomic, strong) UILabel *userNameLabel;
// 日期
@property (nonatomic, strong) UILabel *timeLabel;
// 详情
@property (nonatomic, strong) UILabel *detailLabel;
@end
