//
//  UIButton+Single.m
//  伊吉康
//
//  Created by mac os x on 15/11/2.
//  Copyright © 2015年 甲鸟科技. All rights reserved.
//

#import "UIButton+Single.h"
#import "BAUtilities.h"


static UIButton *buttonDefaultManager = nil;
static UIButton *replyDefalutButton;
static UIButton *friendReplyDefalutButton;

@implementation UIButton (Single)

+ (UIButton *)defaultManager {
    if (!buttonDefaultManager)
    {
        buttonDefaultManager = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonDefaultManager.frame = CGRectMake(KSCREEN_WIDTH - 55, 5, 50, 40);
        [buttonDefaultManager setTitle:@"发 送" forState:UIControlStateNormal];
        buttonDefaultManager.layer.borderWidth = 1;
        buttonDefaultManager.layer.borderColor = [COLOR_C(240, 240, 240, 1.0) CGColor];
        buttonDefaultManager.layer.cornerRadius = 15.0;
    }
    return buttonDefaultManager;
}

+ (UIButton *)replyDefalutButton {
    if (!replyDefalutButton)
    {
        replyDefalutButton = [UIButton buttonWithType:UIButtonTypeSystem];
        replyDefalutButton.frame = CGRectMake(KSCREEN_WIDTH - 55, 5, 50, 40);
        [replyDefalutButton setTitle:@"发 送" forState:UIControlStateNormal];
        replyDefalutButton.layer.borderWidth = 1;
        replyDefalutButton.layer.borderColor = [COLOR_C(240, 240, 240, 1.0) CGColor];
        replyDefalutButton.layer.cornerRadius = 15.0;
    }
    return replyDefalutButton;
}

+ (UIButton *)friendReplyButton {
    if (!friendReplyDefalutButton)
    {
        friendReplyDefalutButton = [UIButton buttonWithType:UIButtonTypeSystem];
        friendReplyDefalutButton.frame = CGRectMake(KSCREEN_WIDTH - 55, 5, 50, 44);
        [friendReplyDefalutButton setTitle:@"发 送" forState:UIControlStateNormal];
        friendReplyDefalutButton.layer.borderWidth = 1;
        friendReplyDefalutButton.layer.borderColor = [COLOR_C(240, 240, 240, 1.0) CGColor];
        friendReplyDefalutButton.layer.cornerRadius = 5;
    }
    return friendReplyDefalutButton;
}

@end
