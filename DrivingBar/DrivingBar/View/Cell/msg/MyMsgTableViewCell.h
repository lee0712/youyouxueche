//
//  MyMsgTableViewCell.h
//  DrivingBar
//
//  Created by admin on 15/12/29.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMsgTableViewCell : UITableViewCell

// 用户图像
@property (nonatomic, strong) UIImageView *userImageView;
// 评论
@property (nonatomic, strong) UILabel *userCommentLabel;
// 日期
@property (nonatomic, strong) UILabel *timeLabel;
// 详情
@property (nonatomic, strong) UILabel *detailLabel;
@end
