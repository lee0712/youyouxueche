//
//  MapViewController.m
//  EAPController
//
//  Created by admin on 15/9/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ExamViewController.h"
#import "AFNetworking.h"
#import "public.h"
#import "UIImageView+WebCache.h"

#import "UIColor+HEX.h"

@interface ExamViewController ()
{
    UIScrollView *_scrollView;
    AFHTTPRequestOperationManager *httpsManager;
    float imageScale;
    UIImageView *mapImageView;
    UIScrollView *scrollView;
    NSMutableArray *mapInfo;
    UIButton *mapMenu;
}

@end

@implementation ExamViewController

- (void)loadView {
    [super loadView];
    [self setup];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMap];
   
}

- (void)setup {
    mapInfo = [[NSMutableArray alloc]init];
}

- (void)initView {

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationController.navigationBar.barTintColor = RGB_BACKGROUND_COLOR_BLUE;
    [self.navigationController.navigationBar setTranslucent:NO];
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"考sss";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.view.backgroundColor = [UIColor clearColor];
    //  self.navigationItem.titleView = titleLabel;
    self.tabBarController.navigationItem.titleView = titleLabel;
  //  NSLog(@"view will appear");
}
- (void)viewDidAppear:(BOOL)animated {
 
  //  NSLog(@"view did appear");
}
- (void)viewDidDisappear:(BOOL)animated {
   // NSLog(@"view did disappear");
}

- (void)getMap{
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
