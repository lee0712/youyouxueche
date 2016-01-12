//
//  MyPageTableViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "TrainerTableViewController.h"
#import "AFNetworking.h"

@interface TrainerTableViewController (){
    //UISearchDisplayController *searchDisplayController;
    NSArray *filterData;
    UITextField *searchTx;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *tableDataImname;
@end

@implementation TrainerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"trainer vc load");
    [self initNavi];
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    //delete useless line
    [self setHeadView];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.scrollEnabled = NO;
   
    
    [self.tableView reloadData];
}

-(void)initNavi {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //标题
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"选择教练", nil);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4,BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

- (void)getData{
    self.tableDataSource = [[NSMutableArray alloc]init];
    self.tableDataImname = [[NSMutableArray alloc]init];

    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    NSString *url = HTTP_POST_URL_NSSTRING;
    //获取教练列表

    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"GetpTrainListByNike_Name" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:searchTx.text forKey:@"Nick_Name"];
    [parameters setValue:@"20" forKey:@"Pagesize"];
    [parameters setValue:@"1" forKey:@"PageNum"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            NSMutableArray *dataArray = [revDic objectForKey:@"dataList"];
            for (int i=0; i<dataArray.count; i++) {
                [self.tableDataSource addObject:[dataArray objectAtIndex:i]];
            }
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    

}
- (void)setHeadView {
//    //搜索框
//    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, screen_width, 44)];
//    searchBar.placeholder = @"搜索";
//    self.tableView.tableHeaderView = searchBar;
//    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
//    //代理
//    searchDisplayController.searchResultsDataSource = self;
//    searchDisplayController.searchResultsDelegate = self;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 60)];
    headView.backgroundColor = [UIColor clearColor];
    UIView *searchBtView = [[UIView alloc]initWithFrame:CGRectMake(10, 10,headView.frame.size.height-20, headView.frame.size.height-20)];
    searchBtView.backgroundColor = [UIColor whiteColor];
    UIButton *searchBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBt.frame = CGRectMake(10, 10,searchBtView.frame.size.height-20, searchBtView.frame.size.height-20);
    [searchBt setBackgroundImage:[UIImage imageNamed:@"searchbar"] forState:UIControlStateNormal];
    [searchBt addTarget:self action:@selector(searchBt:) forControlEvents:UIControlEventTouchUpInside];
    
    [searchBtView addSubview:searchBt];
    [headView addSubview:searchBtView];
    
    searchTx = [[UITextField alloc]initWithFrame:CGRectMake(searchBtView.frame.origin.x+searchBtView.frame.size.width,searchBtView.frame.origin.y, headView.frame.size.width-20-searchBtView.frame.size.width, headView.frame.size.height-20)];
    //[nickNameTx setBorderStyle:UITextBorderStyleRoundedRect];
    searchTx.returnKeyType = UIReturnKeySearch;
    //name.placeholder = _userName;
    searchTx.delegate = self;
    searchTx.backgroundColor = [UIColor whiteColor];
    [headView addSubview:searchTx];
    self.tableView.tableHeaderView = headView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView == self.tableView) {
        return self.tableDataSource.count;
//    }else {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchDisplayController.searchBar.text];
//        filterData = [[NSArray alloc]initWithArray:[self.tableDataSource filteredArrayUsingPredicate:predicate]];
//        return filterData.count;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"trainer";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    if (tableView == self.tableView) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSDictionary *dic = [self.tableDataSource objectAtIndex:indexPath.row];
        if ([[dic objectForKey:@"nickName"] isEqual:[NSNull null]]) {
            cell.textLabel.text=@"";
        }else{
            cell.textLabel.text = [dic objectForKey:@"nickName"];
        }
       // cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:indexPath.row]];
        cell.imageView.image = [UIImage imageNamed:@"menu_user.png"];
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString *title = [filterData objectAtIndex:indexPath.row];
        cell.textLabel.text = title;
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if ([[[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"nickName"] isEqual:[NSNull null]]) {
            [self.delegate passTrainer:@""];
        }else{
        
        [self.delegate passTrainer:[[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"nickName"]];
        }
    }else {
        [self.delegate passTrainer:[filterData objectAtIndex:indexPath.row]];
    }
       [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)finish:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)save:(id)sender {
 
}
-(void)searchBt:(id)sender {
    NSLog(@"search");
     [self getData];
}

//键盘返回键
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    //开始搜索
    [self getData];
    [searchTx resignFirstResponder];
    return YES;
}
//点击空白处收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [searchTx resignFirstResponder];
}

@end
