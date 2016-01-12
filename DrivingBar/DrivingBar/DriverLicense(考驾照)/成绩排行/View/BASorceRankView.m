//
//  BASorceRankView.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BASorceRankView.h"
#import "BAUtilities.h"
#import "BASorceRankCell.h"

#import "BAButton.h"
#import "BACustomLable.h"

#import "BASimulationTestViewController.h"

@interface BASorceRankView ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGSize size;
@property (copy, nonatomic) selected selected;


@end

@implementation BASorceRankView


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
        if (size.height < 30.0f)
        {
            size.height = 30.0f;
        }
        else if (size.height > KSCREEN_HEIGHT)
        {
            size.height = KSCREEN_HEIGHT;
        }
        
        CGRect frame = CGRectZero;
        frame.size = size;
        self.frame = frame;
        [view addSubview:self];
        
//        CGRect sorceRankViewFrame = CGRectMake(0, 44, KSCREEN_WIDTH, KSCREEN_HEIGHT - 44);
        self.tableView = [[UITableView alloc] initWithFrame:frame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView.backgroundColor = COLOR_C(233, 233, 233, 1.0);
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - tableView 的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 5;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIden = @"rankCell";
    
    BASorceRankCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIden];
    if (!cell)
    {
        cell =[[BASorceRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIden];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
    {
        // 图像
        cell.userImageView.image = [UIImage circleImageWithName:@"tea" borderWidth:1.0 borderColor:[UIColor whiteColor]];
        
        // 文字
        CGRect testLabelFrame = CGRectMake(55, 7, KSCREEN_WIDTH - 100, 40);
        BACustomLable *testLabel = [[BACustomLable alloc] custonmLabelWithFrame:testLabelFrame text:@"您今天还没有模拟考试！" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
        
        // 去考试按钮
        CGRect testButtonFrame = CGRectMake(KSCREEN_WIDTH - 80, 10, 60, 30);
        BAButton *testButton = [[BAButton alloc] custonmButtonWithFrame:testButtonFrame title:@"去考试" state:UIControlStateNormal backgroundColor:[UIColor whiteColor]];
        testButton.titleLabel.font = FONT_SIZE;
        testButton.clipsToBounds = YES;
        testButton.layer.borderWidth = 1.0;
        testButton.layer.borderColor = COLOR_C(78, 183, 249, 1.0).CGColor;
        [testButton setTitleColor:COLOR_C(78, 183, 249, 1.0) forState:UIControlStateNormal];
        [testButton addTarget:self action:@selector(testButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.hView.hidden = YES;
        
        [cell.contentView addSubview:testLabel];
        [cell.contentView addSubview:testButton];
    }
    if (indexPath.section == 1)
    {
        cell.hView.hidden = YES;
        cell.userImageView.hidden = YES;
        cell.userNameLabel.hidden = YES;
        cell.sorceLabel.hidden = YES;
        cell.backgroundColor = COLOR_C(240, 240, 240, 1.0);
        
        // 文字
        CGRect testLabelFrame = CGRectMake(10, 7, KSCREEN_WIDTH - 100, 40);
        BACustomLable *testLabel = [[BACustomLable alloc] custonmLabelWithFrame:testLabelFrame text:@"今日广州排行榜" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
        
        // 时间
        CGRect testTimeLabelFrame = CGRectMake(KSCREEN_WIDTH - 160, 7, 140, 40);
        BACustomLable *testTimeLabel = [[BACustomLable alloc] custonmLabelWithFrame:testTimeLabelFrame text:[self getCurrentDateAndTime] textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight];
        testTimeLabel.textAlignment = NSTextAlignmentRight;
        
        [cell.contentView addSubview:testLabel];
        [cell.contentView addSubview:testTimeLabel];
    }
    if (indexPath.section == 2)
    {
        cell.userImageView.image = [UIImage circleImageWithName:@"tea" borderWidth:1.0 borderColor:[UIColor whiteColor]];
        cell.userNameLabel.text = @"博爱";
        cell.sorceLabel.text = [NSString stringWithFormat:@"%d分", 100];
        cell.sorceTimeLabel.text = [NSString stringWithFormat:@"%d分%d秒", 4, 18];
        cell.sorceRankLabel.text = [NSString stringWithFormat:@"第%ld名", (long)indexPath.row];
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
}


#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark 分区头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)selected:(selected)seled
{
    self.selected = seled;
}

#pragma mark - 按钮点击事件
- (IBAction)testButtonClick:(id)sender
{
    BASimulationTestViewController *pageVC = [[BASimulationTestViewController alloc] init];
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark - 获得系统当前日期和时间
- (NSString *)getCurrentDateAndTime
{
    //获得系统日期
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *morelocationString = [dateformatter stringFromDate:senddate];
    NSLog(@"当前日期为：%@", morelocationString);
    
    return morelocationString;
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
