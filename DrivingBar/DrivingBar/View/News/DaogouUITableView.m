//
//  APDetailTableView.m
//  EAPController
//
//  Created by admin on 15/9/11.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DaogouUITableView.h"
#import "MJRefresh.h"
#import "public.h"
#import "UIImageView+WebCache.h"
#import "DaogouTableViewCell.h"
#import "AFNetworking.h"

@interface DaogouUITableView ()<UITableViewDelegate, UITableViewDataSource>
{
    long totalRow;
    long nowPage;
    BOOL ifFull;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *detailDataSource;
@end

@implementation DaogouUITableView

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
}
- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    //delete useless line
    self.tableFooterView = [[UIView alloc]init];
    //    //close the scroll
    //    self.scrollEnabled = NO;
    
    // setup pull-to-refresh
    
    [self addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    [self addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableView)];
}

- (void)getData {
    [self reloadData];
    ifFull = NO;
    __weak DaogouUITableView *weakSelf = self;
    totalRow=0;
    nowPage = 1;
    AFHTTPRequestOperationManager *httpsManager = [[AFHTTPRequestOperationManager alloc]init];
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"getCarNewsList" forKey:@"cmd"];
    [parameters setObject:@"0" forKey:@"Type"];
    [parameters setValue:@"10" forKey:@"Pagesize"];
    [parameters setValue:[NSNumber numberWithLong:nowPage] forKey:@"PageNum"];

    NSLog(@"parameters: %@",parameters);
    [httpsManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
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
                    [self.footer noticeNoMoreData];
                }
            }else {
                ifFull = YES;
                [self.footer noticeNoMoreData];
            }
            [weakSelf reloadData];
            [self.header endRefreshing];
            [self.footer endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
}

-(void)getMoreData {
    __weak DaogouUITableView *weakSelf = self;
    AFHTTPRequestOperationManager *httpsManager = [[AFHTTPRequestOperationManager alloc]init];

    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"getCarNewsList" forKey:@"cmd"];
    [parameters setObject:@"0" forKey:@"Type"];
    [parameters setValue:@"10" forKey:@"Pagesize"];
    [parameters setValue:[NSNumber numberWithLong:nowPage] forKey:@"PageNum"];

    NSLog(@"parameters: %@",parameters);
    [httpsManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
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
                    [self.footer noticeNoMoreData];
                }
            }else {
                ifFull = YES;
                [self.footer noticeNoMoreData];
            }
            
            [weakSelf reloadData];
            [self.header endRefreshing];
            [self.footer endRefreshing];
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
        [self.header endRefreshing];
        [self.footer endRefreshing];
        [self.footer noticeNoMoreData];
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
    static NSString *identifier = @"daogouCell";
    DaogouTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [[DaogouTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    NSString *tmpUrl = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"picture"];
    NSString *nsUrl = [[NSString alloc]initWithFormat:@"%@%@",HTTP_IMG_URL_NSSTRING,tmpUrl];
    NSURL *imUrl = [[NSURL alloc]initWithString:nsUrl];
    [cell.userImageView sd_setImageWithURL:imUrl];
    //显示图片
    cell.userNameLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"title"];
    //cell.detailLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"appraise"];
    //cell.timeLabel.text = [[self.tableDataSource objectAtIndex:indexPath.row]objectForKey:@"appraise"];
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

@end
