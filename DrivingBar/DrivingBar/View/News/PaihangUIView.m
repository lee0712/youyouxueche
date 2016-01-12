//
//  APDetailTableView.m
//  EAPController
//
//  Created by admin on 15/9/11.
//  Copyright (c) 2015年 admin. All rights reserved.


#import "PaihangUIView.h"
#import "MJRefresh.h"
#import "public.h"
#import "PaihangTableViewCell.h"
#import "AFNetworking.h"

@interface PaihangUIView ()<UITableViewDelegate, UITableViewDataSource>
{
    long totalRow;
    long nowPage;
    BOOL ifFull;
}
@property (nonatomic, strong) NSMutableArray *categoryButtonArray;
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *detailDataSource;
@end

@implementation PaihangUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    [self initView];
    [self getData];
    return self;
}

- (void)setup {
    self.tableDataSource = [[NSMutableArray array]init];
    self.detailDataSource = [[NSMutableArray array]init];
    self.categoryButtonArray = [[NSMutableArray array]init];
}
- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    //tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 0, screen_width-80, self.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //delete useless line
    self.tableView.tableFooterView = [[UIView alloc]init];
    //    //close the scroll
    //    self.scrollEnabled = NO;
    // setup pull-to-refresh
    
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableView)];
    [self addSubview:self.tableView];
    
    //筛选按钮
    NSArray *buttonTx = [[NSArray alloc]initWithObjects:@"综合排行",@"安全评价",@"性能操控",@"油耗水准",@"空间表现",@"舒适程度",@"人机交互", nil];
    
    for (int i=0; i<7; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*40, 80, 40)];
        [button.layer setBorderColor:[RGB_BACKGROUND_COLOR_GRAY CGColor]];
        [button.layer setBorderWidth:0.5f];
   
        [button setTitle:[buttonTx objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(OnSegBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.categoryButtonArray addObject:button];
        [self addSubview:button];
        //记载首个
        if (i==0) {
            [button setTitleColor:RGB_BACKGROUND_COLOR_RED forState:UIControlStateNormal];
        }
    }
    
}

- (void)getData {
    ifFull = NO;
    __weak PaihangUIView *weakSelf = self;
    totalRow=0;
    nowPage = 1;
    AFHTTPRequestOperationManager *httpsManager = [[AFHTTPRequestOperationManager alloc]init];
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"getCarNewsList" forKey:@"cmd"];
    [parameters setObject:@"2" forKey:@"Type"];
    [parameters setValue:@"10" forKey:@"Pagesize"];
    [parameters setValue:[NSNumber numberWithLong:nowPage] forKey:@"PageNum"];
    
    NSLog(@"parameters: %@",parameters);
    [httpsManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"paihang------%@",responseObject);
        if (responseObject) {
            [weakSelf.tableDataSource removeAllObjects];
            NSDictionary *revDic = (NSDictionary*)responseObject;
            totalRow = [[revDic objectForKey:@"recordCount"] intValue];
            if (totalRow > 0) {
                NSArray *revDataArray = [[NSArray alloc] initWithArray:[revDic objectForKey:@"dataList"]];
                int arraylen = (int)revDataArray.count;
                for(int i=0; i<arraylen; i++){
                    NSDictionary *cellDic = (NSDictionary*)[revDataArray objectAtIndex:i];
                    [self.tableDataSource addObject:cellDic];
                }
                if ((nowPage-1)*10 + arraylen <totalRow) {
                    nowPage++;
                }else {
                    ifFull = YES;
                    [self.tableView.footer noticeNoMoreData];
                }
            }else {
                ifFull = YES;
                [self.tableView.footer noticeNoMoreData];
            }
            [weakSelf.tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
}

-(void)getMoreData {
    __weak PaihangUIView *weakSelf = self;
    AFHTTPRequestOperationManager *httpsManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"getCarNewsList" forKey:@"cmd"];
    [parameters setObject:@"1" forKey:@"Type"];
    [parameters setValue:@"10" forKey:@"Pagesize"];
    [parameters setValue:[NSNumber numberWithLong:nowPage] forKey:@"PageNum"];
    
    NSLog(@"parameters: %@",parameters);
    [httpsManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"paihang:::%@",responseObject);
        if (responseObject) {
            NSDictionary *revDic = (NSDictionary*)responseObject;
            totalRow = [[revDic objectForKey:@"recordCount"] intValue];
            if (totalRow > 0) {
                NSArray *revDataArray = [[NSArray alloc] initWithArray:[revDic objectForKey:@"dataList"]];
                int arraylen = (int)revDataArray.count;
                for(int i=0; i<arraylen; i++){
                    NSDictionary *cellDic = (NSDictionary*)[revDataArray objectAtIndex:i];
                    [self.tableDataSource addObject:cellDic];
                }
                if ((nowPage-1)*10 + arraylen <totalRow) {
                    nowPage++;
                }else {
                    ifFull =YES;
                    [self.tableView.footer noticeNoMoreData];
                }
            }else {
                ifFull = YES;
                [self.tableView.footer noticeNoMoreData];
            }
            
            [weakSelf.tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
}
- (void) refreshTableView {
    [self getData];
}

- (void) loadMoreTableView {
    if (ifFull){
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView.footer noticeNoMoreData];
    }else {
        [self getMoreData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"paihangCell";
    PaihangTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [[PaihangTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    //cell.userNameLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"title"];
    //cell.detailLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"appraise"];
    //cell.timeLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"appraise"];
   
    long num = indexPath.row +1;
    cell.userNum.text = [[NSString alloc]initWithFormat:@"%ldl",num];
    cell.userNameLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"title"];
  //  cell.detailLabel.text = @"3.6分";
  //  cell.bar.rating = 4;
    return cell;

}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    ClientTableViewController *clientsVC =[[ClientTableViewController alloc] init];
    //      //    UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:clientsVC];
    //    //    [[self viewController] presentViewController:naviViewController animated:YES completion:nil];
    //    [[self viewController].navigationController pushViewController:clientsVC animated:YES];
}

//get current VC
-(UIViewController*)viewController {
    for (UIView *next=[self superview]; next; next= next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


#pragma mark - 响应筛选按钮事件
-(void)OnSegBtn:(UIButton *)sender{
    NSLog(@"click button tag %ld",sender.tag);
    NSInteger tag = sender.tag;
    for (int i = 0; i < self.categoryButtonArray.count; i++) {
        UIButton *tempButton =  (UIButton *)[self.categoryButtonArray objectAtIndex:i];
        [tempButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:RGB_BACKGROUND_COLOR_RED forState:UIControlStateNormal];
   // [sender setBackgroundColor:[UIColor whiteColor]];
    switch (tag) {
        case 0:
            //
            break;
            
        default:
            break;
    }}

@end
