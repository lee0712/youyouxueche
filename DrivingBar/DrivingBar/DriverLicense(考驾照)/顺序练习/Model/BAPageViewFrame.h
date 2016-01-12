//
//  BAPageViewFrame.h
//  优优学车
//
//  Created by boai on 15/12/14.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BAPageViewFrame : NSObject

/**
 *  pageView数据
 */

// 问题图片 testImage
@property (nonatomic,assign) CGRect testImageF;
// 问题内容 testContentF
@property (nonatomic,assign) CGRect testContentF;


// 判断问题是否含有图片，0为无，1为有
// 评论的图片
@property (nonatomic,assign) CGRect comment_buttonF;
// 评论的内容
@property (nonatomic,assign) CGRect comment_contentF;
// 评论所产生的时间戳
@property (nonatomic,assign) CGRect argue_ctimeF;
// 评论的次数
//@property (nonatomic,assign) CGRect comment_countF;
// 分享
//@property (nonatomic,assign) CGRect share_F;
//@property (nonatomic,assign) CGRect share_count;

// cell 的高度
@property (nonatomic,assign) CGFloat cellHeight;

// 图片的数组
//@property (nonatomic,strong) NSArray *attach_smallArray;

//@property (nonatomic,strong) JNFriendDynamicModel *friendModel;



@end
