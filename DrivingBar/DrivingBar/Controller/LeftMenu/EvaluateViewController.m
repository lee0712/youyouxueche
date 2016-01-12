//
//  NickNameViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/14.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "EvaluateViewController.h"
#import "EAPToast.h"
#import "AFNetworking.h"
#import "FinalStarRatingBar.h"

@interface EvaluateViewController ()<UITextViewDelegate>{
    UITextView *nickNameTx;
    FinalStarRatingBar *bar;
    unsigned long barNum;
}

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    nickNameTx = [[UITextView alloc]initWithFrame:CGRectMake(20, 10, screen_width-40, 80)];
    nickNameTx.returnKeyType = UIReturnKeyDone;
    //name.placeholder = _userName;
    //nickNameTx.text = self.sign;
    nickNameTx.font = [UIFont boldSystemFontOfSize:18];
    nickNameTx.delegate = self;
    nickNameTx.backgroundColor = [UIColor whiteColor];
    nickNameTx.returnKeyType = UIReturnKeyDefault;
    nickNameTx.tintColor = [UIColor blackColor];
    //禁止自动居中
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:nickNameTx];
    //星级评分
    UILabel *barLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, nickNameTx.frame.origin.y+nickNameTx.frame.size.height+10, 100, 40)];
    barLabel.text = @"评分";
    barLabel.textColor = [UIColor redColor];
     [self.view addSubview:barLabel];
    bar = [[FinalStarRatingBar alloc] initWithFrame:CGRectMake(screen_width-160, nickNameTx.frame.origin.y+nickNameTx.frame.size.height+10, 140, 40) starCount:5];
    [self.view addSubview:bar];
    [bar setRating:5];
    barNum = 5;
    //using block
    [bar setRatingChangedBlock:^(NSUInteger rating) {
        dispatch_async(dispatch_get_main_queue(), ^{
            barNum = (unsigned long)rating;
        });
    }];
}

-(void)initNavi {
    self.view.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"评价", nil);
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
    if ([nickNameTx.text length]>50) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"最多输入50个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [alert show];
    }else{
        AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
        
        NSString *url = HTTP_POST_URL_NSSTRING;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:@"AddCom_Appraise" forKey:@"cmd"];
        [parameters setObject:g_sessionId forKey:@"sessionId"];
        [parameters setObject:g_userId forKey:@"User_Id"];
        [parameters setObject:self.id forKey:@"Com_ID"];
        [parameters setObject:nickNameTx.text forKey:@"Content"];
        [parameters setObject:[NSNumber numberWithLong:barNum] forKey:@"Appraise1"];
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"https post ok,object:%@",responseObject);
            NSDictionary *revDic = (NSDictionary*)responseObject;
            
            if ([[revDic objectForKey:@"result"] intValue] != 1) {
                NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
                return;
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"https post fail, error: %@",error);
        }];
    }
}

@end
