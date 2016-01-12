//
//  TopApsTableViewController.m
//  EAPController
//
//  Created by admin on 15/9/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LogTableViewController.h"
#import "public.h"
#import "UIColor+HEX.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "EAPToast.h"
#import "MBProgressHUD.h"
#import "UIColor+HEX.h"

@interface LogTableViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
{
    long totalRow;
    long nowPage;

    UIButton *headBt;
    BOOL ifArchieved;
    NSString *rightTitle;
    MBProgressHUD * MBProgress;
    BOOL ifloadFull;
    
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *detailTableDataSource;
@property (nonatomic, strong) NSMutableArray *tableDataSourceId;
@end

@implementation LogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initView];
    [self initData];
    [self getUnArchivedData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)initData {
    self.tableDataSource = [NSMutableArray array];
    self.detailTableDataSource = [NSMutableArray array];
    self.tableDataSourceId = [NSMutableArray array];
}
-(void)initView {
    ifArchieved = NO;
    ifloadFull = NO;
    rightTitle = NSLocalizedString(@"Delete", nil);
    //set navigationbar title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Alert";
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
   // self.navigationController.title = @"Log";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, self.navigationController.navigationBar.frame.size.height/3, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
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
 
    self.tableView.tableFooterView = [[UIView alloc]init];

    // setup pull-to-refresh
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshListView)];
    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreListView)];
  
    //slove the tableview headview hide problem when refresh
   // self.navigationController.navigationBar.translucent = NO;
}

- (void)setHeadView {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 45)];
    //headView.backgroundColor = [UIColor whiteColor];
    UIView *headline = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height-1, headView.frame.size.width, 1)];
    headline.backgroundColor = [UIColor grayColor];
    
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"Unarchived",@"Archived", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(20, 10, 140, 30);
    segmentedControl.tintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];

    if (ifArchieved) {
        segmentedControl.selectedSegmentIndex = 1;
    }else {
        segmentedControl.selectedSegmentIndex = 0;
    }
    [segmentedControl addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
    //size of tx
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:12] forKey:NSFontAttributeName];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [headView addSubview:segmentedControl];
    
    headBt = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-100, 10, 90, 25)];
    [headBt setTitle:NSLocalizedString(@"Archive All",nil) forState:UIControlStateNormal];
    [headBt.layer setCornerRadius:6.0f];
    headBt.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    [headBt addTarget:self action:@selector(actionAll:) forControlEvents:UIControlEventTouchUpInside];
  
    [headView addSubview:headBt];
    
    [headView addSubview:headline];
    
    //   headView.backgroundColor = [UIColor orangeColor];
    
    self.tableView.tableHeaderView =headView;
//    self.tableView.frame = CGRectMake(0, headView.frame.size.height+NAVI_AND_STATUS_HEIGHT, screen_width, screen_height-NAVI_AND_STATUS_HEIGHT-headView.frame.size.height);
}

- (void)refreshListView {
    if (ifArchieved) {
        [self getArchivedData];
    }else {
        [self getUnArchivedData];
    }
}

- (void)loadMoreListView {
   // NSLog(@"load more");
    if (ifloadFull) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView.footer noticeNoMoreData];

    }else {
        if (ifArchieved) {
            [self getMoreArchivedData];
        }else {
            [self getMoreUnArchivedData];
        }
    }
}

- (void)actionAll: (id)sender{
   
    if (ifArchieved) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"make sure to delete all?", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
        [alert show];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"make sure to archieve all?", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
        [alert show];
    }
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    if (buttonIndex == 1) {
//        MBProgress = [[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:MBProgress];
//        MBProgress.removeFromSuperViewOnHide =YES;
//        [MBProgress show:YES];
     
    }
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
    static NSString *identifier = @"TopAPs";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    //    NSDate *date = [self.dataSource objectAtIndex:indexPath.row];
    //    cell.textLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    NSString *title = [self.tableDataSource objectAtIndex:indexPath.row];
    NSString *content = [self.detailTableDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = content;
    cell.imageView.image = [UIImage imageNamed:@"log_alert_im"];
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

-(void)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//switch archived
-(void)switched:(UISegmentedControl*)Seg {
    NSInteger index = Seg.selectedSegmentIndex;
    switch (index) {
        case 1:
            [self getArchivedData ];
            [headBt setTitle:NSLocalizedString(@"Delete All", nil) forState:UIControlStateNormal];
            ifArchieved = YES;
            rightTitle = NSLocalizedString(@"Delete", nil);
            break;
        case 0:
            NSLog(@"unarchived");
            [self getUnArchivedData];
            [headBt setTitle:NSLocalizedString(@"Archive All", nil) forState:UIControlStateNormal];
            ifArchieved = NO;
            rightTitle = NSLocalizedString(@"Archive", nil);
        default:
            break;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (ifArchieved){
        return NSLocalizedString(@"Delete", nil);
    }else {
        return NSLocalizedString(@"Archive", nil);
    }
}

-(void)getUnArchivedData {
   }

-(void)getArchivedData {
   }

-(void)getMoreUnArchivedData {
   }

-(void)getMoreArchivedData {
    }

@end
