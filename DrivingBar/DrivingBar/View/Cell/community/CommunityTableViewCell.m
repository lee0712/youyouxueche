//
//  CommunityTableViewCell.m
//  DrivingBar
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 admin. All rights reserved.
//
#import "public.h"
#import "CommunityTableViewCell.h"

@implementation CommunityTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews
{
    // 用户图像
    _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 8, 55, 55)];
     _userImageView.image = [UIImage imageNamed:@"menu_user.png"];
    [_userImageView setContentMode:UIViewContentModeScaleToFill];
      _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
      _userImageView.clipsToBounds = YES;
    //  _userImageView.layer.borderWidth = 3.0f;
    //  _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //  _userImageView.backgroundColor = [UIColor clearColor];
   
    // 用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    
    // 用户性别
    _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userNameLabel.frame.origin.x+_userNameLabel.frame.size.width+8,_userNameLabel.frame.origin.y,_userNameLabel.frame.size.height, _userNameLabel.frame.size.height)];
     _sexImageView.image = [UIImage imageNamed:@"community_boy_im"];
    [_sexImageView setContentMode:UIViewContentModeScaleToFill];
    
    // 等级图像
    //NSLog(@"usernamelabel--%f--%f--",_userNameLabel.frame.size.width,_userNameLabel.frame.size.height);
    _levelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userNameLabel.frame.origin.x,_userNameLabel.frame.origin.y+_userNameLabel.frame.size.height+6, 20, 20)];
     _levelImageView.image = [UIImage imageNamed:@"community_jianrujiajing"];
    [_levelImageView setContentMode:UIViewContentModeScaleToFill];
    //_levelImageView.layer.cornerRadius = _levelImageView.frame.size.width/2;
    //_levelImageView.clipsToBounds = YES;
    //  _userImageView.layer.borderWidth = 3.0f;
    //  _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //  _userImageView.backgroundColor = [UIColor clearColor];
    
    // 等级
    _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(_levelImageView.frame.origin.x+_levelImageView.frame.size.width+9,_levelImageView.frame.origin.y,100,20)];
    _levelLabel.font = [UIFont systemFontOfSize:14];
    _levelLabel.text = @"初出茅庐";
    
    // 圈子
    _comLabel = [[UILabel alloc] initWithFrame:CGRectMake(_levelImageView.frame.origin.x, _levelImageView.frame.size.height + _levelImageView.frame.origin.y +13, 45, 15)];
    _comLabel.font = [UIFont systemFontOfSize:12];
    _comLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _comLabel.text = @"驾友圈";
    //    _sorceTimeLabel.textColor = [UIColor lightGrayColor];
    // 详情
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(_comLabel.frame.origin.x+_comLabel.frame.size.width+5, _comLabel.frame.origin.y, screen_width, 20)];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.text = @"这几位同学都非常多努力";
    
    // 详情图像
    float imWidth = (screen_width -_comLabel.frame.origin.x-30-20)/3;
    _detailImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_userImageView.frame.origin.x+_userImageView.frame.size.width+9,_comLabel.frame.origin.y+_comLabel.frame.size.height+10, imWidth, imWidth)];
    _detailImageView1.image = [UIImage imageNamed:@"community_detail_test.png"];
    [_detailImageView1 setContentMode:UIViewContentModeScaleToFill];
    
    _detailImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(_detailImageView1.frame.origin.x+_detailImageView1.frame.size.width+10,_comLabel.frame.origin.y+_comLabel.frame.size.height+10, imWidth, imWidth)];
    _detailImageView2.image = [UIImage imageNamed:@"community_detail_test.png"];
    [_detailImageView2 setContentMode:UIViewContentModeScaleToFill];
    
    _detailImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(_detailImageView2.frame.origin.x+_detailImageView2.frame.size.width+10,_comLabel.frame.origin.y+_comLabel.frame.size.height+10, imWidth, imWidth)];
    _detailImageView3.image = [UIImage imageNamed:@"community_detail_test.png"];
    [_detailImageView3 setContentMode:UIViewContentModeScaleToFill];
    
    // 时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_levelImageView.frame.origin.x, _detailImageView1.frame.size.height + _detailImageView1.frame.origin.y +10, 80, 15)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.text = @"27分钟前";
    
    // 地址
    _addrLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width+10, _timeLabel.frame.origin.y, 80, 15)];
    _addrLabel.font = [UIFont systemFontOfSize:12];
    _addrLabel.text = @"广州";
    
    //评论
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-20-20, _timeLabel.frame.origin.y, 40, 15)];
    _commentLabel.font = [UIFont systemFontOfSize:12];
    _commentLabel.text = @"266";
    //评论图片
    _commentImagView = [[UIImageView alloc] initWithFrame:CGRectMake(_commentLabel.frame.origin.x-15-10,_timeLabel.frame.origin.y, 15, 15)];
    _commentImagView.image = [UIImage imageNamed:@"community_pinglun"];
    [_commentImagView setContentMode:UIViewContentModeScaleToFill];
    
    //点赞
    _praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(_commentImagView.frame.origin.x-10-30, _timeLabel.frame.origin.y, 30, 15)];
    _praiseLabel.font = [UIFont systemFontOfSize:12];
    _praiseLabel.text = @"65";
    //点赞图片
    _praiseImagView = [[UIImageView alloc] initWithFrame:CGRectMake(_praiseLabel.frame.origin.x-15-10,_timeLabel.frame.origin.y, 15, 15)];
    _praiseImagView.image = [UIImage imageNamed:@"community_dianzan"];
    [_praiseImagView setContentMode:UIViewContentModeScaleToFill];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor grayColor];
    
    [self.contentView addSubview:_userImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_sexImageView];
    [self.contentView addSubview:_levelImageView];
    [self.contentView addSubview:_levelLabel];
    [self.contentView addSubview:_comLabel];
    [self.contentView addSubview:_detailLabel];
    [self.contentView addSubview:_detailImageView1];
    [self.contentView addSubview:_detailImageView2];
    [self.contentView addSubview:_detailImageView3];
    [self.contentView addSubview:_addrLabel];
    [self.contentView addSubview:_praiseImagView];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_praiseLabel];
    [self.contentView addSubview:_commentImagView];
    [self.contentView addSubview:_commentLabel];
    [self.contentView addSubview:_lineView];
}

- (void)refreshLayout
{
    
    // 用户性别
    _sexImageView.frame = CGRectMake(_userNameLabel.frame.origin.x+_userNameLabel.frame.size.width+8,_userNameLabel.frame.origin.y,_userNameLabel.frame.size.height, _userNameLabel.frame.size.height);
    // 等级图像
    _levelImageView.frame = CGRectMake(_userNameLabel.frame.origin.x,_userNameLabel.frame.origin.y+_userNameLabel.frame.size.height+6, 20, 20);
    // 等级
    _levelLabel.frame = CGRectMake(_levelImageView.frame.origin.x+_levelImageView.frame.size.width+9,_levelImageView.frame.origin.y,100,20);
    // 圈子
    _comLabel.frame = CGRectMake(_levelImageView.frame.origin.x, _levelImageView.frame.size.height + _levelImageView.frame.origin.y +13, 45, 15);
    // 详情
    _detailLabel.frame = CGRectMake(_comLabel.frame.origin.x+_comLabel.frame.size.width+5, _comLabel.frame.origin.y, screen_width, 20);
    
    // 详情图像
    float imWidth = (screen_width -_comLabel.frame.origin.x-30-20)/3;
    _detailImageView1.frame = CGRectMake(_userImageView.frame.origin.x+_userImageView.frame.size.width+9,_comLabel.frame.origin.y+_comLabel.frame.size.height+10, imWidth, imWidth);
    _detailImageView2.frame = CGRectMake(_detailImageView1.frame.origin.x+_detailImageView1.frame.size.width+10,_comLabel.frame.origin.y+_comLabel.frame.size.height+10, imWidth, imWidth);
    _detailImageView3.frame = CGRectMake(_detailImageView2.frame.origin.x+_detailImageView2.frame.size.width+10,_comLabel.frame.origin.y+_comLabel.frame.size.height+10, imWidth, imWidth);
    
    // 时间
    _timeLabel.frame = CGRectMake(_levelImageView.frame.origin.x, _detailImageView1.frame.size.height + _detailImageView1.frame.origin.y +10, 80, 15);
    // 地址
    _addrLabel.frame = CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width+10, _timeLabel.frame.origin.y, 80, 15);
    //评论
    _commentLabel.frame = CGRectMake(screen_width-20-20, _timeLabel.frame.origin.y, 40, 15);
    //评论图片
    _commentImagView.frame = CGRectMake(_commentLabel.frame.origin.x-15-10,_timeLabel.frame.origin.y, 15, 15);
    //点赞
    _praiseLabel.frame = CGRectMake(_commentImagView.frame.origin.x-10-20, _timeLabel.frame.origin.y, 20, 15);
    //点赞图片
    _praiseImagView.frame = CGRectMake(_praiseLabel.frame.origin.x-15-10,_timeLabel.frame.origin.y, 15, 15);
    //line
    _lineView.frame = CGRectMake(_timeLabel.frame.origin.x, _timeLabel.frame.origin.y+_timeLabel.frame.size.height+10, screen_width-_timeLabel.frame.origin.x, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
