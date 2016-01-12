//
//  MyProcessViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/8.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "Kemu1View.h"
#import "Kemu2View.h"
#import "Kemu3View.h"
#import "UIImageView+WebCache.h"
#import "Kemu4View.h"
#import "UIColor+HEX.h"
#import "VZSliderFilter.h"
#import "AFNetworking.h"
#import "MyProcessViewController.h"

@interface MyProcessViewController (){
    UIImageView *headImageView;
    UILabel *headLabel;
    NSArray *titles;
    UILabel *learnProLabel;
    UILabel *rateLabel;
    UIImageView *phoneImView;
    
    Kemu1View *kemu1View;
    Kemu2View *kemu2View;
    Kemu3View *kemu3View;
    Kemu4View *kemu4View;
    VZSliderFilter *slider;
}

@end
@implementation MyProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    if (titles == nil) {
        titles = @[@"科目一", @"科目二", @"科目三", @"科目四", @"拿驾照"];
    }
    //line
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 8)];
    lineView1.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [self.view addSubview:lineView1];
    
    //create imageview
    headImageView = [[UIImageView alloc]init];
    headImageView.frame = CGRectMake(16,lineView1.frame.size.height+lineView1.frame.origin.y+16,
                                 45,45);
    [self.view addSubview:headImageView];
    [headImageView.layer setCornerRadius:CGRectGetHeight([headImageView bounds]) / 2];
   headImageView.layer.masksToBounds = YES;
    headLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.frame.origin.x+headImageView.frame.size.width+16, headImageView.frame.origin.y+8, 100, 10)];
    headLabel.textColor=[UIColor blackColor];
   // headLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:headLabel];
    //等级
    rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(headLabel.frame.origin.x, headLabel.frame.origin.y+headLabel.frame.size.height+12, 100, 8)];
    rateLabel.textColor=RGB_BACKGROUND_COLOR_RED;
    rateLabel.font = [UIFont systemFontOfSize:11];
   // headLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rateLabel];
    //电话
    phoneImView = [[UIImageView alloc]init];
    phoneImView.frame = CGRectMake(screen_width-36-35,lineView1.frame.size.height+lineView1.frame.origin.y+23,35,35);
    phoneImView.image = [UIImage imageNamed:@"jindu_dianhua"];
    phoneImView.userInteractionEnabled = YES;
    UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneCall:)];
    [phoneImView addGestureRecognizer:phoneTap];
    [self.view addSubview:phoneImView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(16, lineView1.frame.size.height+lineView1.frame.origin.y+78, screen_width, 1)];
    lineView2.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [self.view addSubview:lineView2];
    
    //进度条
    slider = [[VZSliderFilter alloc] initWithFrame:CGRectMake(screen_width/4, lineView2.frame.origin.y+lineView2.frame.size.height+30-20,screen_width/2, 60) andTitlesArray:@[@"科目1",@"科目2",@"科目3",@"科目4"]];
    [slider addTarget:self action:@selector(slideValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, lineView2.frame.size.height+lineView2.frame.origin.y+78, screen_width, 8)];
    lineView3.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [self.view addSubview:lineView3];
    
    //学习记录
    learnProLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineView3.frame.origin.y+lineView3.frame.size.height+10, 100, 30)];
    learnProLabel.text = @"学习记录";
    learnProLabel.font = [UIFont fontWithName:@"Helverica-Bold" size:15];
    learnProLabel.textColor=[UIColor blackColor];
    learnProLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:learnProLabel];
    
    //四个科目的view
    kemu1View = [[Kemu1View alloc] initWithFrame:CGRectMake(0, learnProLabel.frame.origin.y+learnProLabel.frame.size.height+10, screen_width, screen_height)];
    
    kemu2View = [[Kemu2View alloc] initWithFrame:CGRectMake(0, learnProLabel.frame.origin.y+learnProLabel.frame.size.height+10, screen_width, screen_height)];
    kemu3View = [[Kemu3View alloc] initWithFrame:CGRectMake(0, learnProLabel.frame.origin.y+learnProLabel.frame.size.height+10, screen_width, screen_height)];
    kemu4View = [[Kemu4View alloc] initWithFrame:CGRectMake(0, learnProLabel.frame.origin.y+learnProLabel.frame.size.height+10, screen_width, screen_height)];
    
    [self getData];
}

//初始化标题栏
-(void)initNavi {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"学习进度", nil);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

-(void)getData{
    
    headImageView.image = [UIImage imageNamed:@"default_user_im"];
    headLabel.text = @"学员";
    rateLabel.text = @"等级二";
    //学习进度
  
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"GetLearn_Process" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"SessionId"];
    [parameters setObject:g_userId forKey:@"User_ID"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        NSDictionary *revForum = (NSDictionary*)[revDic objectForKey:@"forumdetailform"];
        [kemu1View setupDataSource:[NSString stringWithFormat:@"%@",[revForum objectForKey:@"k1Ration"]] Score:[NSString stringWithFormat:@"%@",[revForum objectForKey:@"k1Scorce"]] Pass:[NSString stringWithFormat:@"%@",[revForum objectForKey:@"k1Times"]]];
      
       [kemu3View setupDataSource:[[revForum objectForKey:@"k3Ratio"]stringValue ] Score:[[revForum objectForKey:@"k3Scorce"]stringValue ] Pass:[[revForum objectForKey:@"k3Times"] stringValue]];
        [kemu4View setupDataSource:[[revForum objectForKey:@"k4Ratio"]stringValue ] Score:[[revForum objectForKey:@"k4Scorce"]stringValue ] Pass:[[revForum objectForKey:@"k4Times"]stringValue ]];
        NSLog(@"slide index:  %@",[revForum objectForKey:@"learnProcess"]);
        
        [slider setSelectedIndex:([[revForum objectForKey:@"learnProcess"] intValue]-1)];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
    NSMutableDictionary *parameters2 = [[NSMutableDictionary alloc]init];
    [parameters2 setObject:@"getTimuRadion" forKey:@"cmd"];
    [parameters2 setObject:g_sessionId forKey:@"SessionId"];
    [parameters2 setObject:@"001" forKey:@"SYS_ID"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters2);
    [loginManager GET:url parameters:parameters2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        if ([[revDic objectForKey:@"result"]intValue] == 1) {
            NSDictionary *revForum = (NSDictionary*)[revDic objectForKey:@"kemupassradioform"];
            
            [kemu2View setupDataSource:[[revForum objectForKey:@"k2DaoChe"] stringValue] V2:[[revForum objectForKey:@"k2CeFang"] stringValue] V3:[[revForum objectForKey: @"k2ZhuanWan"] stringValue] V4:[[revForum objectForKey:@"k2ZhiJiao"] stringValue] V5:[[revForum objectForKey:@"k2BanBo"] stringValue]];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
    
    NSMutableDictionary *parameters3 = [[NSMutableDictionary alloc]init];
    [parameters3 setObject:@"GetUserForm" forKey:@"cmd"];
    [parameters3 setObject:g_sessionId forKey:@"sessionId"];
    [parameters3 setObject:g_userId forKey:@"User_Id"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters3 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            NSDictionary *userDic = [revDic objectForKey:@"userinfoform"];
            
            if (![[userDic objectForKey:@"photo"]isEqual: [NSNull null]]) {
                NSString *tmpUrl = [userDic objectForKey:@"photo"];
                NSString *nsUrl = [[NSString alloc]initWithFormat:@"%@%@",HTTP_IMG_URL_NSSTRING,tmpUrl];
                NSURL *imUrl = [[NSURL alloc]initWithString:nsUrl];
                g_userImUrl = imUrl;
                [headImageView sd_setImageWithURL:imUrl];
            }
            if (![[userDic objectForKey:@"nickName"]isEqual: [NSNull null]]) {
                headLabel.text = [userDic objectForKey:@"nickName"];
            }
            rateLabel.text=@"等级二";
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
}

-(void)slideValueChanged:(VZSliderFilter *)slide
{
    NSLog(@"选中 index = %ld",slide.selectedIndex);
 
    if (kemu1View.superview) {
        [kemu1View removeFromSuperview];
    }
    if (kemu2View.superview) {
        [kemu2View removeFromSuperview];
    }
    if (kemu3View.superview) {
        [kemu3View removeFromSuperview];
    }
    if (kemu4View.superview) {
        [kemu4View removeFromSuperview];
    }
    switch (slide.selectedIndex) {
        case 0:{
            if (!kemu1View.superview) {
                [self.view addSubview:kemu1View];
            }
            break;
        }
        case 1:{
            if (!kemu2View.superview) {
                [self.view addSubview:kemu2View];
            }
            break;
        }
        case 2:{
            if (!kemu3View.superview) {
                [self.view addSubview:kemu3View];
            }
            break;
        }
        case 3:{
            if (!kemu4View.superview) {
                [self.view addSubview:kemu4View];
            }
            break;
        }
        default:
            break;
    }
}

-(void)phoneCall:(id)sender{
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"telprompt://%@",@"10086"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}

-(void)finish:(id)sender {
    long silderIndex = slider.selectedIndex +1;
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"UpdateLearn" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    [parameters setObject:[NSNumber numberWithLong:silderIndex] forKey:@"Learn_Process"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        // NSDictionary *revDic = (NSDictionary*)responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
