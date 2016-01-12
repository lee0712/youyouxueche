//
//  BASimulationTestView.m
//  优优学车
//
//  Created by boai on 15/12/11.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BASimulationTestView.h"
#import "BAUtilities.h"
#import "BAButton.h"

#import "BAPageViewController.h"

@interface BASimulationTestView ()

@property (assign, nonatomic) CGSize size;
@property (nonatomic, strong) UIView *subView;

@end

@implementation BASimulationTestView

- (instancetype)initWithSize:(CGSize)size at:(id)view
{
    if (self = [super init])
    {
        self.size = size;
        
        if ([view isKindOfClass:[UIView class]])
        {
            view = (UIView *)view;
        }
        else if ([view isKindOfClass:[UIWindow class]])
        {
            view = (UIWindow *)view;
        }
        else
        {
            view = nil;
            return nil;
        }
        
        /* width */
        if (size.width < 60.0f)
        {
            size.width = 60.0f;
        }
        else if (size.width > KSCREEN_WIDTH)
        {
            size.width = KSCREEN_WIDTH;
        }
        
        /* height */
        if (size.height < 10.0f)
        {
            size.height = 10.0f;
        }
        else if (size.height > KSCREEN_HEIGHT)
        {
            size.height = KSCREEN_HEIGHT;
        }
        
        CGRect frame = CGRectZero;
        frame.size = size;
        self.frame = frame;
        [view addSubview:self];
        CGRect viewFrame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        self.subView = [[UIView alloc] initWithFrame:viewFrame];
        self.subView.backgroundColor = COLOR_C(78, 183, 249, 1.0);
//        UIImageView *bgImageView = [[UIImageView alloc] init];
//        bgImageView.frame = viewFrame;
//        bgImageView.image = [UIImage imageNamed:@"bg"];
        
        
        [self addSubview:self.subView];
//        [self addSubview:bgImageView];

        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    // 用户图像
    UIImageView *userImageView = [[UIImageView alloc] init];
    userImageView.frame = CGRectMake((KSCREEN_WIDTH-100)/2, 20, 100, 100);
    userImageView.image = [UIImage circleImageWithName:@"user copy" borderWidth:3.0 borderColor:[UIColor whiteColor]];
    
    // 用户名
    CGRect userNameLabelFrame = CGRectMake((KSCREEN_WIDTH - 100)/2, userImageView.frame.origin.y + userImageView.height + 10, 100, 40);
    UILabel *userNameLabel = [self customLabelWithFrame:userNameLabelFrame text:@"博爱"];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    // 全国通用
    CGRect nationalGeneralLabelFrame = CGRectMake((KSCREEN_WIDTH - 200)/2, userNameLabel.frame.origin.y + userNameLabel.height + 1, 200, 40);
    UILabel *nationalGeneralLabel = [self customLabelWithFrame:nationalGeneralLabelFrame text:@"全国通用    C1/C2"];
    nationalGeneralLabel.textAlignment = NSTextAlignmentLeft;
    
    // 考题数量
    CGRect testNumberLabelFrame = CGRectMake((KSCREEN_WIDTH - 200)/2, nationalGeneralLabel.frame.origin.y + nationalGeneralLabel.height + 1, 200, 40);
    UILabel *testNumberLabel = [self customLabelWithFrame:testNumberLabelFrame text:@"考题数量    100题"];
    testNumberLabel.textAlignment = NSTextAlignmentLeft;
    
    // 考试时间
    CGRect testTimeLabelFrame = CGRectMake((KSCREEN_WIDTH - 200)/2, testNumberLabel.frame.origin.y + testNumberLabel.height + 1, 200, 40);
    UILabel *testTimeLabel = [self customLabelWithFrame:testTimeLabelFrame text:@"考试时间    45分钟"];
    testTimeLabel.textAlignment = NSTextAlignmentLeft;
    
    // 合格标准
    CGRect testCriteriaLabelFrame = CGRectMake((KSCREEN_WIDTH - 200)/2, testTimeLabel.frame.origin.y + testTimeLabel.height + 1, 300, 40);
    UILabel *testCriteriaLabel = [self customLabelWithFrame:testCriteriaLabelFrame text:@"合格标准    满分100分，90分及格"];
    testCriteriaLabel.textAlignment = NSTextAlignmentLeft;
    
    // 按钮 - 全真模拟考试
    CGRect simulationTestBtnFrame = CGRectMake(40, testCriteriaLabel.frame.origin.y + testCriteriaLabel.height + 20, (KSCREEN_WIDTH - 40*2 - 10)/2, 40);
    BAButton *simulationTestBtn = [[BAButton alloc] custonmButtonWithFrame:simulationTestBtnFrame title:@"全真模拟考试" state:UIControlStateNormal backgroundColor:[UIColor whiteColor]];
    [simulationTestBtn setTitleColor:COLOR_C(78, 183, 249, 1.0) forState:UIControlStateNormal];
    [simulationTestBtn addTarget:self action:@selector(simulationTestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 按钮 - 优先考未做题
    CGRect priorityTestBtnFrame = CGRectMake(simulationTestBtn.frame.origin.x + simulationTestBtn.width + 20, testCriteriaLabel.frame.origin.y + testCriteriaLabel.height + 20, (KSCREEN_WIDTH - 40*2 - 20)/2, 40);
    BAButton *priorityTestBtn = [[BAButton alloc] custonmButtonWithFrame:priorityTestBtnFrame title:@"优先考未做题" state:UIControlStateNormal backgroundColor:[UIColor whiteColor]];
    [priorityTestBtn setTitleColor:COLOR_C(78, 183, 249, 1.0) forState:UIControlStateNormal];
    [priorityTestBtn addTarget:self action:@selector(priorityTestBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    [self addSubview:userImageView];
    [self addSubview:userNameLabel];
    [self addSubview:nationalGeneralLabel];
    [self addSubview:testNumberLabel];
    [self addSubview:testTimeLabel];
    [self addSubview:testCriteriaLabel];
    [self addSubview:simulationTestBtn];
    [self addSubview:priorityTestBtn];
}

#pragma mark - 自定义控件
#pragma mark 自定义Label
- (UILabel *)customLabelWithFrame:(CGRect)frame text:(NSString *)text
{
    UILabel *customLabel = [[UILabel alloc] init];
    customLabel.frame = frame;
    customLabel.text = text;
    customLabel.textColor = [UIColor whiteColor];
//    customLabel.textAlignment = NSTextAlignmentCenter;
    
    return customLabel;
}

#pragma mark - 按钮点击事件
#pragma mark 全真模拟考试
- (IBAction)simulationTestBtnClick:(id)sender
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BASimulationTestView_simulationTestBtn";
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark 优先考未做题
- (IBAction)priorityTestBtnClick:(id)sender
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BASimulationTestView_priorityTestBtn";
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark - 调用view的C
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
