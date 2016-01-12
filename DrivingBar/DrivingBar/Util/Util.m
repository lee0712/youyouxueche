//
//  Util.m
//  EAPController
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "Util.h"

@implementation Util

//check valid ip address
+(BOOL)isValidIPAddress:(NSString *)ipAddressStr{
    int ipQuads[4];
    const char *ipAddress = [ipAddressStr cStringUsingEncoding:NSUTF8StringEncoding];
    sscanf(ipAddress, "%d,%d,%d,%d", &ipQuads[0], &ipQuads[1], &ipQuads[2],&ipQuads[3]);
    for (int i = 0; i < 4; i++) {
        if ((ipQuads[i] < 0) || (ipQuads[i] > 255)) {
            return NO;
        }
    }
    return YES;
}

+(BOOL)isPureInt:(NSString*)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(BOOL)isPureFloat:(NSString*)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr =[NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}
                          
@end
