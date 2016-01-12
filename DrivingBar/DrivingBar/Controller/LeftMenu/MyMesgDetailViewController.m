//
//  NickNameViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "MyMesgDetailViewController.h"
#import "EAPToast.h"

@interface MyMesgDetailViewController (){
    UITextView *nickNameTx;
}

@end

@implementation MyMesgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    nickNameTx = [[UITextView alloc]initWithFrame:CGRectMake(0, 8, screen_width, 80)];
    nickNameTx.returnKeyType = UIReturnKeyDone;
    //name.placeholder = _userName;
    nickNameTx.text = self.sign;
    nickNameTx.font = [UIFont boldSystemFontOfSize:18];
    nickNameTx.editable = NO;
    nickNameTx.backgroundColor = [UIColor whiteColor];
    nickNameTx.returnKeyType = UIReturnKeyDefault;
    
    //禁止自动居中
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:nickNameTx];
}

-(void)initNavi {
    self.view.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"我的消息", nil);
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    //    //left button
    
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)finish:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
