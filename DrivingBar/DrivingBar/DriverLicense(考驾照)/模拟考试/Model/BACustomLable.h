//
//  BACustomLable.h
//  优优学车
//
//  Created by boai on 15/12/14.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BACustomLable : UILabel

// 设置label属性
- (instancetype)custonmLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

@end
