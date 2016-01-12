//
//  PublishTopicChooseViewController.m
//  DrivingBar
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 admin. All rights reserved.
//
#import "public.h"
#import "PublishTopicChooseViewController.h"

@interface PublishTopicChooseViewController ()

@end

@implementation PublishTopicChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initView];
    // Do any additional setup after loading the view.
}

//初始化标题栏
-(void)initNavi {
    //标题栏
    self.navigationController.navigationBarHidden = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = RGB_BACKGROUND_COLOR_BLUE;
    self.navigationController.view.tintColor = [UIColor whiteColor];
    
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    //right button
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
//初始化界面
-(void)initView{

}

-(void)save:(id)sender {
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
