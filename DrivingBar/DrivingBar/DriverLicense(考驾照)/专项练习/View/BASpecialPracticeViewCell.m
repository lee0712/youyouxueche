//
//  BASpecialPracticeViewCell.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BASpecialPracticeViewCell.h"
#import "BAUtilities.h"

@implementation BASpecialPracticeViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initWithSubViews];
        [self initLayout];
    }
    return self;
}

- (void)initWithSubViews
{
    // 题号
    self.testNumberLable = [[UILabel alloc] init];
    self.testNumberLable.font = [UIFont systemFontOfSize:13];
    self.testNumberLable.textColor = [UIColor whiteColor];
    self.testNumberLable.backgroundColor = [UIColor redColor];
    self.testNumberLable.textAlignment = NSTextAlignmentCenter;
    self.testNumberLable.clipsToBounds = YES;
    self.testNumberLable.layer.cornerRadius = 5.0;
    
    //分类名
    self.classNameLabel = [[UILabel alloc] init];
    self.classNameLabel.font = [UIFont systemFontOfSize:13];
    self.classNameLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.testNumberLable];
    [self.contentView addSubview:self.classNameLabel];
}

- (void)initLayout
{
    for (UIView *view in [self.contentView subviews])
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_testNumberLable, _classNameLabel);
    
    // 题号
    NSString *testNumberLableH = [NSString stringWithFormat:@"H:|-%f-[_testNumberLable(20)]",(KSCREEN_WIDTH/2 - self.classNameLabel.width)/6];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:testNumberLableH options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_testNumberLable(20)]" options:0 metrics:nil views:viewDict]];
    
    //分类名
    NSString *classNameLabelH = [NSString stringWithFormat:@"H:[_testNumberLable]-5-[_classNameLabel]"];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:classNameLabelH options:0 metrics:nil views:viewDict]];

//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_testNumberLable]-10-[_classNameLabel]" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_classNameLabel(40)]" options:0 metrics:nil views:viewDict]];
}

@end
