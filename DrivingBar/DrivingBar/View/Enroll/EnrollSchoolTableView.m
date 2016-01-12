//
// 驾校选择界面
//

#import "EnrollSchoolTableView.h"
#import "MJRefresh.h"
#import "public.h"
#import "EnrollTableViewCell.h"
#import "AFNetworking.h"
#import "CHDDropDownMenu.h"
#import "JiaxiaoDetailTableViewController.h"

@interface EnrollSchoolTableView ()<UITableViewDelegate, UITableViewDataSource>
{
    long totalRow;
    long nowPage;
    NSMutableArray *selectSectionArray;
    BOOL ifFull;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *detailDataSource;
@end

@implementation EnrollSchoolTableView

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
    
    selectSectionArray = [[NSMutableArray alloc] init];
    NSMutableArray *cityArray = [[NSMutableArray alloc]initWithObjects:@"全广州",
                                 @"白云区",
                                 @"番禺区",
                                 @"海珠区",
                                 @"花都区",
                                 @"黄埔区",
                                 @"荔湾区",
                                 @"南沙区",
                                 @"越秀区",
                                 @"天河区",
                                 @"萝岗区",
                                 @"南沙区",
                                 @"从化市",
                                 @"增城市",
                                 nil];
    NSMutableArray *sortArray = [[NSMutableArray alloc]initWithObjects:@"综合排序",@"好评度",@"距离", nil];
    [selectSectionArray addObject:cityArray];
    [selectSectionArray addObject:sortArray];
}
-(void)setHeadView{
    
    //筛选
    UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    
    filterView.backgroundColor = [UIColor whiteColor];
       //
    //列表展示的模型
    NSMutableArray *arr = [NSMutableArray array];
    for (int i =0 ; i<selectSectionArray.count; i++) {
        NSMutableArray *temp = [NSMutableArray array];
        NSMutableArray *tempSelect = [selectSectionArray objectAtIndex:i];
        for (int j=0; j<tempSelect.count; j++) {
            chdModel *model = [[chdModel alloc] init];
            model.text = [tempSelect objectAtIndex:j];
            [temp addObject:model];
            
        }
        [arr addObject:temp];
    }
    
    //上边按钮展示的模型,此模型对text赋值即可.
    NSMutableArray *ShowArr = [arr copy];
  
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, screen_width, 0.5)];
    lineView.backgroundColor = RGB(192, 192, 192);
    [filterView addSubview:lineView];
    self.tableHeaderView = filterView;
    
    //若列表展示内容与按钮展示内容相同则showArr传nil即可。
    [[CHDDropDownMenu alloc] initWithFrame:CGRectMake(0, 0,screen_width, 40) showOnView:self AllDataArr:arr showArr:ShowArr clickAction:^(long section, long row) {
        NSLog(@"enroll click:%ld--%ld",section,row);
    }];
    
}
- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    
    // [self addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    [self addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableView)];
     [self setHeadView];
    //delete useless line
    self.tableFooterView = [[UIView alloc]init];
    //    //close the scroll
    //    self.scrollEnabled = NO;
    
    // setup pull-to-refresh
    
}

- (void)getData {
    
    [self.tableDataSource addObject:@"111"];
    [self.tableDataSource addObject:@"222"];
    [self.tableDataSource addObject:@"333"];
    [self reloadData];
        ifFull = NO;
        __weak EnrollSchoolTableView *weakSelf = self;
        totalRow=0;
        nowPage = 1;
        AFHTTPRequestOperationManager *httpsManager = [[AFHTTPRequestOperationManager alloc]init];
        NSString *url = HTTP_POST_URL_NSSTRING;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:@"GetHallCompanyListByCity" forKey:@"cmd"];
        [parameters setObject:g_sessionId forKey:@"sessionId"];
        [parameters setObject:@"1" forKey:@"Type"];
        [parameters setValue:@"10" forKey:@"Pagesize"];
        [parameters setValue:[NSNumber numberWithLong:nowPage] forKey:@"PageNum"];
        [parameters setValue:@"020" forKey:@"City_ID"];
        NSLog(@"parameters: %@",parameters);
        [httpsManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if (responseObject) {
                [weakSelf.tableDataSource removeAllObjects];
                NSDictionary *revDic = (NSDictionary*)responseObject;
//                totalRow = [[revDic objectForKey:@"totalRows"] intValue];
//                if (totalRow > 0) {
//                    NSArray *revDataArray = [[NSArray alloc] initWithArray:[revDic objectForKey:@"data"]];
//                    int arraylen = (int)revDataArray.count;
//                    for(int i=0; i<arraylen; i++){
//                        NSDictionary *cellDic = (NSDictionary*)[revDataArray objectAtIndex:i];
//                        [self.tableDataSource addObject:cellDic];
//                    }
//                    if ((nowPage-1)*10 + arraylen <totalRow) {
//                        nowPage++;
//                    }else {
//                        ifFull = YES;
//                        [self.footer noticeNoMoreData];
//                    }
//                }else {
//                    ifFull = YES;
//                    [self.footer noticeNoMoreData];
//                }
//                [weakSelf reloadData];
//                [self.header endRefreshing];
//                [self.footer endRefreshing];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"https post fail, error: %@",error);
        }];
    [self.header endRefreshing];
    [self.footer endRefreshing];
}

-(void)getMoreData {
    //    __weak DaogouUITableView *weakSelf = self;
    //    AFHTTPRequestOperationManager *httpsManager = [[AFHTTPRequestOperationManager alloc]init];
    //
    //    NSString *url = HTTP_POST_URL_NSSTRING;
    //    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //    [parameters setObject:[NSNumber numberWithLong:nowPage] forKey:@"currentPage"];
    //    [parameters setObject:@10 forKey:@"currentPageSize"];
    //    [parameters setValue:@"all" forKey:@"filters[isGuest]"];
    //    [parameters setValue:mApMac forKey:@"filters[apMac]"];
    //
    //    NSLog(@"parameters: %@",parameters);
    //    [httpsManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"%@",responseObject);
    //        if (responseObject) {
    //            NSDictionary *revDic = (NSDictionary*)responseObject;
    //            totalRow = [[revDic objectForKey:@"totalRows"] intValue];
    //            if (totalRow > 0) {
    //                NSArray *revDataArray = [[NSArray alloc] initWithArray:[revDic objectForKey:@"data"]];
    //                int arraylen = (int)revDataArray.count;
    //                for(int i=0; i<arraylen; i++){
    //                    NSDictionary *cellDic = (NSDictionary*)[revDataArray objectAtIndex:i];
    //                    [self.tableDataSource addObject:cellDic];
    //                }
    //                if ((nowPage-1)*10 + arraylen <totalRow) {
    //                    nowPage++;
    //                }else {
    //                    ifFull =YES;
    //                    [self.footer noticeNoMoreData];
    //                }
    //            }else {
    //                ifFull = YES;
    //                [self.footer noticeNoMoreData];
    //            }
    //
    //            [weakSelf reloadData];
    //            [self.header endRefreshing];
    //            [self.footer endRefreshing];
    //        }
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"https post fail, error: %@",error);
    //    }];
    [self.header endRefreshing];
    [self.footer endRefreshing];
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
   // return self.tableDataSource.count;
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"enrollschoolcell";
    EnrollTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [[EnrollTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.userImageView.image = [UIImage imageNamed:@"img_jiaxiao.png"];
//    cell.userNameLabel.text = [self.tableDataSource objectAtIndex:indexPath.row];
//    cell.detailLabel.text = [self.tableDataSource objectAtIndex:indexPath.row];
//    cell.locationLabel.text = [self.tableDataSource objectAtIndex:indexPath.row];
    cell.userNameImageView.image = [UIImage imageNamed:@"enroll_jiaxiao"];
    cell.userNameLabel.text = @"黄埔驾校";
    cell.detailLabel.text = @"15名认证教练";
    cell.locationLabel.text = @"广州黄埔";
    [cell.bar setRating:5];
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    JiaxiaoDetailTableViewController *nextVC =[[JiaxiaoDetailTableViewController alloc] init];
      //    UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:clientsVC];
    //    [[self viewController] presentViewController:naviViewController animated:YES completion:nil];
    [[self viewController].navigationController pushViewController:nextVC animated:YES];
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
