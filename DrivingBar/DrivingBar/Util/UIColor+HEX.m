//
//  UIColor+HEX.m
//  AdRouterManager
//
//  Created by Jeanne on 15/1/6.
//  Copyright (c) 2015年 TP-LINK. All rights reserved.
//

#import "UIColor+HEX.h"

@implementation UIColor (HEX)
//RGB方式的颜色设置
+ (UIColor *)colorWithRGBHEX:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [color uppercaseString];
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    while ([cString length] < 6) {
        cString = [NSString stringWithFormat:@"0%@", cString];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed: r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}
@end

