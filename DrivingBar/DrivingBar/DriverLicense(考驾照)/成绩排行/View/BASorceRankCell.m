//
//  BASorceRankCell.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BASorceRankCell.h"
#import "BAUtilities.h"

@implementation BASorceRankCell

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
    _userImageView = [[UIImageView alloc] init];
    _userImageView.frame = CGRectMake(10, 5, 40, 40);
    _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
    _userImageView.clipsToBounds = YES;
    _userImageView.layer.borderWidth = 3.0f;
    _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _userImageView.backgroundColor = [UIColor clearColor];
    
    // 用户名
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:16];
    _userNameLabel.textColor = [UIColor lightGrayColor];
    
    // 分数
    _sorceLabel = [[UILabel alloc] init];
    _sorceLabel.font = [UIFont systemFontOfSize:14];
    _sorceLabel.numberOfLines = 0;
    
    // 时间
    _sorceTimeLabel = [[UILabel alloc] init];
    _sorceTimeLabel.font = [UIFont systemFontOfSize:14];
//    _sorceTimeLabel.textColor = [UIColor lightGrayColor];
    
    // 排名
    _sorceRankLabel = [[UILabel alloc] init];
    _sorceRankLabel.font = [UIFont systemFontOfSize:14];
//    _sorceRankLabel.textColor = [UIColor lightGrayColor];
    _sorceRankLabel.textAlignment = NSTextAlignmentRight;
    
    // 横线
    _hView = [[UIView alloc] init];
    _hView.backgroundColor = COLOR_C(240, 240, 240, 1.0);
    
    [self.contentView addSubview:_userImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_sorceLabel];
    [self.contentView addSubview:_sorceTimeLabel];
    [self.contentView addSubview:_sorceRankLabel];
    [self.contentView addSubview:_hView];
}

- (void)initLayout
{
    for (UIView *view in [self.contentView subviews])
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_userImageView, _userNameLabel, _sorceLabel, _sorceTimeLabel, _sorceRankLabel, _hView);
    
    // 用户图像
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_userImageView(40)]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_userImageView(40)]" options:0 metrics:nil views:viewDict]];
    
    // 用户名
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-5-[_userNameLabel(200)]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_userNameLabel(20)]" options:0 metrics:nil views:viewDict]];
    
    // 分数
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-5-[_sorceLabel(50)]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sorceLabel(20)]-5-|" options:0 metrics:nil views:viewDict]];
    
    // 时间
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sorceLabel]-5-[_sorceTimeLabel(70)]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sorceTimeLabel(20)]-5-|" options:0 metrics:nil views:viewDict]];
    
    // 排名
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sorceRankLabel(60)]-20-|" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sorceRankLabel(30)]-10-|" options:0 metrics:nil views:viewDict]];
    
    // 横线
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_hView]-0-|" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_hView(1)]-0-|" options:0 metrics:nil views:viewDict]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
