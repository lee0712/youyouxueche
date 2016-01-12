//
//  BAPageViewModel.h
//  优优学车
//
//  Created by boai on 15/12/14.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAPageViewModel : NSObject

/**
 *  pageView数据
 */

// 问题图片 testImage
@property (nonatomic, strong) NSString *testImage;
// 问题内容 testContentF
@property (nonatomic, strong) NSString *testContent;


// 判断问题是否含有图片，0为无，1为有
// 评论的图片
//@property (nonatomic, strong) NSString *comment_button;
// 评论的内容
//@property (nonatomic, strong) CGRect comment_contentF;
// 评论所产生的时间戳
//@property (nonatomic, strong) CGRect argue_ctimeF;
// 评论的次数
//@property (nonatomic,assign) CGRect comment_countF;

// 解析所有详细信息
+ (id)parseDataByDict:(NSDictionary *)dataDic;



@end
