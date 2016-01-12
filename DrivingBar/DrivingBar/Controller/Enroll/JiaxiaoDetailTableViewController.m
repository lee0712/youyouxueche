//
//  JiaxiaoViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "UIColor+HEX.h"
#import "JiaxiaoDetailTableViewController.h"
#import "FinalStarRatingBar.h"
#import "PinglunTableViewCell.h"

@interface JiaxiaoDetailTableViewController (){
    UIImageView *headIm;
    UILabel *headTitle;
    UILabel *headTel;
    UILabel *headTelValue;
    UILabel *headEva;
    UILabel *addr;
    UILabel *addrValue;
    FinalStarRatingBar *bar;
    unsigned long barNum;
    UIImageView *schoolIm1;
    UIImageView *schoolIm2;
    UIImageView *schoolIm3;
    UILabel *titleLabel;
    UILabel *juliLabel;
    
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@end

@implementation JiaxiaoDetailTableViewController

-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavi];
    [self initView];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化标题栏
-(void)initNavi {
    //标题栏
    self.navigationController.navigationBarHidden = NO;
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
//初始化界面
-(void)initView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    NSDictionary *titleColorDic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    //    self.navigationController.navigationBar.titleTextAttributes = titleColorDic;
    //
    //delete useless line
    [self setHeadView];
    //预约按钮
    UIButton *yuyueBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    yuyueBt.frame = CGRectMake(0, screen_height - 60,screen_width, 60);
    yuyueBt.backgroundColor = RGB(241, 95, 95);
    [yuyueBt setTitle:@"预约学车" forState:UIControlStateNormal];
    [yuyueBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuyueBt addTarget:self action:@selector(yuyue:) forControlEvents:UIControlEventTouchUpInside];
    yuyueBt.titleLabel.font =  [UIFont systemFontOfSize:16];
    self.tableView.tableFooterView = yuyueBt;

    self.tableDataSource = [[NSMutableArray alloc]init];
}

-(void)setHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVI_AND_STATUS_HEIGHT, screen_width, 10+100+10+10+10+20+10+10+10+20+10+10+20+(screen_width-40)/3+10+10+10+10)];
    headView.backgroundColor = [UIColor whiteColor];
    
    //用户头像
    headIm = [[UIImageView alloc]init];
    
    headIm.frame = CGRectMake(10, 18,
                              100, 100);
    headIm.image = [UIImage imageNamed:@"img_jiaxiao.png"];
    [headView addSubview:headIm];
    //驾校名称
    headTitle = [[UILabel alloc]initWithFrame:CGRectMake(headIm.frame.origin.x+headIm.frame.size.width+20, headIm.frame.origin.y, screen_width/2, 20)];
    
    headTel = [[UILabel alloc]initWithFrame:CGRectMake(headTitle.frame.origin.x, headTitle.frame.origin.y+headTitle.frame.size.height+10, 80, 20)];
    headTitle.font = [UIFont systemFontOfSize:16];
    headTel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:headTitle];
    //联系方式
    headTel.text = @"联系方式";
    headTel.textColor = [UIColor grayColor];
    headTelValue = [[UILabel alloc]initWithFrame:CGRectMake(headTel.frame.origin.x+headTel.frame.size.width+10, headTel.frame.origin.y, 120, 20)];
    headTelValue.font = [UIFont systemFontOfSize:14];
    [headView addSubview:headTel];
    [headView addSubview:headTelValue];
    //综合评价
    headEva = [[UILabel alloc]initWithFrame:CGRectMake(headTel.frame.origin.x, headTel.frame.origin.y+headTel.frame.size.height+10, 80, 20)];
    headEva.textColor = [UIColor grayColor];
    headEva.text = @"综合评价";
    headEva.font = [UIFont systemFontOfSize:14];
    [headView addSubview:headEva];
    //星级
    bar = [[FinalStarRatingBar alloc] initWithFrame:CGRectMake(headEva.frame.origin.x+headEva.frame.size.width+10, headEva.frame.origin.y, 120, 18) starCount:5];
    [self.view addSubview:bar];
    bar.enabled = false;
    [headView addSubview:bar];
    //灰白空行
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, headIm.frame.origin.y+headIm.frame.size.height+10,screen_width , 10)];
    lineView1.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [headView addSubview:lineView1];
    //地址
    addr = [[UILabel alloc]initWithFrame:CGRectMake(headIm.frame.origin.x, lineView1.frame.origin.y+lineView1.frame.size.height+10, 60, 20)];
    addr.text = @"地址:";
    addr.textColor = [UIColor grayColor];
        addr.font = [UIFont systemFontOfSize:14];
    addrValue = [[UILabel alloc]initWithFrame:CGRectMake(addr.frame.origin.x+addr.frame.size.width+10, addr.frame.origin.y, screen_width, 20)];
    addrValue.font =[UIFont systemFontOfSize:14];
    [headView addSubview: addr];
    [headView addSubview:addrValue];
    //灰白空行
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, addr.frame.origin.y+addr.frame.size.height+10, screen_width, 10)];
    lineView2.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [headView addSubview:lineView2];
    UIImageView *juliIm = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width-38, addrValue.frame.origin.y, 18, 20)];
    juliIm.image = [UIImage imageNamed:@"jiaxiao_dingwei"];
    juliLabel = [[UILabel alloc]initWithFrame:CGRectMake(juliIm.frame.origin.x-8-50, juliIm.frame.origin.y, 50, 20)];
    
    juliLabel.textAlignment = UITextAlignmentRight;
    juliLabel.textColor = [UIColor grayColor];
   
    juliLabel.font = [UIFont systemFontOfSize:10];
    [headView addSubview:juliIm];
    [headView addSubview:juliLabel];
  
    //校内详情
    UILabel *xiaoneixiangqing = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView2.frame.origin.y+lineView2.frame.size.height+10, 100, 20)];
    xiaoneixiangqing.text = @"校内详情";
    xiaoneixiangqing.textColor = [UIColor grayColor];
    [headView addSubview:xiaoneixiangqing];
    //三张图片
    schoolIm1 = [[UIImageView alloc]init];
    schoolIm1.frame = CGRectMake(10, 10+xiaoneixiangqing.frame.size.height+xiaoneixiangqing.frame.origin.y,(screen_width-40)/3, (screen_width-40)/3);
    schoolIm1.image = [UIImage imageNamed:@"img_jiaxiao.png"];
    
    schoolIm2 = [[UIImageView alloc]init];
    schoolIm2.frame = CGRectMake(schoolIm1.frame.origin.x+schoolIm1.frame.size.width+10,schoolIm1.frame.origin.y,(screen_width-40)/3, (screen_width-40)/3);
    schoolIm2.image = [UIImage imageNamed:@"img_jiaxiao.png"];
    
    schoolIm3 = [[UIImageView alloc]init];
    schoolIm3.frame = CGRectMake(schoolIm2.frame.origin.x+schoolIm2.frame.size.width+10,schoolIm2.frame.origin.y,(screen_width-40)/3, (screen_width-40)/3);
    schoolIm3.image = [UIImage imageNamed:@"img_jiaxiao.png"];
    [headView addSubview:schoolIm1];
    [headView addSubview:schoolIm2];
    [headView addSubview:schoolIm3];
    
    //灰白空行
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, schoolIm1.frame.origin.y+schoolIm1.frame.size.height+10, screen_width, 10)];
    lineView3.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [headView addSubview:lineView3];
    //驾友评论
    UILabel *jiayoupinglun = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView3.frame.size.height+lineView3.frame.origin.y+20, 100, 20)];
    jiayoupinglun.text = @"驾友评论";
    jiayoupinglun.textColor = [UIColor grayColor];
    [headView addSubview:jiayoupinglun];
    //灰白空行
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(20, headView.frame.size.height-1, screen_width, 1)];
    lineView4.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    [headView addSubview:lineView4];
    
    self.tableView.tableHeaderView = headView;
}
-(void)getData {
    titleLabel.text = @"黄埔驾校";
    headTitle.text=@"黄埔驾校";
    headTelValue.text = @"020-2323421";
    addrValue.text = @"科学路光谱西路45号";
     juliLabel.text = @"200m";
    //星级评分
    [bar setRating:4];
    
    [self.tableView reloadData];
}

-(void)finish:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    //其他代码
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *identifier = @"pingluncell";
    PinglunTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [[PinglunTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userImageView.image = [UIImage imageNamed:@"menu_user.png"];
    cell.userNameLabel.text = @"angla";
    cell.detailLabel.text = @"环境挺好的，去的人也多";
    cell.timeLabel.text = @"2015-11-12";
    cell.bar.rating = 3;
    return cell;
}

//预约
-(void)yuyue:(id)sender{
   
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
