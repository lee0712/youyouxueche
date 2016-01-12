//
//  BAUtilities.h
//  伊吉康
//
//  Created by 博爱之家 on 15/10/17.
//  Copyright © 2015年 甲鸟科技. All rights reserved.
//

#ifndef BAUtilities_h
#define BAUtilities_h

// 头文件
#import "UIView+Frame.h"
#import "UIImage+NJ.h"


//宏定义
//当前设备的屏幕宽度
#define KSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

//当前设备的屏幕高度
#define KSCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

// cell 动态高度
#define CELL_CONTENT_MARGIN 10.0f

// cell 默认字体大小
#define FONT_SIZE [UIFont systemFontOfSize:14]

// 主体颜色
#define MAIN_COLOR [UIColor colorWithRed:78.0 green:183.0 blue:249.0 alpha:1.0]


// 颜色
#define COLOR_C(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A] 

// 随机色
#define JNRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


#endif /* BAUtilities_h */
