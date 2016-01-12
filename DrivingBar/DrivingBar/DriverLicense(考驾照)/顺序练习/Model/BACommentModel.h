//
//  BACommentModel.h
//  优优学车
//
//  Created by boai on 15/12/17.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BACommentModel : NSObject

// 用户图像
@property (nonatomic, strong) NSString *userImageNameStr;
// 用户名
@property (nonatomic, strong) NSString *userNameStr;
// 评论内容
@property (nonatomic, strong) NSString *commentStr;
// 回复评论内容
//@property (nonatomic, strong) UILabel *reCommentLabel;
// 评论时间
@property (nonatomic, strong) NSString *commentTimeStr;
// 回复图片
@property (nonatomic, strong) NSString *commentImageStr;
// 回复按钮
@property (nonatomic, strong) NSString *commentButtonStr;
// 横线
//@property (nonatomic, strong) UIView *hView;

//我需要一点测试数据，直接复制老项目东西
+ (NSArray *)demoData;

@end
