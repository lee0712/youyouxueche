//
//  TabBarViewController.m
//  Lightoak
//
//  Created by Администратор on 4/6/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "TabBarViewController.h"
#import "SWRevealViewController.h"
#import "LogTableViewController.h"
#import "AFNetworking.h"
#import "public.h"
#import "UIColor+HEX.h"
#import "EAPToast.h"

@interface TabBarViewController ()
{
    long selectedSite;
    NSMutableArray *sitesData;
    NSMutableArray *sitesCode;
    NSTimer *stateTimer;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButton;
@property (weak, nonatomic) IBOutlet UIButton *siteButton;

@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginOut) name:@"loginOut" object:nil];
    //初始化
    [self customSetup];
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar.png"]];
//    [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
//    
    //item选项
    UITabBarItem *item0 = [[self.viewControllers objectAtIndex:0] tabBarItem];
    UITabBarItem *item1 = [[self.viewControllers objectAtIndex:1] tabBarItem];
    UITabBarItem *item2 = [[self.viewControllers objectAtIndex:2] tabBarItem];
    UITabBarItem *item3 = [[self.viewControllers objectAtIndex:3] tabBarItem];
    
    //名称和图片
    item0.title = NSLocalizedString(@"考驾照", nil);
    item1.title = NSLocalizedString(@"报名学车", nil);
    item2.title = NSLocalizedString(@"驾校圈", nil);
    item3.title = NSLocalizedString(@"汽车资讯", nil);
    
    item0.selectedImage = [[UIImage imageNamed:@"tab_kaojiazhao_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.image = [[UIImage imageNamed:@"tab_kaojiazhao_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"tab_baoming_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"tab_baoming_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     //   item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item2.selectedImage = [[UIImage imageNamed:@"tab_shequ_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"tab_shequ_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     //   item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item3.selectedImage = [[UIImage imageNamed:@"tab_zixun_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"tab_zixun_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)getSitesData {

}

- (void)customSetup
{
    // init data
    sitesData = [[NSMutableArray alloc] init];
    sitesCode = [[NSMutableArray alloc] init];
  
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor clearColor];
    //侧滑菜单
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButton setTarget: self.revealViewController];
        [self.revealButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
    //左侧菜单按钮
    UIBarButtonItem *revealButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

- (void)refreshData {
    //refresh data and view
    [self.selectedViewController viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //close the timer
    [stateTimer invalidate];
    stateTimer = nil;
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate
{
    return YES;
}
- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)loginOut {
    NSLog(@"main login out");
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
