//
//  RegistViewController.m
//  EAPController
//
//  Created by admin on 15/9/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "RegistViewController.h"
#import "public.h"
#import "UIColor+HEX.h"
#import "AFNetworking.h"
#import "EAPToast.h"
#import "MyTime.h"
#import "AddDataTableViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>
{
    NSString *regUserName;
    BOOL ifFirst;
    NSUserDefaults *userDefaults;
}
@property(nonatomic, strong) UITextField *userName;
@property(nonatomic, strong) UITextField *passWord;
@property(nonatomic, strong) UIButton *timeButton;
@end

@implementation RegistViewController


-(void)viewWillAppear:(BOOL)animated{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_background.png"]];
    backImage.frame = CGRectMake(0, 0, screen_width, screen_height-0);
    [self.view addSubview:backImage];
    [self initNavi];
    userDefaults = [NSUserDefaults standardUserDefaults];
 
    //user name
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(screen_width/8, 0+40, screen_width*6/8, 50)];
    self.userName.backgroundColor = [UIColor clearColor];
    [self.userName setBorderStyle:UITextBorderStyleRoundedRect];
    self.userName.layer.borderWidth = 1.0f;
    self.userName.layer.cornerRadius = 5;
    self.userName.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.userName.returnKeyType = UIReturnKeyDone;
    self.userName.textColor = [UIColor whiteColor];
    self.userName.placeholder = @"输入您的手机号";
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    self.userName.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    self.userName.tintColor = [UIColor whiteColor];
    //left view
    UIView *userNameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImageView *userNameIm =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_zhanghao.png"]];
    userNameIm.frame = CGRectMake(10, 10, 30, 30);
    [userNameView addSubview:userNameIm];
    self.userName.leftView = userNameView;
    self.userName.delegate = self;
    self.userName.text = [userDefaults stringForKey:@"userName"];
    //for test
    self.userName.text = @"15521332624";
    self.userName.tintColor = [UIColor whiteColor];
    //pass word
    self.passWord = [[UITextField alloc]initWithFrame:CGRectMake(screen_width/8, self.userName.frame.origin.y+self.userName.frame.size.height+20, screen_width*4/8, 50)];
    self.passWord.backgroundColor = [UIColor clearColor];
    self.passWord.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.passWord.layer.borderWidth = 1.0f;
    self.passWord.layer.cornerRadius = 5;
    [self.passWord setBorderStyle:UITextBorderStyleRoundedRect];
    self.passWord.secureTextEntry = YES;
    self.passWord.keyboardType = UIKeyboardTypeNumberPad;
    self.passWord.returnKeyType = UIReturnKeyDone;
    self.passWord.textColor = [UIColor whiteColor];
    self.passWord.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passWord.leftViewMode = UITextFieldViewModeAlways;
    self.passWord.delegate = self;
    
    //left view
    UIView *passWordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImageView *passWordIm = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_yanzheng.png"]];
    passWordIm.frame = CGRectMake(10, 10, 30, 30);
    [passWordView addSubview:passWordIm];
    self.passWord.leftView = passWordView;
    self.passWord.placeholder = @"输入验证码";
    self.passWord.text = [userDefaults stringForKey:@"passWord"];
    
    //time shedule
    self.timeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.passWord.frame.origin.x+self.passWord.frame.size.width+10, self.passWord.frame.origin.y, screen_width*2/8-10, 50)];
    self.timeButton.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.timeButton.layer.cornerRadius = 5;
    [self.timeButton setTitle:@"验证码" forState:UIControlStateNormal];
    [self.timeButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    
    //login button
    UIButton *loginBt = [[UIButton alloc]initWithFrame:CGRectMake(screen_width/8, self.timeButton.frame.origin.y+self.timeButton.frame.size.height+40, screen_width*6/8, 50)];
    loginBt.layer.cornerRadius = 5;
    loginBt.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    [loginBt addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.timeButton];
    [self.view addSubview:loginBt];
    
    //trainer button
    UIButton *trainerBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [trainerBt.layer setCornerRadius:10.0f];
    trainerBt.frame = CGRectMake(screen_width/4, loginBt.frame.origin.y+loginBt.frame.size.height+20, screen_width/2, 40);
    [trainerBt setTitle:@"您是教练？戳这里" forState:UIControlStateNormal];
    [trainerBt addTarget:self action:@selector(trainer:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:trainerBt];
}

//init navigationbar
-(void)initNavi {
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"登录";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//login
-(void)login:(id)sender{
    ifFirst = [userDefaults boolForKey:@"ifFirst"];
    if (!ifFirst) {
        NSLog(@"first login");
        [userDefaults setBool:YES forKey:@"ifFirst"];
    }
 
    //界面调试
    if (UI_DEBUG_NO_NETWORK) {
        g_sessionId = @"test";
        g_userId = @"test";
        AddDataTableViewController *nextVC =[[AddDataTableViewController alloc] init];
        
        UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
        [self presentViewController:naviViewController animated:YES completion:nil];
        return;
    }
//    if (![self checkInput]) {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"输入不能为空" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    NSString *url = HTTP_POST_URL_NSSTRING;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"LoginOrCreate" forKey:@"cmd"];
    [parameters setObject:self.userName.text forKey:@"Phone"];
    [parameters setObject:@"2" forKey:@"YanZhengMa"];
    [parameters setObject:@"0" forKey:@"Role_Id"];
 
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;

        if ([[revDic objectForKey:@"result"] intValue] != 1) {
             NSLog(@"login failed,success = 0");
            [EAPToast showWithText:[revDic objectForKey:@"message"] bottomOffset:10.0f];
            return;
        }else{
            g_sessionId = [revDic objectForKey:@"sessionId"];
            g_userId = [revDic objectForKey:@"userId"];
//            UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UINavigationController *mainViewController = [mainstoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
//            [self presentViewController:mainViewController animated:YES completion:nil];
            
                //首次登陆
                AddDataTableViewController *nextVC =[[AddDataTableViewController alloc] init];
                nextVC.ifFirst = YES;
                UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
                [self presentViewController:naviViewController animated:YES completion:nil];
        }
  


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [EAPToast showWithText:@"login failed" bottomOffset:5.0f];
         NSLog(@"https post fail, error: %@",error);
    }];

}

-(BOOL)checkInput {
    if ([self.userName.text isEqualToString:@""] || [self.passWord.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

//click trainer
-(void)trainer:(id)sender{
    
}

//send verification code
- (void)sendAction {
    self.timeButton.enabled = false;
    [MyTime verificationCode:^{
        [self.timeButton setTitle:@"发送验证码" forState:UIControlStateNormal] ;
        self.timeButton.enabled = true;
        
    } blockNo:^(id time) {
        [self.timeButton setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal] ;
    }];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    return YES;
}

//-(void)finish:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
