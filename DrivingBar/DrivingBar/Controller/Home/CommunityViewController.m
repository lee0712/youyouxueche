//
//  StaViewController.m
//  EAPController
//
//  Created by admin on 15/9/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityTableViewCell.h"
#import "public.h"
#import "PageView.h"
#import "ZYBannerView.h"
#import "UIColor+HEX.h"

@interface CommunityViewController ()<ZYBannerViewDataSource, ZYBannerViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *kaoyouValue;
    UILabel *huatiValue;
}

@property (nonatomic, strong) ZYBannerView *banner;
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-NAVI_AND_STATUS_HEIGHT-TAB_BAR_HEIGHT)];
       [self.view addSubview:self.tableView];

    self.tableView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //清除默认分割线
    self.tableView.separatorStyle = NO;
    //delete useless line
    [self setHeadView];
    
    self.tableView.tableFooterView = [[UIView alloc]init];

    [self.tableView reloadData];
    
}
-(void)initNavi {
   
}
- (void)viewWillAppear:(BOOL)animated{
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"优优社区", nil);
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
      [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    //  self.navigationItem.titleView = titleLabel;
    self.tabBarController.navigationItem.titleView = titleLabel;
    //  NSLog(@"view will appear");
    
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationController.navigationBar.barTintColor = RGB_BACKGROUND_COLOR_BLUE;
  
    self.navigationController.view.tintColor = [UIColor whiteColor];
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

-(void)setHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 410)];
    //图片
    UIImageView *pageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    pageView.image = [UIImage imageNamed:@"jiayouquan.png"];
//    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"jiayouquan.png",@"jiayouquan.png",@"jiayouquan.png",nil];
//    //网络图片
//    //    NSArray *imageArray = @[@"",@"",@"",@""];
//    PageView *pageView = [[PageView alloc] initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
//    //是否是网络图片
//    pageView.isWebImage = NO;
//    //存放图片数组
//    pageView.imageArray = imageArray;
//    //停留时间
//    pageView.duration = 1.0;
    
    [headView addSubview:pageView];
    
//    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, pageView.frame.size.height+pageView.frame.origin.y, screen_width, 10)];
//    
//    [self.view addSubview:lineView1];
    
    headView.backgroundColor = [UIColor whiteColor];
    //社区头部
    UIView *shequTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, pageView.frame.size.height+pageView.frame.origin.y+10, screen_width, 40)];
    shequTitleView.backgroundColor = [UIColor whiteColor];
    UILabel *shequTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 30)];
    shequTitleLabel.text = @"优优社区";
    [shequTitleView addSubview:shequTitleLabel];
    UILabel *kaoyouLabel = [[UILabel alloc]initWithFrame:CGRectMake(shequTitleLabel.frame.origin.x+shequTitleLabel.frame.size.width+40, shequTitleLabel.frame.origin.y, 30, shequTitleLabel.frame.size.height)];
    kaoyouLabel.text = @"考友";
    kaoyouLabel.font = [UIFont systemFontOfSize:12];
    kaoyouValue = [[UILabel alloc]initWithFrame:CGRectMake(kaoyouLabel.frame.origin.x+kaoyouLabel.frame.size.width, kaoyouLabel.frame.origin.y, 25, shequTitleLabel.frame.size.height)];
    kaoyouValue.textColor = RGB_BACKGROUND_COLOR_RED;
    kaoyouValue.text = @"230";
    kaoyouValue.font = [UIFont systemFontOfSize:12];
    UILabel *kaoyouLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(kaoyouValue.frame.origin.x+kaoyouValue.frame.size.width, kaoyouValue.frame.origin.y, 30, shequTitleLabel.frame.size.height)];
    kaoyouLabel2.text = @"万, ";
    kaoyouLabel2.font = [UIFont systemFontOfSize:12];
    UILabel *huatiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kaoyouLabel2.frame.origin.x+kaoyouLabel2.frame.size.width, kaoyouLabel2.frame.origin.y, 30, shequTitleLabel.frame.size.height)];
    huatiLabel.text = @"话题";
    huatiLabel.font = [UIFont systemFontOfSize:12];
    huatiValue = [[UILabel alloc]initWithFrame:CGRectMake(huatiLabel.frame.origin.x+huatiLabel.frame.size.width, huatiLabel.frame.origin.y, 20, shequTitleLabel.frame.size.height)];
    huatiValue.textColor = RGB_BACKGROUND_COLOR_RED;
    huatiValue.text = @"30";
    huatiValue.font = [UIFont systemFontOfSize:12];
    UILabel *huatiLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(huatiValue.frame.origin.x+huatiValue.frame.size.width, huatiValue.frame.origin.y, 30, shequTitleLabel.frame.size.height)];
    huatiLabel2.text = @"万";
    huatiLabel2.font = [UIFont systemFontOfSize:12];
    [shequTitleView addSubview:kaoyouLabel];
    [shequTitleView addSubview:kaoyouValue];
    [shequTitleView addSubview:kaoyouLabel2];
    [shequTitleView addSubview:huatiLabel];
    [shequTitleView addSubview:huatiLabel2];
    [shequTitleView addSubview:huatiValue];
    [headView addSubview:shequTitleView];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(30, shequTitleView.frame.origin.y+shequTitleView.frame.size.height,screen_width-30, 1.0)];
    lineView2.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [headView addSubview:lineView2];
    // 初始化
    self.banner = [[ZYBannerView alloc] init];
    self.banner.backgroundColor=[UIColor whiteColor];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    [headView addSubview:self.banner];
    
    // 设置frame
    self.banner.frame = CGRectMake(0,
                                   lineView2.frame.origin.y+lineView2.frame.size.height,
                                   screen_width,
                                   110);
    
    [headView addSubview:self.banner];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.banner.frame.origin.y+self.banner.frame.size.height,screen_width, 10)];
    lineView3.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [headView addSubview:lineView3];
    
    UILabel *huatijingxuan = [[UILabel alloc]initWithFrame:CGRectMake(20, lineView3.frame.origin.y+lineView3.frame.size.height, 100, 30)];
    huatijingxuan.text = @"话题精选";
    [headView addSubview:huatijingxuan];
    self.tableView.tableHeaderView = headView;
}
-(void)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZYBannerViewDataSource

// 返回Banner需要显示Item(View)的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return 2;
}

// 返回Banner在不同的index所要显示的View (可以是完全自定义的view, 且无需设置frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    // 取出数据
    UIView *bannerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,banner.frame.size.width, banner.frame.size.height)];
    bannerView.backgroundColor = [UIColor whiteColor];
    
    if (index == 0) {
        //教练圈
        UIView *jiaolianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, banner.frame.size.width/4, banner.frame.size.height)];
        UIImageView *jiaolianImView = [[UIImageView alloc]initWithFrame:CGRectMake(jiaolianView.frame.size.width/2-25, 10, 50, 50)];
        jiaolianImView.image = [UIImage imageNamed:@"shequ_jiaolianquan"];
        UILabel *jiaolianLabel = [[UILabel alloc]initWithFrame:CGRectMake(jiaolianImView.frame.origin.x, jiaolianImView.frame.origin.y+jiaolianImView.frame.size.height+10, jiaolianImView.frame.size.width, 20)];
        jiaolianLabel.text = @"教练圈";
        jiaolianLabel.font = [UIFont systemFontOfSize:14];
        jiaolianLabel.textAlignment = UITextAlignmentCenter;
        [jiaolianView addSubview:jiaolianImView];
        [jiaolianView addSubview:jiaolianLabel];
        [bannerView addSubview:jiaolianView];
        
        //学员圈
        UIView *xueyuanView = [[UIView alloc]initWithFrame:CGRectMake(banner.frame.size.width/4,0 , banner.frame.size.width/4, banner.frame.size.height)];
        UIImageView *xueyuanImView = [[UIImageView alloc]initWithFrame:CGRectMake(xueyuanView.frame.size.width/2-25, 10, 50, 50)];
        xueyuanImView.image = [UIImage imageNamed:@"shequ_xueyuanquan"];
        UILabel *xueyuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, xueyuanImView.frame.origin.y+xueyuanImView.frame.size.height+10, xueyuanView.frame.size.width, 20)];
        xueyuanLabel.text = @"学院圈";
        xueyuanLabel.font = [UIFont systemFontOfSize:14];
        xueyuanLabel.textAlignment = UITextAlignmentCenter;
        [xueyuanView addSubview:xueyuanImView];
        [xueyuanView addSubview:xueyuanLabel];
        [bannerView addSubview:xueyuanView];
        
        //科一互助
        UIView *kemu1View = [[UIView alloc]initWithFrame:CGRectMake(banner.frame.size.width*2/4, 0,banner.frame.size.width/4, banner.frame.size.height)];
        UIImageView *kemu1ImView = [[UIImageView alloc]initWithFrame:CGRectMake(kemu1View.frame.size.width/2-25, 10, 50, 50)];
        kemu1ImView.image = [UIImage imageNamed:@"shequ_keyihuzhu"];
        UILabel *kemu1Label = [[UILabel alloc]initWithFrame:CGRectMake(0, kemu1ImView.frame.origin.y+kemu1ImView.frame.size.height+10, kemu1View.frame.size.width, 20)];
        kemu1Label.text = @"科一互助";
        kemu1Label.font = [UIFont systemFontOfSize:14];
        kemu1Label.textAlignment = UITextAlignmentCenter;
        [kemu1View addSubview:kemu1ImView];
        [kemu1View addSubview:kemu1Label];
        [bannerView addSubview:kemu1View];
        
        //科二互助
        UIView *kemu2View = [[UIView alloc]initWithFrame:CGRectMake(banner.frame.size.width*3/4,0, banner.frame.size.width/4, banner.frame.size.height)];
        UIImageView *kemu2ImView = [[UIImageView alloc]initWithFrame:CGRectMake(kemu2View.frame.size.width/2-25, 10, 50, 50)];
        kemu2ImView.image = [UIImage imageNamed:@"shequ_keyihuzhu"];
        UILabel *kemu2Label = [[UILabel alloc]initWithFrame:CGRectMake(0, kemu2ImView.frame.origin.y+kemu2ImView.frame.size.height+10, kemu2View.frame.size.width, 20)];
        kemu2Label.text = @"科二互助";
        kemu2Label.font = [UIFont systemFontOfSize:14];
        kemu2Label.textAlignment = UITextAlignmentCenter;
        [kemu2View addSubview:kemu2ImView];
        [kemu2View addSubview:kemu2Label];
        [bannerView addSubview:kemu2View];
    }else if (index ==1){
        //科三互助
        UIView *kemu3View = [[UIView alloc]initWithFrame:CGRectMake(banner.frame.size.width*0/4,0, banner.frame.size.width/4, banner.frame.size.height)];
        UIImageView *kemu3ImView = [[UIImageView alloc]initWithFrame:CGRectMake(kemu3View.frame.size.width/2-25, 10, 50, 50)];
        kemu3ImView.image = [UIImage imageNamed:@"shequ_keyihuzhu"];
        UILabel *kemu3Label = [[UILabel alloc]initWithFrame:CGRectMake(0, kemu3ImView.frame.origin.y+kemu3ImView.frame.size.height+10, kemu3View.frame.size.width, 20)];
        kemu3Label.text = @"科三互助";
        kemu3Label.font = [UIFont systemFontOfSize:14];
        kemu3Label.textAlignment = UITextAlignmentCenter;
        [kemu3View addSubview:kemu3ImView];
        [kemu3View addSubview:kemu3Label];
        [bannerView addSubview:kemu3View];
        
        //科四互助
        UIView *kemu4View = [[UIView alloc]initWithFrame:CGRectMake(banner.frame.size.width*1/4,0, banner.frame.size.width/4, banner.frame.size.height)];
        UIImageView *kemu4ImView = [[UIImageView alloc]initWithFrame:CGRectMake(kemu4View.frame.size.width/2-25, 10, 50, 50)];
        kemu4ImView.image = [UIImage imageNamed:@"shequ_keyihuzhu"];
        UILabel *kemu4Label = [[UILabel alloc]initWithFrame:CGRectMake(0, kemu4ImView.frame.origin.y+kemu4ImView.frame.size.height+10, kemu4View.frame.size.width, 20)];
        kemu4Label.text = @"科四互助";
        kemu4Label.font = [UIFont systemFontOfSize:14];
        kemu4Label.textAlignment = UITextAlignmentCenter;
        [kemu4View addSubview:kemu4ImView];
        [kemu4View addSubview:kemu4Label];
        [bannerView addSubview:kemu4View];
    }
    
    return bannerView;
}

// 返回Footer在不同状态时要显示的文字
- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState
{
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}

#pragma mark - ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个项目", index);
}


#pragma mark -
#pragma mark Demo banner property setting (无需关心此部分逻辑)

- (IBAction)switchValueChanged:(UISwitch *)aSwitch
{
    switch (aSwitch.tag) {
        case 0: // Should Loop
            self.banner.shouldLoop = aSwitch.isOn;
            break;
            
        case 1: // Show Footer
            self.banner.showFooter = aSwitch.isOn;
            break;
            
        case 2: // Auto Scroll
            self.banner.autoScroll = aSwitch.isOn;
            break;
            
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
//    return self.tableDataSource.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"commnunity";
    CommunityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        cell = [[CommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
   
    UIFont *userNamefont = [UIFont systemFontOfSize:16];
    [cell.userNameLabel setNumberOfLines:0];
    NSString *sizeFree = @"孤独的小兔崽子";
    CGSize size = CGSizeMake(320, 2000);
    CGSize labelsize = [sizeFree sizeWithFont:userNamefont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [cell.userNameLabel setFrame:CGRectMake(cell.userImageView.frame.origin.x+cell.userImageView.frame.size.width+9,cell.userImageView.frame.origin.y+5, 100, labelsize.height)];
    cell.userNameLabel.text = sizeFree;
    cell.userNameLabel.font = userNamefont;
    [cell refreshLayout];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}



@end
