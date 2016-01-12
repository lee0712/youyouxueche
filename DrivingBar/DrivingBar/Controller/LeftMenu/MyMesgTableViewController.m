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
#import "MyMsgTableViewCell.h"
#import "MyMesgDetailViewController.h"
#import "MyMesgTableViewController.h"

@interface MyMesgTableViewController (){
    
}
@property (nonatomic, strong) NSMutableArray *tableDataSource1;    //标题
@property (nonatomic, strong) NSMutableArray *tableDataSource2;     //时间
@property (nonatomic, strong) NSMutableArray *tableDataSource3;
@property (nonatomic, strong) NSMutableArray *tableDataImname;

@end

@implementation MyMesgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"msg view didload");
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableDataSource1 = [[NSMutableArray alloc]init];
    self.tableDataSource2 = [[NSMutableArray alloc]init];
    self.tableDataImname = [[NSMutableArray alloc]init];
    [self getData];

    //self.tableView.scrollEnabled = NO;
    
}

- (void)getData {
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (self.pageNum == 0) {
        //获取系统消息
    
        [parameters setObject:@"GetBroadcastMessage" forKey:@"cmd"];
        [parameters setObject:g_sessionId forKey:@"sessionId"];
        [parameters setValue:@"20" forKey:@"Pagesize"];
        [parameters setValue:[NSNumber numberWithInt:1] forKey:@"PageNum"];
    
    }else if (self.pageNum == 1){
        //获取我的回复
        [parameters setObject:@"GetTypeMessage" forKey:@"cmd"];
        [parameters setObject:g_sessionId forKey:@"sessionId"];
        [parameters setObject:g_userId forKey:@"User_Id"];
        [parameters setObject:@"1" forKey:@"Type"];
        [parameters setValue:@"20" forKey:@"Pagesize"];
        [parameters setValue:[NSNumber numberWithInt:1] forKey:@"PageNum"];

    }else if (self.pageNum == 2){
    
        //获取我的赞
        [parameters setObject:@"GetTypeMessage" forKey:@"cmd"];
        [parameters setObject:g_sessionId forKey:@"sessionId"];
        [parameters setObject:g_userId forKey:@"User_Id"];
        [parameters setObject:@"2" forKey:@"Type"];
        [parameters setValue:@"20" forKey:@"Pagesize"];
        [parameters setValue:[NSNumber numberWithInt:1] forKey:@"PageNum"];
   
    }
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post1 ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        NSArray *revArray = [revDic objectForKey:@"dataList"];
        for (int i=0; i<revArray.count; i++) {
            if ([[[revArray objectAtIndex:i] objectForKey:@"relevantTitle"] isEqual:[NSNull null]]) {
                [self.tableDataSource1 addObject:@""];
            }else {
                [self.tableDataSource1 addObject:[[revArray objectAtIndex:i] objectForKey:@"relevantTitle"]];
            }
            if ([[[revArray objectAtIndex:i] objectForKey:@"sendDate"] isEqual:[NSNull null]]) {
                [self.tableDataSource2 addObject:@""];
            }else {
                [self.tableDataSource2 addObject:[[revArray objectAtIndex:i] objectForKey:@"sendDate"]];
            }
            [self.tableDataImname addObject:@"menu_user.png"];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource1.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"pingluncell";
    MyMsgTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [[MyMsgTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.userImageView.image = [UIImage imageNamed:@"menu_user.png"];
   // cell.userCommentLabel.text = @"哇本宫把我告别微博个";
    cell.userCommentLabel.text = [self.tableDataSource1 objectAtIndex:indexPath.row];
    cell.detailLabel.text = @"点击查看";
   // cell.timeLabel.text = @"2015-12-12";
    cell.timeLabel.text = [self.tableDataSource2 objectAtIndex:indexPath.row];
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMesgDetailViewController *nextVC =[[MyMesgDetailViewController alloc] init];
    //    UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:clientsVC];
    //    [[self viewController] presentViewController:naviViewController animated:YES completion:nil];
    
    nextVC.sign =[self.tableDataSource1 objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nextVC animated:YES];
}
-(void)OnFilterBtn:(UIButton *)sender{
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        UIButton *sanjiaoBtn = (UIButton *)[self.view viewWithTag:120+i];
        btn.selected = NO;
        sanjiaoBtn.selected = NO;
    }
    sender.selected = YES;
    UIButton *sjBtn = (UIButton *)[self.view viewWithTag:sender.tag+20];
    sjBtn.selected = YES;
}
-(void)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
