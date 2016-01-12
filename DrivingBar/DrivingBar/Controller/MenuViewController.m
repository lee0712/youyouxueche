//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "MenuViewController.h"
#import "public.h"
#import "MenuTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HEX.h"
#import "MyPageTableViewController.h"
#import "MyMesgViewController.h"
#import "MyTeacherTableViewController.h"
#import "MyDateTableViewController.h"
#import "MyProcessViewController.h"
#import "ShopViewController.h"
#import "SettingTableViewController.h"
#import "AFNetworking.h"
#import "VIPViewController.h"
#import "AddDataTableViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *headIm;
    UIButton *headBt;
    UILabel *headLevel;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *tableDataImname;
@end

@implementation MenuViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setTintColor:RGB_BACKGROUND_COLOR_BLUE];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    



}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setTintColor:RGB_BACKGROUND_COLOR_BLUE];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, screen_width, screen_height)];
    [self.view addSubview:self.tableView];
    //    //create imageview
    //    UIImageView *slideImageView = [[UIImageView alloc]init];
    //    slideImageView.image = [UIImage imageNamed:@"slide_menu_im"];
    //    slideImageView.frame = CGRectMake(screen_width/10,screen_height/10,screen_width/2,screen_height/8);
    //    [self.view addSubview:slideImageView];
    
    //取消横线的自动缩进
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    //设置委托和数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    //头部view
    [self setHeadView];
    //尾部view
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableDataSource = [[NSMutableArray alloc]init];
    self.tableDataImname = [[NSMutableArray alloc]init];
    [self.tableDataSource addObject:@"我的进度"];
    [self.tableDataSource addObject:@"我的消息"];
    [self.tableDataSource addObject:@"我的预约"];
    [self.tableDataSource addObject:@"优币商城"];
    [self.tableDataSource addObject:@"VIP保过"];
    [self.tableDataSource addObject:@"推荐给好友"];
    [self.tableDataSource addObject:@"设置"];
    
    [self.tableDataImname addObject:@"menu_jindu.png"];
    [self.tableDataImname addObject:@"menu_xiaoxi.jpg"];
    [self.tableDataImname addObject:@"menu_yuyue.png"];
    [self.tableDataImname addObject:@"menu_shangcheng.png"];
    [self.tableDataImname addObject:@"menu_vip.png"];
    [self.tableDataImname addObject:@"menu_tuijian.png"];
    [self.tableDataImname addObject:@"menu_shezhi.png"];
    
    self.tableView.scrollEnabled = NO;
     [self get_Data];
    [self.tableView reloadData];
   
      //slove the tableview headview hide problem when refresh
    // self.navigationController.navigationBar.translucent = NO;
    
    //更新
    [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(execute:)
                                                 name:@"NOTIFICATION_MENU"
                                                 object:nil];
}


-(void)get_Data{
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"GetUserForm" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
                [headIm sd_setImageWithURL:imUrl];
            }
            if (![[userDic objectForKey:@"nickName"]isEqual: [NSNull null]]) {
                [headBt setTitle:[userDic objectForKey:@"nickName"] forState:UIControlStateNormal];
            }
            headLevel.text=@"等级二";
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];

    
}

- (void)setHeadView {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, screen_width, 140+NAVI_AND_STATUS_HEIGHT)];
    UIImageView *backIm =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height)];
    backIm.image = [UIImage imageNamed:@"menu_back.png"];
    [headView addSubview:backIm];
   // UIColor *backColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_back.png"]];
   // headView.backgroundColor = backColor;
    
    //用户头像
    headIm = [[UIImageView alloc]init];
    
    headIm.frame = CGRectMake(headView.frame.size.width/2-90, 48,
                                 65, 65);
    headIm.userInteractionEnabled = YES;
    UITapGestureRecognizer *imTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickName:)];
    [headIm addGestureRecognizer:imTap];
    [headIm.layer setCornerRadius:CGRectGetHeight([headIm bounds]) / 2];
     headIm.layer.masksToBounds = YES;
    [headView addSubview:headIm];
    
    //用户名字
    headBt = [[UIButton alloc]initWithFrame:CGRectMake(headIm.frame.origin.x-50, headIm.frame.origin.y+headIm.frame.size.height+16, 165, 20)];
   // [headBt setTitle:@"学员" forState:UIControlStateNormal];
    [headBt.layer setCornerRadius:6.0f];
    headBt.titleLabel.font = [UIFont systemFontOfSize:16];
    headBt.titleLabel.textColor = [UIColor blackColor];
    headBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [headBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headBt addTarget:self action:@selector(clickName:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:headBt];
    
    headLevel = [[UILabel alloc]initWithFrame:CGRectMake(headIm.frame.origin.x-50, headBt.frame.origin.y+headBt.frame.size.height+12, 165, 15)];
    headLevel.font=[UIFont systemFontOfSize:10];
    headLevel.textColor = RGB_BACKGROUND_COLOR_RED;
    headLevel.textAlignment = UITextAlignmentCenter;
    [headView addSubview:headLevel];
    self.tableView.tableHeaderView =headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableDataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TopAPs";
    MenuTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *title = [self.tableDataSource objectAtIndex:indexPath.row];
    cell.menuLabel.text = title;
    cell.menuIm.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:indexPath.row]];
    
    return cell;
}

//删除缩进
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //我的进度
            MyProcessViewController *nextVC =[[MyProcessViewController alloc] init];
       
            UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
            [self presentViewController:naviViewController animated:YES completion:nil];
            break;
        }
        case 1:{
            //我的消息
            MyMesgViewController *nextVC =[[MyMesgViewController alloc] init];
            
            UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
            [self presentViewController:naviViewController animated:YES completion:nil];
            break;
        }
        case 2:{
            //预约
            MyDateTableViewController *nextVC =[[MyDateTableViewController alloc] init];
            
            UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
            [self presentViewController:naviViewController animated:YES completion:nil];
            break;
     
        }
        case 3:{
            //优币商城
            ShopViewController *nextVC =[[ShopViewController alloc] init];
            
            UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
            [self presentViewController:naviViewController animated:YES completion:nil];
            break;
        }
        case 4:{
            //vip保过
            VIPViewController *nextVC =[[VIPViewController alloc] init];
            
            UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
            [self presentViewController:naviViewController animated:YES completion:nil];
            break;
        }
        case 5:{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"尚未开发" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [alert show];
            break;
        }
        case 6:{
            //设置
            SettingTableViewController *nextVC =[[SettingTableViewController alloc] init];
            UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
            [self presentViewController:naviViewController animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

-(void)clickName:(id)sender{
    AddDataTableViewController *nextVC =[[AddDataTableViewController alloc] init];
    nextVC.ifFirst = NO;
    UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
    [self presentViewController:naviViewController animated:YES completion:nil];
}

- (void)execute:(NSNotification *)notification {
 //do something
    [self get_Data];
}

@end
