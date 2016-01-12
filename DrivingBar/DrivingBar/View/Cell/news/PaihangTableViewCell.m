//
//  EnrollTableViewCell.m
//  DrivingBar
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "PaihangTableViewCell.h"
#import "public.h"

@implementation PaihangTableViewCell

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
    _userNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    _userNum.font = [UIFont systemFontOfSize:15];
    _userNum.backgroundColor = RGB(241, 95, 95);
    _userNum.textColor = [UIColor whiteColor];
    
    // 用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNum.frame.origin.x+_userNum.frame.size.width+10,_userNum.frame.origin.y, screen_width-150, 20)];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
//    _userNameLabel.lineBreakMode = UILineBreakModeCharacterWrap;
//    _userNameLabel.numberOfLines = 0;
    // _userNameLabel.textColor = [UIColor lightGrayColor];

    
    //星级
    _bar = [[FinalStarRatingBar alloc] initWithFrame:CGRectMake(_userNum.frame.origin.x, _userNum.frame.size.height + _userNum.frame.origin.y + 20, 100, 20) starCount:5];
    _bar.enabled = false;
   // _bar.backgroundColor = RGB(241, 95, 95);
    
    // 详情
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-70, _bar.frame.origin.y-10, 60, 30)];
    _detailLabel.font = [UIFont systemFontOfSize:16];
    _detailLabel.textColor = RGB(241, 95, 95);
    [self.contentView addSubview:_userNum];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_detailLabel];
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
