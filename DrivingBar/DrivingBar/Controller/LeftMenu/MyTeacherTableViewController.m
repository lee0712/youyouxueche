//
//  MyPageTableViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "MyTeacherTableViewController.h"

@interface MyTeacherTableViewController (){
    
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *tableDataImname;
@end

@implementation MyTeacherTableViewController

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
    
    self.tableView.tableFooterView = [[UIView alloc]init];

    //self.tableView.scrollEnabled = NO;
    [self getData];
}

-(void)initNavi {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"个人主页", nil);
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
-(void)getData {
    self.tableDataSource = [[NSMutableArray alloc]init];
    self.tableDataImname = [[NSMutableArray alloc]init];
   
    
}

- (void)setHeadView {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 45)];
    //headView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView =headView;
    //    self.tableView.frame = CGRectMake(0, headView.frame.size.height+NAVI_AND_STATUS_HEIGHT, screen_width, screen_height-NAVI_AND_STATUS_HEIGHT-headView.frame.size.height);
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *title = [self.tableDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    //    cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:indexPath.row]];
    //
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


@end
