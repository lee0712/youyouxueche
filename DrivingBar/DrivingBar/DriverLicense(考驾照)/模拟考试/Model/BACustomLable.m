//
//  BACustomLable.m
//  优优学车
//
//  Created by boai on 15/12/14.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BACustomLable.h"

@implementation BACustomLable

+ (instancetype)custonmLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    return [[self alloc] custonmLabelWithFrame:frame text:text textColor:textColor font:font textAlignment:textAlignment];
}

#pragma mark - 设置登陆按钮属性
- (instancetype)custonmLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    if (self == [super init])
    {
        self.frame = frame;
        self.text = text;
        self.textColor = textColor;
        self.font = font;
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

// 获取字符串的大小  ios7
// 让label自适应里面的文字，自动调整宽度和高度的
- (CGSize)getStringRect:(NSString*)aString
{
    CGSize size;
    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
    NSRange range = NSMakeRange(0, atrString.length);
    
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    size = [aString boundingRectWithSize:CGSizeMake(237, 200)  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return  size;
}

@end
