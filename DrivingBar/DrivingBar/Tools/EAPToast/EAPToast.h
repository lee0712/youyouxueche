//
//  EAPToast.h
//  EAPController
//
//  Created by admin on 15/9/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 2.0f

@interface EAPToast : NSObject {
    NSString *text;
    UIButton *contentView;
    CGFloat duration;
}

+(void)showWithText:(NSString *)text_;
+(void)showWithText:(NSString *)text_ duration:(CGFloat)duration_;
+(void)showWithText:(NSString *)text_ bottomOffset:(CGFloat)bottomOffset_;

+(void)showWithText:(NSString *)text_ bottomOffset:(CGFloat)bottomOffset_ duration:(CGFloat)duration_;

@end
