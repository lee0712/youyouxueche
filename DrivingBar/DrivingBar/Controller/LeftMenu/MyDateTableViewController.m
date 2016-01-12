//
//  MyPageTableViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "AFNetworking.h"
#import "MyDateTableViewCell.h"
#import "EvaluateViewController.h"
#import "MyDateTableViewController.h"

@interface MyDateTableViewController (){
    
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@end

@implementation MyDateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    NSDictionary *titleColorDic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    //    self.navigationController.navigationBar.titleTextAttributes = titleColorDic;
    //
    //delete useless line
    [self setHeadView];
    self.tableView.separatorStyle = NO;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableDataSource = [[NSMutableArray alloc]init];
    
    //self.tableView.scrollEnabled = NO;
    [self getData];
   
}

-(void)initNavi {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"我的预约", nil);
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

- (void)setHeadView {
    //no head view
}


-(void)getData{

    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"GetpHallPre_OrderList" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"SessionId"];
    [parameters setObject:g_userId forKey:@"User_ID"];
    [parameters setValue:@"30" forKey:@"Pagesize"];
    [parameters setValue:[NSNumber numberWithInt:1] forKey:@"PageNum"];

    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        
        NSMutableArray *dataArray = [responseObject objectForKey:@"dataList"];
        for (int i=0; i<dataArray.count; i++) {
            [self.tableDataSource addObject:[dataArray objectAtIndex:i]];
        }
        [self.tableView reloadData];
        // NSDictionary *revDic = (NSDictionary*)responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"mydate";
    MyDateTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        cell = [[MyDateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"companyName"];
    cell.dateLabel.text =[[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"date"];
    int status =[[[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"status"]intValue];
    NSString *nsStatus = @"";
    if (status == 0) {
        nsStatus = @"正在处理";
    }else if (status ==1){
        nsStatus = @"已经预约";
    }else if (status ==2){
        nsStatus = @"已经体验";
    }
    
    cell.jinduLabel.text = nsStatus;
    [cell.pingjiaButton addTarget:self action:@selector(pingjiaAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.pingjiaButton.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //            MyPageTableViewController *nextVC = [[MyPageTableViewController alloc] init];
            //            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        default:
            break;
    }
}

-(void)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pingjiaAction:(UIButton*)sender{
    EvaluateViewController *nextVC = [[EvaluateViewController alloc] init];
    nextVC.id = [[self.tableDataSource objectAtIndex:sender.tag]objectForKey:@"companyId"];
   // nextVC.nickName = nickName;
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
