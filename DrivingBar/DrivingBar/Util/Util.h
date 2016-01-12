//
//  Util.h
//  EAPController
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
//check valid ip address
+(BOOL)isValidIPAddress:(NSString *)ipAddressStr;
+(BOOL)isPureInt:(NSString*)string;
+(BOOL)isPureFloat:(NSString*)string;
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
@end
