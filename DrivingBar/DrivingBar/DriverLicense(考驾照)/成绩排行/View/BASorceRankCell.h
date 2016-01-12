//
//  BASorceRankCell.h
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASorceRankCell : UITableViewCell


// 用户图像
@property (nonatomic, strong) UIImageView *userImageView;
// 用户名
@property (nonatomic, strong) UILabel *userNameLabel;
// 分数
@property (nonatomic, strong) UILabel *sorceLabel;
// 时间
@property (nonatomic, strong) UILabel *sorceTimeLabel;
// 排名
@property (nonatomic, strong) UILabel *sorceRankLabel;
// 横线
@property (nonatomic, strong) UIView *hView;


@end
