//
//  Kemu2View.m
//  DrivingBar
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "Kemu2View.h"
#import "public.h"
#import "UIColor+HEX.h"

@interface Kemu2View (){
    UILabel *numLabel;
    UILabel *perLabel;
    UILabel *daocheLabel;
    UILabel *daocheperLabel;
    UILabel *cefangLabel;
    UILabel *cefangperLabel;
    UILabel *szhuanwanLabel;
    UILabel *szhuanwanperLabel;
    UILabel *zhijiaoLabel;
    UILabel *zhijiaoperLabel;
    UILabel *banpoLabel;
    UILabel *banpoperLabel;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@end

@implementation Kemu2View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    
    //考试名称
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (screen_width-20.0)/2.0, 50)];
    numLabel.text = @"模拟考试次数";
    numLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    numLabel.textColor=[UIColor blackColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    
    [self addSubview:numLabel];

    
    //通过率
    perLabel = [[UILabel alloc] initWithFrame:CGRectMake(numLabel.frame.origin.x+numLabel.frame.size.width, numLabel.frame.origin.y, (screen_width-20.0)/2.0, numLabel.frame.size.height)];
    perLabel.text = @"通过率";
    perLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    perLabel.textColor=[UIColor blackColor];
    perLabel.textAlignment = NSTextAlignmentCenter;
    perLabel.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    
    [self addSubview:perLabel];
    
    //value
    //倒车入库
    daocheLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, numLabel.frame.origin.y+numLabel.frame.size.height, (screen_width-20.0)/2.0, 50)];
    daocheLabel.text = @"倒车入库";
    daocheLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    daocheLabel.textColor=[UIColor blackColor];
    daocheLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:daocheLabel];
    
    //到处入库通过率
    daocheperLabel = [[UILabel alloc] initWithFrame:CGRectMake(daocheLabel.frame.origin.x+daocheLabel.frame.size.width, daocheLabel.frame.origin.y, (screen_width-20.0)/2.0, daocheLabel.frame.size.height)];
    daocheperLabel.text = @"..";
    daocheperLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    daocheperLabel.textColor=[UIColor blackColor];
    daocheperLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:daocheperLabel];
    
    //value
    //侧方停车
    cefangLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, daocheLabel.frame.origin.y+daocheLabel.frame.size.height, (screen_width-20.0)/2.0, 50)];
    cefangLabel.text = @"侧方停车";
    cefangLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    cefangLabel.textColor=[UIColor blackColor];
    cefangLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:cefangLabel];
    
    //侧方停车通过率
    cefangperLabel = [[UILabel alloc] initWithFrame:CGRectMake(cefangLabel.frame.origin.x+cefangLabel.frame.size.width, cefangLabel.frame.origin.y, (screen_width-20.0)/2.0, cefangLabel.frame.size.height)];
    
    cefangperLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    cefangperLabel.textColor=[UIColor blackColor];
    cefangperLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:cefangperLabel];
    
    //s转弯
    szhuanwanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cefangLabel.frame.origin.y+cefangLabel.frame.size.height, (screen_width-20.0)/2.0, 50)];
    szhuanwanLabel.text = @"S转弯";
    szhuanwanLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    szhuanwanLabel.textColor=[UIColor blackColor];
    szhuanwanLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:szhuanwanLabel];
    
    //s转弯通过率
    szhuanwanperLabel = [[UILabel alloc] initWithFrame:CGRectMake(szhuanwanLabel.frame.origin.x+szhuanwanLabel.frame.size.width, szhuanwanLabel.frame.origin.y, (screen_width-20.0)/2.0, szhuanwanLabel.frame.size.height)];
    
    szhuanwanperLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    szhuanwanperLabel.textColor=[UIColor blackColor];
    szhuanwanperLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:szhuanwanperLabel];
    
    //直角转弯
    zhijiaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, szhuanwanLabel.frame.origin.y+szhuanwanLabel.frame.size.height, (screen_width-20.0)/2.0, 50)];
    zhijiaoLabel.text = @"直角转弯";
    zhijiaoLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    zhijiaoLabel.textColor=[UIColor blackColor];
    zhijiaoLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:zhijiaoLabel];
    
    //直角转弯通过率
    zhijiaoperLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhijiaoLabel.frame.origin.x+zhijiaoLabel.frame.size.width, zhijiaoLabel.frame.origin.y, (screen_width-20.0)/2.0, zhijiaoLabel.frame.size.height)];
    
    zhijiaoperLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    zhijiaoperLabel.textColor=[UIColor blackColor];
    zhijiaoperLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:zhijiaoperLabel];
    
    //半坡启动
    banpoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, zhijiaoLabel.frame.origin.y+zhijiaoLabel.frame.size.height, (screen_width-20.0)/2.0, 50)];
    banpoLabel.text = @"半坡启动";
    banpoLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    banpoLabel.textColor=[UIColor blackColor];
    banpoLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:banpoLabel];
    
    //半坡启动通过率
    banpoperLabel = [[UILabel alloc] initWithFrame:CGRectMake(banpoLabel.frame.origin.x+banpoLabel.frame.size.width, banpoLabel.frame.origin.y, (screen_width-20.0)/2.0, banpoLabel.frame.size.height)];
    
    banpoperLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    banpoperLabel.textColor=[UIColor blackColor];
    banpoperLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:banpoperLabel];
    return self;

}

- (void)setup {
    self.tableDataSource = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
 
}
- (void)setupDataSource:(NSString *)v1 V2:(NSString*)v2 V3:(NSString*)v3 V4:(NSString*)v4 V5:(NSString*)v5 {
    daocheperLabel.text = v1;
    cefangperLabel.text = v2;
    szhuanwanperLabel.text = v3;
    zhijiaoperLabel.text = v4;
    banpoperLabel.text = v5;
}
@end
