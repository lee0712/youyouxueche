//
//  BAScoresRankingViewController.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BAScoresRankingViewController.h"
#import "BAUtilities.h"
#import "BASorceRankView.h"

@interface BAScoresRankingViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UISegmentedControl *segmentedControl2;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) BASorceRankView *sorceRankView;

//滚动的下划线
@property (nonatomic,strong)UIView *lineView;


@end

@implementation BAScoresRankingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建子视图
    CGRect frame = CGRectMake(0, 44, KSCREEN_WIDTH, KSCREEN_HEIGHT - 44);
    _subView = [[UIView alloc] initWithFrame:frame];
    [self.view addSubview:_subView];
    
    // 设置分段控制器
    [self setUpSegmentedControl];
    [self setUpSegmentedControl2];
    
//    isActivityView = YES;
    [self enterSorceRankView];
}

#pragma mark - 设置分段控制器
- (void)setUpSegmentedControl
{
    _segmentedControl = [[UISegmentedControl alloc ]initWithItems:@[@"广 州",@"全 国"]];
    _segmentedControl.frame = CGRectMake((KSCREEN_WIDTH - 200)/2, 20, 200, 30);
    self.navigationItem.titleView = _segmentedControl;
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor whiteColor];
    
    //设置在点击后是否恢复原样
    _segmentedControl.momentary = NO;
    
    // 设置选中后的字体颜色
    NSDictionary *textAttibutesUnSelected = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    
    NSDictionary *textAttibutesSelected = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName,COLOR_C(78, 183, 249, 1.0),NSForegroundColorAttributeName,nil];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:textAttibutesUnSelected
                                                   forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:textAttibutesSelected
                                                   forState:UIControlStateSelected];
    
    // 点击事件
    [_segmentedControl addTarget:self action:@selector(controllerPressed:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark 设置分段控制器2
- (void)setUpSegmentedControl2
{
    // 添加下划线
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+44, KSCREEN_WIDTH/4, 3)];
    self.lineView.backgroundColor = COLOR_C(78, 183, 249, 1.0);
    [self.view addSubview:_lineView];
    
    self.segmentedControl2 = [[UISegmentedControl alloc ]initWithItems:@[@"今 日",@"本 周",@"本 月",@"总 榜"]];
    self.segmentedControl2.frame = CGRectMake(0, 64, KSCREEN_WIDTH, 44);
    [self.view addSubview:self.segmentedControl2];
    //设置控件的颜色
    self.segmentedControl2.tintColor = COLOR_C(239, 239, 239, 1.0);
    //默认选中的索引
    self.segmentedControl2.selectedSegmentIndex = 0;
    // 字体颜色
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"AppleGothic"size:14],NSFontAttributeName ,nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:COLOR_C(78, 183, 249, 1.0),NSForegroundColorAttributeName,[UIFont fontWithName:@"AppleGothic"size:14],NSFontAttributeName ,nil];
    
    [self.segmentedControl2 setTitleTextAttributes:dict1 forState:UIControlStateNormal];
    [self.segmentedControl2 setTitleTextAttributes:dict2 forState:UIControlStateSelected];
    
    //设置在点击后是否恢复原样
    _segmentedControl2.momentary = NO;
    
    // 点击事件
    [_segmentedControl2 addTarget:self action:@selector(controllerPressed2:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - 点击事件
#pragma mark 导航栏 分段控制器点击事件
- (IBAction)controllerPressed:(UISegmentedControl *)sender
{
//    self.lineView.hidden = YES;
    
    switch ([sender selectedSegmentIndex])
    {
        case 0:
        {
//            _segmentedControl2.hidden = NO;
            _subView.frame =  CGRectMake(0, 44, KSCREEN_WIDTH, KSCREEN_HEIGHT);
            [self sorceRankView];
        }
            break;
        case 1:
        {
//            _segmentedControl2.hidden = YES;
            _subView.frame =  CGRectMake(0, 44, KSCREEN_WIDTH, KSCREEN_HEIGHT);
            [self sorceRankView];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"Segment %ld selected\n", (long)sender.selectedSegmentIndex);
}

- (IBAction)controllerPressed2:(UISegmentedControl *)sender
{
    self.lineView.hidden = NO;
    
    switch ([sender selectedSegmentIndex])
    {
        case 0:
        {
            CGRect lineFrame = self.lineView.frame;
            lineFrame.origin.x = 0;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.lineView.frame = lineFrame;
            }];
            
            [self sorceRankView];
        }
            break;
        case 1:
        {
            CGRect frame = self.lineView.frame;
            frame.origin.x = KSCREEN_WIDTH/4;
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.lineView.frame = frame;
            }];
            [self sorceRankView];
        }
            break;
        case 2:
        {
            CGRect frame = self.lineView.frame;
            frame.origin.x = KSCREEN_WIDTH/4 *2;
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.lineView.frame = frame;
            }];
            [self sorceRankView];
        }
            break;
        case 3:
        {
            CGRect frame = self.lineView.frame;
            frame.origin.x = KSCREEN_WIDTH/4 *3;
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.lineView.frame = frame;
            }];
            [self sorceRankView];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"Segment %ld selected\n", (long)sender.selectedSegmentIndex);
}

// 排名
- (void)enterSorceRankView
{
//    isActivityView = YES;
    self.sorceRankView = [[BASorceRankView alloc] initWithSize:self.subView.frame.size at:self.subView];
//    self.sorceRankView.activityListArray = showMyOrderListArray;
 
    [self.sorceRankView selected:^(NSIndexPath *indexPath, UITableView *tableView, UITableViewCell *cell){
        
    }];
    [self.currentView removeFromSuperview];
    self.currentView = self.sorceRankView;
}


@end
