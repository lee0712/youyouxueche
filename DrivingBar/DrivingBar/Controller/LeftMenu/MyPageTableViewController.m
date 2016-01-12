//
//  MyPageTableViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "MyPageTableViewController.h"

@interface MyPageTableViewController (){
    NSString *nickName;
    NSString *sex;
    NSString *region;
    NSString *teacher;

    
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;

@end

@implementation MyPageTableViewController

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
    self.tableDataSource = [[NSMutableArray alloc]init];
    [self.tableDataSource addObject:@"头像"];
    [self.tableDataSource addObject:@"昵称"];
    [self.tableDataSource addObject:@"性别"];
    [self.tableDataSource addObject:@"地区"];
    [self.tableDataSource addObject:@"教练"];
    [self.tableDataSource addObject:@"签名"];

    
    self.tableView.scrollEnabled = NO;
    [self getData];
    [self.tableView reloadData];
}

-(void)getData{
    nickName = @"zhangsan";
    sex = @"男";
    region = @"shanghai";
    teacher = @"lisi";
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
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

- (void)setHeadView {
//no headview
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *title = [self.tableDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    switch (indexPath.row) {
        case 0:{
            cell.detailTextLabel.text = nickName;
            break;
        }
        case 1:{
            cell.detailTextLabel.text = nickName;
            break;
        }
        case 2:{
            cell.detailTextLabel.text = sex;
            break;
        }
        case 3:{
            cell.detailTextLabel.text = region;
            break;
        }
        case 4:{
            cell.detailTextLabel.text = teacher;
            break;
        }
        default:
            break;
    }
    
//    cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:indexPath.row]];

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
