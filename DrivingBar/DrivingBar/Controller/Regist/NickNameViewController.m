//
//  NickNameViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "NickNameViewController.h"
#import "EAPToast.h"

@interface NickNameViewController ()<UITextFieldDelegate>{
    UITextField *nickNameTx;
}

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    nickNameTx = [[UITextField alloc]initWithFrame:CGRectMake(0, 0+10, screen_width, 40)];
    //[nickNameTx setBorderStyle:UITextBorderStyleRoundedRect];
    nickNameTx.returnKeyType = UIReturnKeyDone;
    //name.placeholder = _userName;
    nickNameTx.text = self.nickName;
    nickNameTx.delegate = self;
    nickNameTx.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickNameTx];
}

-(void)initNavi {
    self.view.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"修改昵称", nil);
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    titleLabel.textColor=[UIColor whiteColor];
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
    if ([nickNameTx.text isEqual:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"昵称不能为空" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (nickNameTx.text.length > 8) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"最多输入8个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alert show];return;
    }
    
    [self.delegate passNickName:nickNameTx.text];
    [self.navigationController popViewControllerAnimated:YES];
}
//完成键
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [nickNameTx resignFirstResponder];
    return YES;
}

@end
