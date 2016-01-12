//
//  public.h
//  EAPController
//
//  Created by admin on 15/9/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef EAPController_public_h
#define EAPController_public_h

//color
#define BACKGROUND_COLOR_BLUE @"4eb7f9"
#define BACK_LINE_COLOR_BLACK @"E0E0E0"
#define BACKGROUND_COLOR_GRAY @"F2F2F2"
#define TEXT_BLUE_COLOR @"1e90ff"
#define SLIDE_MENU_BACK_COLOR @"747ca7"
#define SLIDE_MENU_RELAYOUT_BACK_COLOR @"7c7ca5"

//tabbar height
#define TAB_BAR_HEIGHT 49
//navigation bar height
#define NAVI_BAR_HEIGHT 44
//status bar height
#define STATUS_BAR_HEIGHT 20
//status bar & navigation bar
#define NAVI_AND_STATUS_HEIGHT (NAVI_BAR_HEIGHT+STATUS_BAR_HEIGHT)

//back button width
#define BACK_IM_WIDTH 24

//padding
#define LAYOUT_PADDING 15

// 4.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

//屏幕分辨率
#define scale_screen = [UIScreen mainScreen].scale

//无网络时界面调试
#define UI_DEBUG_NO_NETWORK NO

//后台接口地址
#define HTTP_POST_URL_NSSTRING @"http://115.28.211.226:10008/api/client"
#define HTTP_IMG_URL_NSSTRING @"http://115.28.211.226:10008"

//setting left padding
#define MARGIN_LEFT 20

// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define RGB_BACKGROUND_COLOR_BLUE RGB(78,183,249)
#define RGB_BACKGROUND_COLOR_GRAY RGB(242,242,242)
#define RGB_BACKGROUND_COLOR_RED RGB(241, 95, 95)

//global var
extern int g_https_port;
//user id
extern NSString *g_userId;
//session id
extern NSString *g_sessionId;

//用户图片
extern UIImage *g_userHeadIm;
extern NSURL *g_userImUrl;
extern BOOL g_ifUpdate_Info;

#endif
