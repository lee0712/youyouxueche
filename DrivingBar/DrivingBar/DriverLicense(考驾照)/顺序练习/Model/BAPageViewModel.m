//
//  BAPageViewModel.m
//  优优学车
//
//  Created by boai on 15/12/14.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BAPageViewModel.h"

@implementation BAPageViewModel

// 解析所有详细信息
+ (id)parseDataByDict:(NSDictionary *)dataDic
{
    return [[self alloc] initWithParseDataWithDictionary:dataDic];
}

- (instancetype)initWithParseDataWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        // 问题图片 testImage
//        self.testImage = dict[@""];
        // 问题内容 testContentF
//        @property (nonatomic, strong) NSString *testContent;
        
    }
    return self;
}


@end
