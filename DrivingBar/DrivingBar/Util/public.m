//
//  public.m
//  EAPController
//
//  Created by admin on 15/9/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "public.h"
NSString *g_userId = nil;             //user id
NSString *g_sessionId = nil;            //session id
int g_https_port = -1;                  //https port

UIImage *g_userHeadIm;              //用户头像
NSURL *g_userImUrl;
BOOL g_ifUpdate_Info;