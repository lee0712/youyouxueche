//
//  BATestDataFromDataBase.h
//  优优学车
//
//  Created by boai on 15/12/18.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BATestDataFromDataBase : NSObject


@property (nonatomic, strong) NSString *nameFromTable;
@property (nonatomic, strong) NSString *ageFromTable;
@property (nonatomic, strong) NSString *IDFromTable;
@property (nonatomic, strong) NSMutableArray *nameArrayFromTable;

+ (BATestDataFromDataBase *)shareFromDataBase;

@end
