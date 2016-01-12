//
//  CommunityTableViewCell.h
//  DrivingBar
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityTableViewCell : UITableViewCell
// 用户图像
@property (nonatomic, strong) UIImageView *userImageView;
// 用户名
@property (nonatomic, strong) UILabel *userNameLabel;
// 性别
@property (nonatomic, strong) UIImageView *sexImageView;
// 等级图像
@property (nonatomic, strong) UIImageView *levelImageView;
// 等级
@property (nonatomic, strong) UILabel *levelLabel;
// 圈子
@property (nonatomic, strong) UILabel *comLabel;
// 详情
@property (nonatomic, strong) UILabel *detailLabel;
// 图片
@property (nonatomic, strong) UIImageView *detailImageView1;
@property (nonatomic, strong) UIImageView *detailImageView2;
@property (nonatomic, strong) UIImageView *detailImageView3;
// 日期
@property (nonatomic, strong) UILabel *timeLabel;
// 地址
@property (nonatomic, strong) UILabel *addrLabel;
// 点赞
@property (nonatomic, strong) UIImageView *praiseImagView;
@property (nonatomic, strong) UILabel *praiseLabel;
// 评论
@property (nonatomic, strong) UIImageView *commentImagView;
@property (nonatomic, strong) UILabel *commentLabel;
//line
@property (nonatomic, strong) UIView *lineView;

//刷新layout
- (void)refreshLayout;
@end
