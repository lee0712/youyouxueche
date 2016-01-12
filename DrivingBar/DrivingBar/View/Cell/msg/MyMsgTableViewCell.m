//
//  MyMsgTableViewCell.m
//  DrivingBar
//
//  Created by admin on 15/12/29.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "MyMsgTableViewCell.h"
#import "public.h"

@implementation MyMsgTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initWithSubViews];
        [self initLayout];
    }
    return self;
}

- (void)initWithSubViews
{
    // 用户图像
    _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
    // _userImageView.image = [UIImage imageNamed:@"menu_user.png"];
    [_userImageView setContentMode:UIViewContentModeScaleToFill];
    //  _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
    //  _userImageView.clipsToBounds = YES;
    //  _userImageView.layer.borderWidth = 3.0f;
    //  _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //  _userImageView.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(70, 10, screen_width-80, 60)];
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"msg_backim.9.png"]];
    backImage.frame = CGRectMake(0, 10, screen_width-80, 60);
    [backView addSubview:backImage];
    
    // 评论
    _userCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,15, backView.frame.size.width-20, 20)];
    _userCommentLabel.font = [UIFont systemFontOfSize:14];
    // _userNameLabel.textColor = [UIColor lightGrayColor];
    // 时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userCommentLabel.frame.origin.x, _userCommentLabel.frame.size.height + _userCommentLabel.frame.origin.y+5, 100, 15)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    //    _sorceTimeLabel.textColor = [UIColor lightGrayColor];
    // 详情
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width-80, _timeLabel.frame.origin.y, 60, 20)];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textColor = RGB_BACKGROUND_COLOR_BLUE;

    self.contentView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [self.contentView addSubview:_userImageView];
    [backView addSubview:_userCommentLabel];
    [backView addSubview:_detailLabel];
    [backView addSubview:_timeLabel];
    [self.contentView addSubview:backView];
}

- (void)initLayout
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
