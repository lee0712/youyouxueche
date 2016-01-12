//
//  APsViewController.m
//  EAPController
//
//  Created by admin on 15/9/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NewsViewController.h"
#import "public.h"
#import "MJRefresh.h"
#import "UIColor+HEX.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "PPiFlatSegmentedControl.h"
#import "DaogouUITableView.h"
#import "PingceUITableView.h"
#import "PaihangUIView.h"
#import "HangqingUITableView.h"

#define AP_STATE_CONNECTED 1
#define AP_STATE_DISCONNECTED 2
#define AP_STATE_PENDING 3

@interface NewsViewController()
{
    long totalRow;
    long nowPage;
    
    MBProgressHUD * MBProgress;
    BOOL ifloadFull;
    unsigned long apState;
    UIButton *connectedBt;
    UIButton *disconnectedBt;
    UIButton *pendingBt;
    UIButton *moreBt;
    UIView *daogouView;
    UIView *pingceView;
    UIView *paihangView;
    UIView *hangqingView;
    
}

@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *moreMenuDataSource;

@end

@implementation NewsViewController
@synthesize tableView = tableView;

- (void)loadView {
    [super loadView];
    [self initView];
    apState = AP_STATE_CONNECTED;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)viewWillAppear:(BOOL)animated{
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
- (void)initView {
    
    
    UIView *segmentBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, NAVI_AND_STATUS_HEIGHT)];
    segmentBackView.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    [self.view addSubview:segmentBackView];
    
    daogouView = [[DaogouUITableView alloc]initWithFrame:CGRectMake(0, segmentBackView.frame.origin.y+segmentBackView.frame.size.height, screen_width, screen_height-segmentBackView.frame.origin.y-segmentBackView.frame.size.height)];
    pingceView = [[PingceUITableView alloc]initWithFrame:CGRectMake(0, segmentBackView.frame.origin.y+segmentBackView.frame.size.height, screen_width, screen_height-segmentBackView.frame.origin.y-segmentBackView.frame.size.height)];
    paihangView = [[PaihangUIView alloc]initWithFrame:CGRectMake(0, segmentBackView.frame.origin.y+segmentBackView.frame.size.height, screen_width, screen_height-segmentBackView.frame.origin.y-segmentBackView.frame.size.height)];
    hangqingView = [[HangqingUITableView alloc]initWithFrame:CGRectMake(0, segmentBackView.frame.origin.y+segmentBackView.frame.size.height, screen_width, screen_height-segmentBackView.frame.origin.y-segmentBackView.frame.size.height)];
    
    
    //资讯分栏
    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc]
                                        initWithFrame:CGRectMake(screen_width/16, 0+24, screen_width*7/8, 32)
                                        items:
                                        @[@{@"text":NSLocalizedString(@"汽车导购", nil)},
                                          @{@"text":NSLocalizedString(@"汽车评测", nil)},
                                          @{@"text":NSLocalizedString(@"汽车排行", nil)},
                                          @{@"text":NSLocalizedString(@"汽车行情", nil)}
                                          ]
                                        iconPosition:IconPositionRight
                                        andSelectionBlock:^(NSUInteger segmentIndex) {
                                            //切换view，先全部删除
                                            if (daogouView.superview) {
                                                [daogouView removeFromSuperview];
                                            }
                                            if (pingceView.superview) {
                                                [pingceView removeFromSuperview];
                                            }
                                            if (paihangView.superview) {
                                                [paihangView removeFromSuperview];
                                            }
                                            if (hangqingView.superview) {
                                                [hangqingView removeFromSuperview];
                                            }
                                            switch (segmentIndex) {
                                                case 0:
                                                    if (!daogouView.superview) {
                                                        [self.view addSubview:daogouView];
                                                    }
                                                    break;
                                                case 1:
                                                    if (!pingceView.superview) {
                                                        [self.view addSubview:pingceView];
                                                    }
                                                    break;
                                                case 2:
                                                    if (!paihangView.superview) {
                                                        [self.view addSubview:paihangView];
                                                    }
                                                    break;
                                                case 3:
                                                    if (!hangqingView.superview) {
                                                        [self.view addSubview:hangqingView];
                                                    }
                                                    break;
                                                    
                                                default:
                                                    break;
                                            }
                                        }];
    
    segmented.color=[UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    segmented.borderColor=[UIColor whiteColor];
    segmented.borderWidth = 1.0f;
    segmented.selectedColor=[UIColor whiteColor];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                       NSForegroundColorAttributeName:[UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f]};
    //首次加载第一个view
    if (!daogouView.superview) {
        [self.view addSubview:daogouView];
    }
    [self.view addSubview:segmented];
 
}

- (void)viewDidAppear:(BOOL)animated {
    
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"汽车资讯", nil);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.view.backgroundColor = [UIColor clearColor];
    //  self.navigationItem.titleView = titleLabel;
    self.tabBarController.navigationItem.titleView = titleLabel;
    //[self.tableView triggerPullToRefresh];
}

@end

