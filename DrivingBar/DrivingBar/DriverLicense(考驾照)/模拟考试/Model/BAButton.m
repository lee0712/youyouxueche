//
//  BAButton.m
//  优优学车
//
//  Created by boai on 15/12/11.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BAButton.h"

@implementation BAButton

+ (instancetype)custonmButtonWithFrame:(CGRect)frame title:(NSString *)title state:(UIControlState)state backgroundColor:(UIColor *)backgroundColor
{
    return [[self alloc] custonmButtonWithFrame:frame title:title state:state backgroundColor:backgroundColor];
}

#pragma mark - 设置登陆按钮属性
- (instancetype)custonmButtonWithFrame:(CGRect)frame title:(NSString *)title state:(UIControlState)state backgroundColor:(UIColor *)backgroundColor
{
    if (self == [super init])
    {
        [self setTitle:title forState:state];
        self.frame = frame;
        self.backgroundColor = backgroundColor;
        self.layer.cornerRadius = 5.0; // 设置矩形四个圆角半径
    }
    return self;
}

@end
