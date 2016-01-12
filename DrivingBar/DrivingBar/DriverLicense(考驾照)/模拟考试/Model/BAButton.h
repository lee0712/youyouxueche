//
//  BAButton.h
//  优优学车
//
//  Created by boai on 15/12/11.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//  自定义按钮类

#import <UIKit/UIKit.h>

@interface BAButton : UIButton

// 设置登陆按钮属性
- (instancetype)custonmButtonWithFrame:(CGRect)frame title:(NSString *)title state:(UIControlState)state backgroundColor:(UIColor *)backgroundColor;

@end
