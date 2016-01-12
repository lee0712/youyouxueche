//
//  BATestDataFromDataBase.m
//  优优学车
//
//  Created by boai on 15/12/18.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BATestDataFromDataBase.h"

@implementation BATestDataFromDataBase

+ (BATestDataFromDataBase *)shareFromDataBase
{
    static BATestDataFromDataBase *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (sharedInstance == nil)
        {
            sharedInstance = [[BATestDataFromDataBase alloc] init];
        }
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _nameFromTable = @"";
        _ageFromTable = @"";
        _IDFromTable = @"";
        _nameArrayFromTable = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}


@end
