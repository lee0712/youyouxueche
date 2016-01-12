//
//  ClientsViewController.m
//  EAPController
//
//  Created by admin on 15/9/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "EnrollViewController.h"
#import "public.h"
#import "UIColor+HEX.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "EnrollSelectTableViewController.h"
#import "PPiFlatSegmentedControl.h"

@interface EnrollViewController()<UITextFieldDelegate>
{
    long selectedIndex;
}
@property(nonatomic, strong) UITextField *userName;
@property(nonatomic, strong) UITextField *phoneNum;
@end

@implementation EnrollViewController

- (void)loadView {
    [super loadView];
    [self setup];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"报名学车", nil);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
    self.tabBarController.navigationItem.titleView = titleLabel;
    //[tableView triggerPullToRefresh];

}
- (void)viewDidAppear:(BOOL)animated {
   
}

#pragma mark - Actions
- (void)initView {
    //背景色
    self.view.backgroundColor = [UIColor whiteColor];
   
    
     //启动其他vc时，自身view错位Bug的解决方法
    [self.view addSubview:[[UIView alloc]init]];
    
    UIImageView *backImView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 160)];
    backImView.image = [UIImage imageNamed:@"baoming_back.png"];
    [self.view addSubview:backImView];

    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, backImView.frame.origin.y+backImView.frame.size.height, screen_width, 10)];
    backView1.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    [self.view addSubview:backView1];
    //选择驾校和教练
    UILabel *selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, backImView.frame.origin.y+backImView.frame.size.height+10, screen_width, 50)];
    selectLabel.textAlignment = UITextAlignmentCenter;
    selectLabel.backgroundColor = [UIColor whiteColor];
    selectLabel.text = @"全国30家驾校，288名认证教练";
    //点击事件
    selectLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTouchUpInside:)];
    [selectLabel addGestureRecognizer:labelTapGestureRecognizer];
    [self.view addSubview:selectLabel];
    //右箭头
    UIImageView *selectRightImView = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width-40, selectLabel.frame.origin.y+15, 15, 20)];
    selectRightImView.image = [UIImage imageNamed:@"right_im"];
    [self.view addSubview:selectRightImView];
    
    UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(0, selectLabel.frame.origin.y+selectLabel.frame.size.height, screen_width, 10)];
    backView2.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_GRAY alpha:1.0f];
    [self.view addSubview:backView2];
    
    //选择您要报考的类型
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, selectLabel.frame.origin.y+selectLabel.frame.size.height+10, screen_width, 30)];
    typeLabel.backgroundColor = [UIColor clearColor];
    typeLabel.text = @"选择您要报考的类型";
    [self.view addSubview:typeLabel];
    
    //报考类型分栏
    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc]
                                        initWithFrame:CGRectMake(screen_width/4, typeLabel.frame.origin.y+typeLabel.frame.size.height+10, screen_width*1/2, 40)
                                        items:
                                        @[@{@"text":NSLocalizedString(@"C1手动档", nil)},
                                          @{@"text":NSLocalizedString(@"陪练", nil)},
                                          ]
                                        iconPosition:IconPositionRight
                                        andSelectionBlock:^(NSUInteger segmentIndex) {
                                            switch (segmentIndex) {
                                                case 0:
                                                    selectedIndex = 0;
                                                    break;
                                                case 1:
                                                    selectedIndex = 1;
                                                    break;
                                                default:
                                                    break;
                                            }
                                        }];
    segmented.color=[UIColor whiteColor];
    segmented.borderColor=[UIColor  colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    segmented.borderWidth = 1.0f;
    segmented.selectedColor=[UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                               NSForegroundColorAttributeName:[UIColor  colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented];
    
    //user name
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(screen_width/8, segmented.frame.origin.y+segmented.frame.size.height+10, screen_width*6/8, 40)];
    self.userName.backgroundColor = [UIColor clearColor];
    [self.userName setBorderStyle:UITextBorderStyleRoundedRect];
    self.userName.returnKeyType = UIReturnKeyDone;
    self.userName.placeholder = @"";
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    //左边文字
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    nameView.backgroundColor = [UIColor clearColor];
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    userLabel.text = @"姓名";
    userLabel.textColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
   
    UIView *nameLineView = [[UIView alloc]initWithFrame:CGRectMake(69, 5, 1, 30)];
    nameLineView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
     [nameView addSubview:userLabel];
    [nameView addSubview:nameLineView];
    self.userName.leftView = nameView;
    self.userName.delegate = self;
    //phone number
    self.phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(screen_width/8, self.userName.frame.origin.y+self.userName.frame.size.height+10, screen_width*6/8, 40)];
    self.phoneNum.backgroundColor = [UIColor clearColor];
    [self.phoneNum setBorderStyle:UITextBorderStyleRoundedRect];
    //self.phoneNum.secureTextEntry = YES;
    self.phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNum.returnKeyType = UIReturnKeyDone;
    self.phoneNum.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNum.delegate = self;
    //左边文字
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    UIView *phoneLineView = [[UIView alloc]initWithFrame:CGRectMake(69, 5, 1, 30)];
    phoneLineView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    phoneLabel.text = @"手机号";
    phoneLabel.textColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    [phoneView addSubview:phoneLabel];
    [phoneView addSubview:phoneLineView];
    self.phoneNum.leftView = phoneView;
    self.phoneNum.placeholder = @"";
    
    //login button
    UIButton *loginBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginBt.layer setCornerRadius:10.0f];
    loginBt.frame = CGRectMake(screen_width/8, self.phoneNum.frame.origin.y+self.phoneNum.frame.size.height+20, screen_width*6/8, 40);
    loginBt.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    [loginBt setTitle:NSLocalizedString(@"提交报名", nil) forState:UIControlStateNormal];
    [loginBt addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.phoneNum];
    [self.view addSubview:loginBt];

    
}

- (void) initData {
    selectedIndex = 0;
    [self getData];
}
- (void)getData {
}

- (void)setup {
}

//提交
-(void)submit:(id)sender{
        AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
        NSString *url = HTTP_POST_URL_NSSTRING;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:@"AddUser_Sign_Up" forKey:@"cmd"];
        [parameters setObject:[[NSNumber numberWithLong:selectedIndex]stringValue] forKey:@"Type"];
        [parameters setObject:self.phoneNum.text forKey:@"Phone"];
        [parameters setObject:self.userName.text forKey:@"Name"];
    
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"https post ok,object:%@",responseObject);
            NSDictionary *resDic = (NSDictionary*)responseObject;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"报名成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                            [alert show];
            
//            if ([[resDic objectForKey:@"result"] intValue] == 1) {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"报名成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
//                [alert show];
//            }else{
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"报名失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
//                [alert show];
//             
//            }
            
            // NSDictionary *revDic = (NSDictionary*)responseObject;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alert show];
            NSLog(@"https post fail, error: %@",error);
        }];
    
}

-(void)selectTouchUpInside:(UITapGestureRecognizer*)recognizer{
    NSLog(@"tap select ");
    //vip保过
    EnrollSelectTableViewController *nextVC =[[EnrollSelectTableViewController alloc] init];
    
    UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
    [self presentViewController:naviViewController animated:YES completion:nil];

}

//键盘挡住输入框时屏幕上移
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset = (frame.origin.y+120) - (self.view.frame.size.height -216);
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    if (offset>0) {
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

//键盘隐藏时屏幕还原
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.userName resignFirstResponder];
    [self.phoneNum resignFirstResponder];
    return YES;
}
//点击空白处收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userName resignFirstResponder];
    [self.phoneNum resignFirstResponder];
}
@end
