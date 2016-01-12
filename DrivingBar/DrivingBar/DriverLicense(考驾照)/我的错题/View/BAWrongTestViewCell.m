//
//  BAWrongTestViewCell.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BAWrongTestViewCell.h"
#import "BAUtilities.h"

@implementation BAWrongTestViewCell

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
    // 前面序号
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.font = [UIFont systemFontOfSize:14];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.backgroundColor = [UIColor redColor];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.clipsToBounds = YES;
    self.numberLabel.layer.cornerRadius = 5.0;
    
    // 内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    self.contentLabel.numberOfLines = 0;
    
    // 题数
    self.contentNumberLabel = [[UILabel alloc] init];
    self.contentNumberLabel.font = [UIFont systemFontOfSize:16];
    self.contentNumberLabel.numberOfLines = 0;
    self.contentNumberLabel.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.contentNumberLabel];
}

- (void)initLayout
{
    for (UIView *view in [self.contentView subviews])
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_numberLabel, _contentLabel, _contentNumberLabel);
    
    // 前面序号
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_numberLabel(20)]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_numberLabel(20)]" options:0 metrics:nil views:viewDict]];
    
    // 内容
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_numberLabel]-10-[_contentLabel]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_contentLabel(40)]" options:0 metrics:nil views:viewDict]];

    // 题数
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_contentLabel]-0-[_contentNumberLabel(50)]-5-|" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_contentNumberLabel(40)]" options:0 metrics:nil views:viewDict]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
