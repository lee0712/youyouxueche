//
//  UIView+Single.m
//  伊吉康
//
//  Created by mac os x on 15/11/2.
//  Copyright © 2015年 甲鸟科技. All rights reserved.
//

#import "UIView+Single.h"
#import "BAUtilities.h"

static UIView *viewDefaltManager = nil;
static UIView *replyDefaltView = nil;
static UIView *friendReplyDefaltView = nil;
@implementation UIView (Single)


+ (UIView *)defaultManager {
    if (!viewDefaltManager)
    {
        viewDefaltManager = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 54)];
        viewDefaltManager.backgroundColor = [UIColor whiteColor];

        //        textFielManager = [[UITextField alloc] init];
    }
    return viewDefaltManager;
}

+ (UIView *)replyView {
    if (!replyDefaltView)
    {
        replyDefaltView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 54)];
        replyDefaltView.backgroundColor = [UIColor whiteColor];
        //replyDefaltView = [[UIView alloc] init];
        //        textFielManager = [[UITextField alloc] init];
    }
    return replyDefaltView;
}

+ (UIView *)friendReplyView {
    if (!friendReplyDefaltView)
    {
        friendReplyDefaltView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 54)];
        friendReplyDefaltView.backgroundColor = COLOR_C(239, 239, 239, 1.0);
        //replyDefaltView = [[UIView alloc] init];
        //        textFielManager = [[UITextField alloc] init];
    }
    return friendReplyDefaltView;
}

@end
