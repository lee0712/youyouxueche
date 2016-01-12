//
//  EnrollTableViewCell.m
//  DrivingBar
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "EnrollTableViewCell.h"

@implementation EnrollTableViewCell

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
    _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 70, 70)];
    _userImageView.image = [UIImage imageNamed:@"menu_user.png"];
    [_userImageView setContentMode:UIViewContentModeScaleToFill];
  //  _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
  //  _userImageView.clipsToBounds = YES;
  //  _userImageView.layer.borderWidth = 3.0f;
  //  _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _userImageView.backgroundColor = [UIColor clearColor];
    
    
    //用户图标图像
    _userNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userImageView.frame.origin.x+_userImageView.frame.size.width+36,_userImageView.frame.origin.y, 20, 20)];
    _userNameImageView.image = [UIImage imageNamed:@"menu_user.png"];
    [_userNameImageView setContentMode:UIViewContentModeScaleToFill];
    
    
    // 用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameImageView.frame.origin.x+_userNameImageView.frame.size.width+10,_userNameImageView.frame.origin.y, 100, 20)];
    _userNameLabel.font = [UIFont systemFontOfSize:16];
   // _userNameLabel.textColor = [UIColor lightGrayColor];
    
    // 详情
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameImageView.frame.origin.x, _userNameLabel.frame.size.height + _userNameLabel.frame.origin.y+8, 100, 20)];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    
    //星级
    _bar = [[FinalStarRatingBar alloc] initWithFrame:CGRectMake(_detailLabel.frame.origin.x+_detailLabel.frame.size.width+10, _detailLabel.frame.origin.y, 100, 20) starCount:5];
    _bar.enabled = false;
    
    
    // 位置
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameImageView.frame.origin.x, _detailLabel.frame.size.height + _detailLabel.frame.origin.y+8, 100, 20)];
    _locationLabel.font = [UIFont systemFontOfSize:12];
    //    _sorceTimeLabel.textColor = [UIColor lightGrayColor];

    [self.contentView addSubview:_userImageView];
    [self.contentView addSubview:_userNameImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_detailLabel];
    [self.contentView addSubview:_locationLabel];
    [self.contentView addSubview:_bar];
 
}

- (void)initLayout
{
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
