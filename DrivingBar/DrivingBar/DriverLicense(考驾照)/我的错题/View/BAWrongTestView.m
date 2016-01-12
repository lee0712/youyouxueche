//
//  BAWrongTestView.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BAWrongTestView.h"
#import "BAUtilities.h"
#import "BAWrongTestViewCell.h"
#import "BAPageViewController.h"

@interface BAWrongTestView ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    UISwitch *removeSwitch;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGSize size;
@property (copy, nonatomic) selected selected;

// 数据
@property (nonatomic, strong) NSArray *wrongTestViewDataArray;

@end

@implementation BAWrongTestView

- (NSArray *)wrongTestViewDataArray
{
    if (!_wrongTestViewDataArray)
    {
        if ([self.vcName isEqualToString:@"BAWrongTestViewController"])
        {
            _wrongTestViewDataArray = @[@"全部错题", @"道路交通信号", @"道路交通信号", @"道路交通信号", @"道路交通信号"];
        }
        if ([self.vcName isEqualToString:@"BAMyCollectionViewController"])
        {
            _wrongTestViewDataArray = @[@"全部收藏", @"道路交通信号", @"道路交通信号", @"道路交通信号", @"道路交通信号"];
        }
    }
    return _wrongTestViewDataArray;
}

- (instancetype)initWithSize:(CGSize)size at:(id)view
{
    if (self = [super init])
    {
        self.size = size;
        
        if ([view isKindOfClass:[UIView class]])
        {
            view = (UIView *)view;
        }
        else if ([view isKindOfClass:[UIWindow class]])
        {
            view = (UIWindow *)view;
        }
        else
        {
            view = nil;
            return nil;
        }
        
        /* width */
        if (size.width < 60.0f)
        {
            size.width = 60.0f;
        }
        else if (size.width > KSCREEN_WIDTH)
        {
            size.width = KSCREEN_WIDTH;
        }
        
        /* height */
        if (size.height < 10.0f)
        {
            size.height = 10.0f;
        }
        else if (size.height > KSCREEN_HEIGHT)
        {
            size.height = KSCREEN_HEIGHT;
        }
        
        CGRect frame = CGRectZero;
        frame.size = size;
        self.frame = frame;
        [view addSubview:self];
        
        self.tableView = [[UITableView alloc] initWithFrame:frame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView.backgroundColor = COLOR_C(233, 233, 233, 1.0);
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - tableView 的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.vcName isEqualToString:@"BAWrongTestViewController"])
    {
        return 2;
    }
    if ([self.vcName isEqualToString:@"BAMyCollectionViewController"])
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.wrongTestViewDataArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIden = @"cell";
    
    BAWrongTestViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIden];
    if (!cell)
    {
        cell =[[BAWrongTestViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIden];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.numberLabel.hidden = YES;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
        cell.contentLabel.text = [self.wrongTestViewDataArray objectAtIndex:indexPath.row];
        cell.contentNumberLabel.text = @"15题";
    }
    if (indexPath.section == 1)
    {
        cell.numberLabel.hidden = YES;
        cell.contentNumberLabel.hidden = YES;
        cell.contentLabel.text = @"答对后自动移除错题";
        
        removeSwitch = [[UISwitch alloc] init];
        removeSwitch.frame = CGRectMake(KSCREEN_WIDTH - 80, 11, 100, 28);
        removeSwitch.on = NO;
        [removeSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        [cell.contentView addSubview:removeSwitch];
    }

    return cell;
}

#pragma mark - tableView 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    MyEquipmentDetailViewController *detailVC = [[MyEquipmentDetailViewController alloc] init];
    //    detailVC.listArray = listDefineArray;
    //    //    NSLog(@"=== %@", detailVC.listArray);
    //    detailVC.row = indexPath.row;
    //    [[self viewController].navigationController pushViewController:detailVC animated:YES];
    if (indexPath.section == 0)
    {
        if ([self.vcName isEqualToString:@"BAWrongTestViewController"])
        {
            BAPageViewController *pageVC = [[BAPageViewController alloc] init];
            pageVC.testVCName = @"BAWrongTestViewController";
            [[self viewController].navigationController pushViewController:pageVC animated:YES];
        }
        if ([self.vcName isEqualToString:@"BAMyCollectionViewController"])
        {
            BAPageViewController *pageVC = [[BAPageViewController alloc] init];
            pageVC.testVCName = @"BAMyCollectionViewController";
            [[self viewController].navigationController pushViewController:pageVC animated:YES];
        }
    }
 
}

#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark 分区头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)selected:(selected)seled
{
    self.selected = seled;
}

#pragma mark - 按钮点击事件
- (IBAction)switchAction:(id)sender
{
    if (removeSwitch.on)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您当前点击的是移除错题按钮"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

#pragma mark - 调用view的C
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
