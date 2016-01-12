//
//  MyPageTableViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "LSYViewPagerVC.h"
#import "MyMesgViewController.h"
#import "MyMesgTableViewController.h"

@interface MyMesgViewController ()<LSYViewPagerVCDataSource,LSYViewPagerVCDelegate>
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation MyMesgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"系统消息",@"我的回复",@"我的赞"];
    [self initNavi];
    self.delegate = self;
    self.dataSource = self;
    [self reload];
}

-(void)initNavi {
    self.view.backgroundColor = [UIColor whiteColor];
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"我的消息", nil);
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4,BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

-(void)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma View Pager Data Source
-(NSInteger)numberOfViewControllersInViewPager:(LSYViewPagerVC *)viewPager
{
    return 3;
}
-(UIViewController *)viewPager:(LSYViewPagerVC *)viewPager indexOfViewControllers:(NSInteger)index
{
    MyMesgTableViewController *tableViewVC = [[MyMesgTableViewController alloc] init];
    tableViewVC.pageNum = index;
    return tableViewVC;
}

-(CGFloat)heightForTitleOfViewPager:(LSYViewPagerVC *)viewPager
{
    return 50;
}
-(NSString *)viewPager:(LSYViewPagerVC *)viewPager titleWithIndexOfViewControllers:(NSInteger)index
{
    return self.titleArray[index];
}


#pragma View Pager Delegate
-(void)viewPagerViewController:(LSYViewPagerVC *)viewPager willScrollerWithCurrentViewController:(UIViewController *)ViewController
{
    
}
-(void)viewPagerViewController:(LSYViewPagerVC *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
