//报名学车时的选择VC
//

#import "EnrollSelectTableViewController.h"
#import "public.h"
#import "EnrollTrainerTableView.h"
#import "EnrollSchoolTableView.h"
#import "AppDelegate.h"
#import "MJRefresh.h"


@interface EnrollSelectTableViewController ()
{
    UIView *tranerView;
    UIView *schoolView;
    NSMutableArray *selectSectionArray;
    UIButton *segBtn1;
    UIButton *segBtn2;
    
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@end

@implementation EnrollSelectTableViewController
- (void)loadView {
    [super loadView];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    

}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
   
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self initData];
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        [self getCateListData];
    //    });
    
    
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    selectSectionArray = [[NSMutableArray alloc] init];
    self.tableDataSource = [[NSMutableArray alloc] init];
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

-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = RGB_BACKGROUND_COLOR_BLUE;
    [self.view addSubview:backView];
//    //下划线
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
//    lineView.backgroundColor = RGB(192, 192, 192);
//    [backView addSubview:lineView];
    
    //segment
    segBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    segBtn1.frame = CGRectMake(screen_width/2-80, 20, 80, 35);
    segBtn1.tag = 20;
    [segBtn1 setTitle:@"驾校" forState:UIControlStateNormal];
    [segBtn1 setTitleColor:RGB_BACKGROUND_COLOR_BLUE forState:UIControlStateSelected];
    [segBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [segBtn1 setBackgroundColor:[UIColor whiteColor]];
    segBtn1.selected = YES;
    segBtn1.font = [UIFont systemFontOfSize:15];
    segBtn1.layer.borderWidth = 1;
    segBtn1.layer.borderColor = [[UIColor whiteColor]CGColor];
    [segBtn1 addTarget:self action:@selector(OnSegBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:segBtn1];
    
    segBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    segBtn2.frame = CGRectMake(screen_width/2, 20, 80, 35);
    segBtn2.tag = 21;
    [segBtn2 setTitle:@"教练" forState:UIControlStateNormal];
    [segBtn2 setTitleColor:RGB_BACKGROUND_COLOR_BLUE forState:UIControlStateSelected];
    [segBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [segBtn2 setBackgroundColor:RGB_BACKGROUND_COLOR_BLUE];
    segBtn2.font = [UIFont systemFontOfSize:15];
    segBtn2.layer.borderWidth = 1;
    segBtn2.layer.borderColor = [[UIColor whiteColor] CGColor];
    [segBtn2 addTarget:self action:@selector(OnSegBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:segBtn2];
    
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, BACK_IM_WIDTH, 26)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    [backView addSubview:leftButton];
}

-(void)initViews{
  
    tranerView = [[EnrollTrainerTableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64)];
    schoolView = [[EnrollSchoolTableView alloc] initWithFrame:CGRectMake(0, 64, screen_width,screen_height-64)];
    //解决uitableview 切换出现空白bug
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self.view addSubview:schoolView];
    //将tableview置于view层次的底层
   // [self.view sendSubviewToBack:schoolView];
}

#pragma mark - 响应事件
-(void)OnSegBtn:(UIButton *)sender{
    NSInteger tag = sender.tag;
  
    [segBtn1 setBackgroundColor:RGB_BACKGROUND_COLOR_BLUE];
    [segBtn2 setBackgroundColor:RGB_BACKGROUND_COLOR_BLUE];
    segBtn1.selected = NO;
    segBtn2.selected = NO;
    sender.selected = YES;
    [sender setBackgroundColor:[UIColor whiteColor]];
   // [sender setBackgroundColor:navigationBarColor];
    if (tag == 21) {
        if (schoolView.superview) {
            [schoolView removeFromSuperview];
        }
        if (!tranerView.superview) {
            [self.view addSubview:tranerView];
            [self.view sendSubviewToBack:tranerView];
        }
    }else{
        if (tranerView.superview) {
            [tranerView removeFromSuperview];
        }
        if (!schoolView.superview) {
            [self.view addSubview:schoolView];
            [self.view sendSubviewToBack:tranerView];
        }
    }
}

-(void)OnFilterBtn:(UIButton *)sender{
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        UIButton *sanjiaoBtn = (UIButton *)[self.view viewWithTag:120+i];
        btn.selected = NO;
        sanjiaoBtn.selected = NO;
    }
    sender.selected = YES;
    UIButton *sjBtn = (UIButton *)[self.view viewWithTag:sender.tag+20];
    sjBtn.selected = YES;
    
}


#pragma mark - 请求数据

//获取商家列表
-(void)getData{
    
}

-(void)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
