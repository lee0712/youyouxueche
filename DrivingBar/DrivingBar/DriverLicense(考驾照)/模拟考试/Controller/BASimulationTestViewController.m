//
//  BASimulationTestViewController.m
//  优优学车
//
//  Created by boai on 15/12/11.
//  Copyright © 2015年 yueqian. All rights reserved.
//

#import "BASimulationTestViewController.h"
#import "BAPageViewController.h"
#import "BAUtilities.h"
#import "BAButton.h"

@interface BASimulationTestViewController ()
{
    UIImageView *navBarHairlineImageView;
    UINavigationBar *bar;
}
@end

@implementation BASimulationTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"模拟考试";
    self.view.backgroundColor = COLOR_C(78, 183, 249, 1.0);
    
    bar = self.navigationController.navigationBar;
    navBarHairlineImageView = [self findHairlineImageViewUnder:bar];
    //        [bar setBackgroundImage:[UIImage imageNamed:@"bg-1"] forBarMetrics:UIBarMetricsCompact];
    
    [self initSubView];
}

- (void)initSubView
{
    // 用户图像
    UIImageView *userImageView = [[UIImageView alloc] init];
    userImageView.frame = CGRectMake((KSCREEN_WIDTH-100)/2, 20+64, 100, 100);
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
    simulationTestBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [simulationTestBtn addTarget:self action:@selector(simulationTestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 按钮 - 优先考未做题
    CGRect priorityTestBtnFrame = CGRectMake(simulationTestBtn.frame.origin.x + simulationTestBtn.width + 20, testCriteriaLabel.frame.origin.y + testCriteriaLabel.height + 20, (KSCREEN_WIDTH - 40*2 - 20)/2, 40);
    BAButton *priorityTestBtn = [[BAButton alloc] custonmButtonWithFrame:priorityTestBtnFrame title:@"优先考未做题" state:UIControlStateNormal backgroundColor:[UIColor whiteColor]];
    [priorityTestBtn setTitleColor:COLOR_C(78, 183, 249, 1.0) forState:UIControlStateNormal];
    priorityTestBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [priorityTestBtn addTarget:self action:@selector(priorityTestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:userImageView];
    [self.view addSubview:userNameLabel];
    [self.view addSubview:nationalGeneralLabel];
    [self.view addSubview:testNumberLabel];
    [self.view addSubview:testTimeLabel];
    [self.view addSubview:testCriteriaLabel];
    [self.view addSubview:simulationTestBtn];
    [self.view addSubview:priorityTestBtn];
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
    [self.navigationController pushViewController:pageVC animated:YES];
}

#pragma mark 优先考未做题
- (IBAction)priorityTestBtnClick:(id)sender
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BASimulationTestView_priorityTestBtn";
    [self.navigationController pushViewController:pageVC animated:YES];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
    [[UINavigationBar appearance] setBarTintColor:COLOR_C(78, 183, 249, 1.0)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
    [[UINavigationBar appearance] setBarTintColor:COLOR_C(78, 183, 249, 1.0)];
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self.view removeFromSuperview];
//}

@end
