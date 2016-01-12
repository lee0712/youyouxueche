//
//  NickNameViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "SignViewController.h"
#import "EAPToast.h"

@interface SignViewController ()<UITextViewDelegate>{
    UITextView *nickNameTx;
}

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    nickNameTx = [[UITextView alloc]initWithFrame:CGRectMake(0, 0+10, screen_width, 80)];
    nickNameTx.returnKeyType = UIReturnKeyDone;
    //name.placeholder = _userName;
    nickNameTx.text = self.sign;
    nickNameTx.font = [UIFont boldSystemFontOfSize:18];
    nickNameTx.delegate = self;
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
    titleLabel.text = NSLocalizedString(@"签名", nil);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    //    //left button
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(finish:)];
    //right button
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)finish:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save:(id)sender {
    if ([nickNameTx.text length]>18) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"最多输入18个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alert show];
    }else{
        [self.delegate passSign:nickNameTx.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
