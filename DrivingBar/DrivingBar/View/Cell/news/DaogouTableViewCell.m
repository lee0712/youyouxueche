//
//  EnrollTableViewCell.m
//  DrivingBar
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "DaogouTableViewCell.h"
#import "public.h"

@implementation DaogouTableViewCell

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
    _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    // _userImageView.image = [UIImage imageNamed:@"menu_user.png"];
    [_userImageView setContentMode:UIViewContentModeScaleToFill];
    //  _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
    //  _userImageView.clipsToBounds = YES;
    //  _userImageView.layer.borderWidth = 3.0f;
    //  _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //  _userImageView.backgroundColor = [UIColor clearColor];
    
    // 用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userImageView.frame.origin.x+_userImageView.frame.size.width+10,_userImageView.frame.origin.y, screen_width-110, 50)];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _userNameLabel.numberOfLines = 0;
    // _userNameLabel.textColor = [UIColor lightGrayColor];
    // 时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameLabel.frame.origin.x, _userImageView.frame.size.height + _userImageView.frame.origin.y - 20, 100, 15)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    //    _sorceTimeLabel.textColor = [UIColor lightGrayColor];
    // 详情
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-70, _userImageView.frame.size.height + _userImageView.frame.origin.y-20, 60, 20)];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_userImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_detailLabel];
    [self.contentView addSubview:_timeLabel];
}

- (void)initLayout
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
