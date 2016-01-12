//
//  Kemu3View.m
//  DrivingBar
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "Kemu3View.h"
#import "public.h"
#import "UIColor+HEX.h"

@interface Kemu3View (){
    UILabel *numLabel;
    UILabel *scoreLabel;
    UILabel *perLabel;
    UILabel *numValueLabel;
    UILabel *scoreValueLabel;
    UILabel *perValueLabel;
    NSUserDefaults *userDefaults;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@end

@implementation Kemu3View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    //模拟考试次数
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (screen_width-20.0)/3.0, 50)];
    numLabel.text = @"模拟考试次数";
    numLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    numLabel.textColor=[UIColor blackColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    
    [self addSubview:numLabel];
    
    //最高得分
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(numLabel.frame.origin.x+numLabel.frame.size.width, numLabel.frame.origin.y, (screen_width-20.0)/3.0, numLabel.frame.size.height)];
    scoreLabel.text = @"最高得分";
    scoreLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    scoreLabel.textColor=[UIColor blackColor];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    
    [self addSubview:scoreLabel];
    
    //通过率
    perLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreLabel.frame.origin.x+scoreLabel.frame.size.width, numLabel.frame.origin.y, (screen_width-20.0)/3.0, numLabel.frame.size.height)];
    perLabel.text = @"通过率";
    perLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    perLabel.textColor=[UIColor blackColor];
    perLabel.textAlignment = NSTextAlignmentCenter;
    perLabel.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    
    [self addSubview:perLabel];
    
    //value
    //模拟考试次数
    numValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, numLabel.frame.origin.y+numLabel.frame.size.height, (screen_width-20.0)/3.0, 50)];
    
    numValueLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    numValueLabel.textColor=[UIColor blackColor];
    numValueLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:numValueLabel];
    
    //最高得分
    scoreValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(numValueLabel.frame.origin.x+numValueLabel.frame.size.width, numValueLabel.frame.origin.y, (screen_width-20.0)/3.0, numValueLabel.frame.size.height)];
    
    scoreValueLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    scoreValueLabel.textColor=[UIColor blackColor];
    scoreValueLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:scoreValueLabel];
    
    //通过率
    perValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreValueLabel.frame.origin.x+scoreValueLabel.frame.size.width, scoreValueLabel.frame.origin.y, (screen_width-20.0)/3.0, scoreValueLabel.frame.size.height)];
    
    perValueLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    perValueLabel.textColor=[UIColor blackColor];
    perValueLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:perValueLabel];
    
    numValueLabel.text = [userDefaults objectForKey:@"k3v1"];;
    scoreValueLabel.text = [userDefaults objectForKey:@"k3v2"];
    perValueLabel.text =[userDefaults objectForKey:@"k3v3"];
    
    return self;
}

- (void)setup {
    self.tableDataSource = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)setupDataSource:(NSString *)times Score:(NSString*)score Pass:(NSString*)pass {
    numValueLabel.text = times;
    scoreValueLabel.text = score;
    perValueLabel.text = pass;
}
@end
