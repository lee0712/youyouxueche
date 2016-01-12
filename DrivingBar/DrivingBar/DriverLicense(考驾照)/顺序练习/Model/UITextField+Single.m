
//
//  UITextField+Single.m
//  伊吉康
//
//  Created by mac os x on 15/11/2.
//  Copyright © 2015年 甲鸟科技. All rights reserved.
//

#import "UITextField+Single.h"
#import "BAUtilities.h"

static UITextField *textFielManager = nil;
static UITextField *replyDefalutText = nil;
static UITextField *friendReplyDefalutText = nil;
@implementation UITextField (Single)

+ (UITextField *)defaultManager {
    if (!textFielManager)
    {
        textFielManager = [[UITextField alloc] initWithFrame:CGRectMake(15 , 5 , KSCREEN_WIDTH - 80, 40)];
        //        textFielManager = [[UITextField alloc] init];
    }
    return textFielManager;
}

+ (UITextField *)replyTextField {
    if (!replyDefalutText)
    {
        replyDefalutText = [[UITextField alloc] initWithFrame:CGRectMake(15 , 5 , KSCREEN_WIDTH - 80, 40)];
        //        textFielManager = [[UITextField alloc] init];
    }
    return replyDefalutText;
}

+ (UITextField *)friendReplyTextField {
    if (!friendReplyDefalutText)
    {
        friendReplyDefalutText = [[UITextField alloc] initWithFrame:CGRectMake(5 , 5 , KSCREEN_WIDTH - 70, 44)];
        //        textFielManager = [[UITextField alloc] init];
    }
    return friendReplyDefalutText;
}

@end
