//
//  BACommentModel.m
//  优优学车
//
//  Created by boai on 15/12/17.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BACommentModel.h"
#import "UIImage+NJ.h"

@implementation BACommentModel

+ (NSArray *)demoData
{
    BACommentModel *user = [[BACommentModel alloc] init];
    // 用户图像
    user.userImageNameStr = @"tea";
    // 用户名
    user.userNameStr = @"博爱";
    // 评论内容
    user.commentStr= @"我是胖虎我怕谁!!我是胖虎我怕谁!!我是胖虎我怕谁!!!!我是胖虎我怕谁!!我是胖虎我怕谁我是胖虎我怕谁!!我是胖虎我怕谁!!";
    // 评论时间
    user.commentTimeStr = @"2015-12-18 18:02:66";
    // 回复图片
    user.commentImageStr = @"pinglun";
    
    // ************************************************
    BACommentModel *user2 = [[BACommentModel alloc] init];
    // 用户图像
    user2.userImageNameStr = @"tea";
    // 用户名
    user2.userNameStr = @"博爱之家";
    // 评论内容
    user2.commentStr= @"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!";
    // 评论时间
    user2.commentTimeStr = @"2015-12-19 18:02:66";
    // 回复图片
    user2.commentImageStr = @"pinglun";

    
    return @[user, user2];
}

@end
