//
//  MyPageTableViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "TLCityPickerController.h"
#import "UIColor+HEX.h"
#import "RegistViewController.h"
#import "AppDelegate.h"
#import "AboutUsViewController.h"
#import "SettingTableViewController.h"

@interface SettingTableViewController ()<TLCityPickerDelegate>{
    NSString *region;
    NSString *tiku;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *tableDetailDataSource;

@property (nonatomic, strong) NSMutableArray *tableDataImname;

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    //分组样式
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //去缩进
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //tableview头部
    [self setHeadView];
    //tableview尾部
    [self setFootView];

    //关闭滑动
    self.tableView.scrollEnabled = NO;
    [self getData];
    //更新数据
    [self.tableView reloadData];
}

-(void)initNavi {
    self.view.backgroundColor = [UIColor whiteColor];
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"设置", nil);
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    titleLabel.textColor=[UIColor whiteColor];
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
    //初始化
    self.tableDataSource = [[NSMutableArray alloc]init];
    self.tableDetailDataSource = [[NSMutableArray alloc]init];
    
    self.tableDataImname = [[NSMutableArray alloc]init];
    
    [self.tableDataSource addObject:@"报考地区"];
    [self.tableDataSource addObject:@"我的题库"];
    [self.tableDataSource addObject:@"清除缓存"];
    [self.tableDataSource addObject:@"关于我们"];
    [self.tableDataSource addObject:@"退出登录"];
    
    [self.tableDataImname addObject:@"setting_dingwei.png"];
    [self.tableDataImname addObject:@"setting_tiku.png"];
    [self.tableDataImname addObject:@"setting_huancun.png"];
    [self.tableDataImname addObject:@"setting_guanyu.png"];
    region = @"广州";
    tiku = @"C1";
}
- (void)setHeadView {
    //no headview
}
- (void)setFootView {
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 50)];
    footView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    UIButton *loginOutBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginOutBt.frame = CGRectMake(0, 0,screen_width, 50);
    loginOutBt.backgroundColor = [UIColor whiteColor];
    [loginOutBt setTitle:@"退出登录" forState:UIControlStateNormal];
    
    loginOutBt.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [loginOutBt setTitleColor:RGB_BACKGROUND_COLOR_RED forState:UIControlStateNormal];
    [loginOutBt addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    loginOutBt.titleLabel.font =  [UIFont systemFontOfSize:16];
    [footView addSubview:loginOutBt];
    self.tableView.tableFooterView = footView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numOfRows = 0;
    switch (section) {
        case 0:{
            numOfRows = 2;
            break;
        }
        case 1:{
            numOfRows = 2;
            break;
        }
  
        default:
            break;
    }
    return numOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Settings";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [self.tableDataSource objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = region;
            cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:indexPath.row]];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = [self.tableDataSource objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = tiku;
            cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:indexPath.row]];
        }
       
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [self.tableDataSource objectAtIndex:2];
            cell.detailTextLabel.text = @"";
            cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:2]];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = [self.tableDataSource objectAtIndex:3];
            cell.detailTextLabel.text = @"";
            cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:3]];
        }
        
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
            [cityPickerVC setDelegate:self];
            //默认显示广州市，启动gps后更新此数据
            cityPickerVC.locationCityID = @"300110000";
            //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
            cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
            
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
                
            }];
        }
        if (indexPath.row == 1) {
        }
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
        }
        if (indexPath.row == 1) {
            
            //关于我们
            AboutUsViewController *nextVC =[[AboutUsViewController alloc] init];
            
            UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
            [self presentViewController:naviViewController animated:YES completion:nil];
           
        }
    }
    
    if (indexPath.section == 2) {
    }
    
}

#pragma mark - TLCityPickerDelegate
//选择城市回调
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    region = city.cityName;
    [self.tableView reloadData];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loginOut:(id)sender {
    //login out
    RegistViewController *probeVC =[[RegistViewController alloc] init];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = probeVC;

}

@end
