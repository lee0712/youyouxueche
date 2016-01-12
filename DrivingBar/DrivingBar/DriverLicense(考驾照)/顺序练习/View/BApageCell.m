//
//  BApageCell.m
//  博爱答题
//
//  Created by boai on 15/12/8.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BApageCell.h"
#import "BAUtilities.h"

@implementation BApageCell

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
    /**
     *  选项字母ABCD
     */
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.frame = CGRectMake(20, 10, 30, 30);
    _numberLabel.layer.cornerRadius = _numberLabel.frame.size.width / 2;
    _numberLabel.clipsToBounds = YES;
    _numberLabel.backgroundColor = COLOR_C(186, 186, 186, 1.0);
    _numberLabel.font = [UIFont systemFontOfSize:18];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.numberOfLines = 0;
    
    /**
     *  内容
     */
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_numberLabel];
    [self.contentView addSubview:_contentLabel];
}

- (void)initLayout
{
    for (UIView *view in [self.contentView subviews])
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_numberLabel, _contentLabel);
    
    /**
     *  选项字母ABCD
     */
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_numberLabel(30)]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_numberLabel(30)]" options:0 metrics:nil views:viewDict]];
    
    /**
     *  内容
     */
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_numberLabel]-5-[_contentLabel]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_contentLabel(30)]" options:0 metrics:nil views:viewDict]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
