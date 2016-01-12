//
//  BACommentCell.h
//  优优学车
//
//  Created by boai on 15/12/15.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BACommentCell : UITableViewCell

// 用户图像
@property (nonatomic, strong) UIImageView *userImageView;
// 用户名
@property (nonatomic, strong) UILabel *userNameLabel;
// 评论内容
@property (nonatomic, strong) UILabel *commentLabel;
// 回复评论内容
//@property (nonatomic, strong) UILabel *reCommentLabel;
// 评论时间
@property (nonatomic, strong) UILabel *commentTimeLabel;
// 回复图片
@property (nonatomic, strong) UIImageView *commentImageView;
// 回复按钮
@property (nonatomic, strong) UIButton *commentButton;
// 横线
//@property (nonatomic, strong) UIView *hView;

@property (nonatomic,assign) CGFloat cellHeight;


//给用户介绍赋值并且实现自动换行
- (void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
