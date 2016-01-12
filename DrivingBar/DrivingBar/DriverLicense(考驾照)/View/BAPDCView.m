//
//  BAPDCView.m
//  BAPDCViewTest
//
//  Created by 博爱之家 on 15/11/20.
//  Copyright © 2015年 博爱之家. All rights reserved.
//

#import "BAPDCView.h"
#import "BAUtilities.h"
#import "BAPageViewController.h"
#import "BASimulationTestViewController.h"

#import "BAScoresRankingViewController.h"
#import "BASpecialPracticeViewController.h"

#import "BAWrongTestViewController.h"
#import "BAMyCollectionViewController.h"

@interface BAPDCView ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    // 分区View
    UIView *subViewOne;
    UIView *subViewTwo;
    UIView *subViewThree;
    UIView *subViewFour;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGSize size;
@property (copy, nonatomic) selected selected;


@end

@implementation BAPDCView


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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIden = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIden];
    if (!cell)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIden];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
    {
        subViewOne = [[UIView alloc] init];
        subViewOne.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 200);
        subViewOne.backgroundColor = [UIColor clearColor];

        [cell.contentView addSubview:subViewOne];
        [self setUpSectionOne];
    }
    if (indexPath.section == 1)
    {
        subViewTwo = [[UIView alloc] init];
        subViewTwo.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 50);
        subViewTwo.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:subViewTwo];
        [self setUpSectionTwo];
    }
    if (indexPath.section == 2)
    {
        subViewThree = [[UIView alloc] init];
        subViewThree.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 200);
        subViewThree.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:subViewThree];
        [self setUpSectionThree];
    }
    if (indexPath.section == 3)
    {
        subViewFour = [[UIView alloc] init];
        subViewFour.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 50);
        subViewFour.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:subViewFour];
        [self setUpSectionFour];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = @"";
//    
//    cell.equipmentModel = dataArray[indexPath.row];
    
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
    if (indexPath.section == 0)
    {
        return 200;
    }
    if (indexPath.section == 1)
    {
        return 50;
    }
    if (indexPath.section == 2)
    {
        return 200;
    }
    if (indexPath.section == 3)
    {
        return 50;
    }
    return 0;
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

#pragma mark - UI
#pragma mark 第一分区
- (void)setUpSectionOne
{
    // 顺序练习
    UIButton *orderPracticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderPracticeBtn.frame = CGRectMake(KSCREEN_WIDTH/2 - 50, 50, 100, 100);
    orderPracticeBtn.backgroundColor = COLOR_C(38, 211, 237, 1.0);
    [orderPracticeBtn setTitle:@"顺序练习" forState:UIControlStateNormal];
    orderPracticeBtn.layer.cornerRadius = orderPracticeBtn.frame.size.width/2;
    orderPracticeBtn.clipsToBounds = YES;
//    orderPracticeBtn.layer.borderWidth = 3.0f;
   // orderPracticeBtn.layer.borderColor = COLOR_C(38, 211, 237, 0.3).CGColor;
    [orderPracticeBtn setBackgroundImage:[UIImage imageNamed:@"shunxu"] forState:UIControlStateNormal];
    [orderPracticeBtn addTarget:self action:@selector(orderPracticeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 随机练习
    UIButton *randomPracticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    randomPracticeBtn.frame = CGRectMake(0, 0, KSCREEN_WIDTH/2 - 1, 100);
    randomPracticeBtn.backgroundColor = [UIColor clearColor];
    [randomPracticeBtn addTarget:self action:@selector(randomPracticeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *randomPracticeImg = [[UIImageView alloc] init];
    randomPracticeImg.frame = CGRectMake(randomPracticeBtn.width/2 - 20, 10, 40, 40);
    randomPracticeImg.image = [UIImage imageNamed:@"suiji"];
    randomPracticeImg.layer.cornerRadius = randomPracticeImg.frame.size.width/2;
    randomPracticeImg.clipsToBounds = YES;
    
    UILabel *randomPracticeLable = [[UILabel alloc] init];
    randomPracticeLable.frame = CGRectMake(0, randomPracticeImg.height + 10, randomPracticeBtn.width, 40);
    randomPracticeLable.text = @"随机练习";
    randomPracticeLable.textAlignment = NSTextAlignmentCenter;
    randomPracticeLable.font = [UIFont systemFontOfSize:15];
    
    CGRect randomPracticeHViewFrame = CGRectMake(20, randomPracticeBtn.height-1, randomPracticeBtn.width - 20 - orderPracticeBtn.width/2, 1);
    UIView *randomPracticeHView = [self customHViewWithFrame:randomPracticeHViewFrame]; // 横线
    
    CGRect randomPracticeVViewFrame = CGRectMake(randomPracticeBtn.width - 1, 10, 1, randomPracticeBtn.height - 10 - orderPracticeBtn.height/2 - 1);
    UIView *randomPracticeVView = [self customHViewWithFrame:randomPracticeVViewFrame]; // 竖线
    
    // 专项练习
    UIButton *specialPracticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    specialPracticeBtn.frame =CGRectMake(randomPracticeBtn.width+1, 0, KSCREEN_WIDTH/2, 100);
    specialPracticeBtn.backgroundColor = [UIColor clearColor];
    
    UIImageView *specialPracticeImg = [[UIImageView alloc] init];
    specialPracticeImg.frame = CGRectMake(specialPracticeBtn.width/2 - 20, 10, 40, 40);
    specialPracticeImg.image = [UIImage imageNamed:@"zhuanxiang"];
    specialPracticeImg.layer.cornerRadius = specialPracticeImg.frame.size.width/2;
    specialPracticeImg.clipsToBounds = YES;
    [specialPracticeBtn addTarget:self action:@selector(specialPracticeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *specialPracticeLable = [[UILabel alloc] init];
    specialPracticeLable.frame = CGRectMake(0, specialPracticeImg.height + 10, specialPracticeBtn.width, 40);
    specialPracticeLable.text = @"专项练习";
    specialPracticeLable.textAlignment = NSTextAlignmentCenter;
    specialPracticeLable.font = [UIFont systemFontOfSize:15];
    
    CGRect specialPracticeHViewFrame = CGRectMake(orderPracticeBtn.width/2+1, specialPracticeBtn.height-1, specialPracticeBtn.width - orderPracticeBtn.width/2 - 1 - 20, 1);
    UIView *specialPracticeHView = [self customHViewWithFrame:specialPracticeHViewFrame];
    
    // 难题攻克
    UIButton *overcomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    overcomeBtn.frame = CGRectMake(0, 100, KSCREEN_WIDTH/2 - 1, 100);
    overcomeBtn.backgroundColor = [UIColor clearColor];
    
    UIImageView *overcomeImg = [[UIImageView alloc] init];
    overcomeImg.frame = CGRectMake(overcomeBtn.width/2 - 20, 10, 40, 40);
    overcomeImg.image = [UIImage imageNamed:@"nanti"];
    overcomeImg.layer.cornerRadius = overcomeImg.frame.size.width/2;
    overcomeImg.clipsToBounds = YES;
    [overcomeBtn addTarget:self action:@selector(overcomeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *overcomeLable = [[UILabel alloc] init];
    overcomeLable.frame = CGRectMake(0, overcomeImg.height + 10, overcomeBtn.width, 40);
    overcomeLable.text = @"难题攻克";
    overcomeLable.textAlignment = NSTextAlignmentCenter;
    overcomeLable.font = [UIFont systemFontOfSize:15];
    
    CGRect overcomeVViewFrame = CGRectMake(overcomeBtn.width - 1, orderPracticeBtn.height/2 + 1, 1, overcomeBtn.height - orderPracticeBtn.height/2 - 1 - 10);
    UIView *overcomeVView = [self customHViewWithFrame:overcomeVViewFrame]; // 竖线
    
    // 易错题集
    UIButton *easyWrongSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    easyWrongSetBtn.frame = CGRectMake(randomPracticeBtn.width+1, 100, KSCREEN_WIDTH/2, 100);
    easyWrongSetBtn.backgroundColor = [UIColor clearColor];
    
    UIImageView *easyWrongSetImg = [[UIImageView alloc] init];
    easyWrongSetImg.frame = CGRectMake(easyWrongSetBtn.width/2 - 20, 10, 40, 40);
    easyWrongSetImg.image = [UIImage imageNamed:@"yicuo"];
    easyWrongSetImg.backgroundColor = [UIColor greenColor];
    easyWrongSetImg.layer.cornerRadius = specialPracticeImg.frame.size.width/2;
    easyWrongSetImg.clipsToBounds = YES;
    [easyWrongSetBtn addTarget:self action:@selector(easyWrongSetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *easyWrongSetLable = [[UILabel alloc] init];
    easyWrongSetLable.frame = CGRectMake(0, easyWrongSetImg.height + 10, easyWrongSetBtn.width, 40);
    easyWrongSetLable.text = @"易错题集";
    easyWrongSetLable.textAlignment = NSTextAlignmentCenter;
    easyWrongSetLable.font = [UIFont systemFontOfSize:15];
    
    
    [subViewOne addSubview:randomPracticeBtn];
    [randomPracticeBtn addSubview:randomPracticeImg];
    [randomPracticeBtn addSubview:randomPracticeLable];
    [randomPracticeBtn addSubview:randomPracticeHView];
    [randomPracticeBtn addSubview:randomPracticeVView];

    [subViewOne addSubview:specialPracticeBtn];
    [specialPracticeBtn addSubview:specialPracticeImg];
    [specialPracticeBtn addSubview:specialPracticeLable];
    [specialPracticeBtn addSubview:specialPracticeHView];
    
    [subViewOne addSubview:overcomeBtn];
    [overcomeBtn addSubview:overcomeImg];
    [overcomeBtn addSubview:overcomeLable];
    [overcomeBtn addSubview:overcomeVView];

    [subViewOne addSubview:easyWrongSetBtn];
    [easyWrongSetBtn addSubview:easyWrongSetImg];
    [easyWrongSetBtn addSubview:easyWrongSetLable];
    
    [subViewOne addSubview:orderPracticeBtn];
}

#pragma mark 第二分区
- (void)setUpSectionTwo
{
    // 我的错题
    CGRect myErrorBtnFrame = CGRectMake(0, 0, KSCREEN_WIDTH/2 - 0.5, 50);
    UIButton *myErrorBtn = [self customButtonWithTitle:@"我的错题" titleColor:[UIColor blackColor] frame:myErrorBtnFrame];
    
    [myErrorBtn addTarget:self action:@selector(myErrorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 中间竖线
    CGRect middleVViewFrame = CGRectMake(myErrorBtn.width + 0.5, 10, 1, 30);
    UIView *middleVView = [self customHViewWithFrame:middleVViewFrame];
    
    // 我的收藏
    CGRect myCollectionBtnFrame = CGRectMake(KSCREEN_WIDTH/2 + 0.5, 0, KSCREEN_WIDTH/2 - 0.5, 50);
    UIButton *myCollectionBtn = [self customButtonWithTitle:@"我的收藏" titleColor:[UIColor blackColor] frame:myCollectionBtnFrame];
    [myCollectionBtn addTarget:self action:@selector(myCollectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [subViewTwo addSubview:middleVView];
    [subViewTwo addSubview:myErrorBtn];
    [subViewTwo addSubview:myCollectionBtn];
}

#pragma mark 第三分区
- (void)setUpSectionThree
{
    // 模拟考试
    UIButton *simulationTestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    simulationTestBtn.frame = CGRectMake(KSCREEN_WIDTH/2 - 50, 50, 100, 100);
    simulationTestBtn.backgroundColor = COLOR_C(157, 106, 241, 1.0);
    [simulationTestBtn setTitle:@"模拟考试" forState:UIControlStateNormal];
    simulationTestBtn.layer.cornerRadius = simulationTestBtn.frame.size.width/2;
    simulationTestBtn.clipsToBounds = YES;
//    simulationTestBtn.layer.borderWidth = 3.0f;
//    simulationTestBtn.layer.borderColor = COLOR_C(157, 106, 241, 0.3).CGColor;
    [simulationTestBtn setBackgroundImage:[UIImage imageNamed:@"moni"] forState:UIControlStateNormal];
    [simulationTestBtn addTarget:self action:@selector(simulationTestBtClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 通过率预测
    CGRect passRateLabelFrame = CGRectMake(0, 0, KSCREEN_WIDTH/2 - 1, 60);
    UILabel *passRateLabel = [self customLabelWithFrame:passRateLabelFrame text:@"通过率预测" textColor:[UIColor lightGrayColor]];
    
    // 百分比
    CGRect scoreLabelFrame = CGRectMake(0, passRateLabel.height, KSCREEN_WIDTH/2 - 31, 80);
    UILabel *scoreLabel = [self customLabelWithFrame:scoreLabelFrame text:[NSString stringWithFormat:@"%@%%", @"99.95"] textColor:[UIColor redColor]];
    scoreLabel.font = [UIFont systemFontOfSize:23];
    
    // 考试次数
    CGRect testNumberLabelFrame = CGRectMake(0, scoreLabel.height + passRateLabel.height, KSCREEN_WIDTH/2 - 1, 60);
    UILabel *testNumberLabel = [self customLabelWithFrame:testNumberLabelFrame text:[NSString stringWithFormat:@"考试次数：%@", @"18"] textColor:[UIColor lightGrayColor]];
    
    // 上竖线
    CGRect simulationTestVViewFrame = CGRectMake(KSCREEN_WIDTH/2 - 1, 10, 1 , 200/2 - 10 - simulationTestBtn.height/2 - 1);
    UIView *simulationTestVView = [self customHViewWithFrame:simulationTestVViewFrame];
    
    // 下竖线
    CGRect simulationTestLowViewFrame = CGRectMake(KSCREEN_WIDTH/2 - 1, 100 + simulationTestBtn.height/2 + 1, 1 , 200/2 - 10 - simulationTestBtn.height/2 - 1);
    UIView *simulationTestLowView = [self customHViewWithFrame:simulationTestLowViewFrame];

    // 成绩排行
    UIButton *scoresRankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scoresRankBtn.frame = CGRectMake(passRateLabel.width+1, 0, KSCREEN_WIDTH/2 - 1, 100);
    scoresRankBtn.backgroundColor = [UIColor clearColor];
    [scoresRankBtn addTarget:self action:@selector(scoresRankBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *scoresRankImg = [[UIImageView alloc] init];
    scoresRankImg.frame = CGRectMake(scoresRankBtn.width/2 - 20, 10, 40, 40);
    scoresRankImg.image = [UIImage imageNamed:@"chengji"];
    //    overcomeImg.backgroundColor = [UIColor greenColor];
    scoresRankImg.layer.cornerRadius = scoresRankImg.frame.size.width/2;
    scoresRankImg.clipsToBounds = YES;
    
    CGRect scoresRankLableFrame = CGRectMake(0, scoresRankImg.height + 10, scoresRankBtn.width, 40);
    UILabel *scoresRankLable = [self customLabelWithFrame:scoresRankLableFrame text:@"成绩排行" textColor:[UIColor blackColor]];
    scoresRankLable.textAlignment = NSTextAlignmentCenter;
    scoresRankLable.font = [UIFont systemFontOfSize:15];
    
    CGRect overcomeHViewFrame = CGRectMake(simulationTestBtn.width/2+1, scoresRankBtn.height-1, scoresRankBtn.width - simulationTestBtn.width/2 - 1 - 20, 1);
    UIView *scoresRankHView = [self customHViewWithFrame:overcomeHViewFrame];

    // VIP保过
    UIButton *vipAssuredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vipAssuredBtn.frame = CGRectMake(passRateLabel.width+1, 100, KSCREEN_WIDTH/2 - 1, 100);
    vipAssuredBtn.backgroundColor = [UIColor clearColor];
    [vipAssuredBtn addTarget:self action:@selector(orderPracticeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *vipAssuredImg = [[UIImageView alloc] init];
    vipAssuredImg.frame = CGRectMake(vipAssuredBtn.width/2 - 20, 10, 40, 40);
    vipAssuredImg.image = [UIImage imageNamed:@"VIP"];
    //    overcomeImg.backgroundColor = [UIColor greenColor];
    vipAssuredImg.layer.cornerRadius = vipAssuredImg.frame.size.width/2;
    vipAssuredImg.clipsToBounds = YES;
    
    CGRect vipAssuredLableFrame = CGRectMake(0, scoresRankImg.height + 10, scoresRankBtn.width, 40);
    UILabel *vipAssuredLable = [self customLabelWithFrame:vipAssuredLableFrame text:@"VIP保过" textColor:[UIColor blackColor]];
    vipAssuredLable.textAlignment = NSTextAlignmentCenter;
    vipAssuredLable.font = [UIFont systemFontOfSize:15];


    [subViewThree addSubview:scoresRankBtn];
    [scoresRankBtn addSubview:scoresRankImg];
    [scoresRankBtn addSubview:scoresRankLable];
    [scoresRankBtn addSubview:scoresRankHView];
    
    [subViewThree addSubview:vipAssuredBtn];
    [vipAssuredBtn addSubview:vipAssuredImg];
    [vipAssuredBtn addSubview:vipAssuredLable];
    
    [subViewThree addSubview:passRateLabel];
    [subViewThree addSubview:scoreLabel];
    [subViewThree addSubview:testNumberLabel];
    [subViewThree addSubview:simulationTestVView];
    [subViewThree addSubview:simulationTestLowView];
    [subViewThree addSubview:simulationTestBtn];
}

#pragma mark 第四分区
- (void)setUpSectionFour
{
    // 科一考规
    CGRect myErrorBtnFrame = CGRectMake(0, 0, KSCREEN_WIDTH/2 - 0.5, 50);
    UIButton *myErrorBtn = [self customButtonWithTitle:@"科一考规" titleColor:[UIColor blackColor] frame:myErrorBtnFrame];
    
    [myErrorBtn addTarget:self action:@selector(orderPracticeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 中间竖线
    CGRect middleVViewFrame = CGRectMake(myErrorBtn.width + 0.5, 10, 1, 30);
    UIView *middleVView = [self customHViewWithFrame:middleVViewFrame];
    
    // 答题技巧
    CGRect myCollectionBtnFrame = CGRectMake(KSCREEN_WIDTH/2 + 0.5, 0, KSCREEN_WIDTH/2 - 0.5, 50);
    UIButton *myCollectionBtn = [self customButtonWithTitle:@"答题技巧" titleColor:[UIColor blackColor] frame:myCollectionBtnFrame];
    [myCollectionBtn addTarget:self action:@selector(orderPracticeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [subViewFour addSubview:middleVView];
    [subViewFour addSubview:myErrorBtn];
    [subViewFour addSubview:myCollectionBtn];
}

#pragma mark - 按钮点击事件
#pragma mark 顺序练习按钮
- (IBAction)orderPracticeBtn:(id)sender
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BAPageViewController_orderPracticeBtn";
    pageVC.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark 随机练习按钮
- (IBAction)randomPracticeBtnClick:(id)sender
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BAPageViewController_randomPracticeBtn";
    pageVC.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark 专项练习按钮
- (IBAction)specialPracticeBtnClick:(id)sender
{
    BASpecialPracticeViewController *pageVC = [[BASpecialPracticeViewController alloc] init];
    pageVC.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark 难题攻克按钮
- (IBAction)overcomeBtnClick:(id)sender
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BAPageViewController_overcomeBtn";
    pageVC.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark 难题攻克按钮
- (IBAction)easyWrongSetBtnClick:(id)sender
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BAPageViewController_easyWrongSetBtn";
    pageVC.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

#pragma mark 模拟按钮
- (IBAction)simulationTestBtClick:(id)sender
{
    BASimulationTestViewController *simulationTestVC = [[BASimulationTestViewController alloc] init];
    simulationTestVC.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:simulationTestVC animated:YES];
}

#pragma mark 我的错题按钮
- (IBAction)myErrorBtnClick:(id)sender
{
    BAWrongTestViewController *wrongTestVC = [[BAWrongTestViewController alloc] init];
    wrongTestVC.hidesBottomBarWhenPushed = YES;

    [[self viewController].navigationController pushViewController:wrongTestVC animated:YES];
}

#pragma mark 我的收藏按钮
- (IBAction)myCollectionBtnClick:(id)sender
{
    BAMyCollectionViewController *myCollectionVC = [[BAMyCollectionViewController alloc] init];
    myCollectionVC.hidesBottomBarWhenPushed = YES;

    [[self viewController].navigationController pushViewController:myCollectionVC animated:YES];
}

#pragma mark 成绩排行按钮
- (IBAction)scoresRankBtnClick:(id)sender
{
    BAScoresRankingViewController *sorceRankVC = [[BAScoresRankingViewController alloc] init];
    sorceRankVC.hidesBottomBarWhenPushed = YES;

    [[self viewController].navigationController pushViewController:sorceRankVC animated:YES];
}

#pragma mark - 自定义控件
#pragma mark 自定义按钮
- (UIButton *)customButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
}

#pragma mark 自定义Label
- (UILabel *)customLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor
{
    UILabel *customLabel = [[UILabel alloc] init];
    customLabel.frame = frame;
    customLabel.text = text;
    customLabel.textColor = textColor;
    customLabel.textAlignment = NSTextAlignmentCenter;
    
    return customLabel;
}

#pragma mark 自定义横线
- (UIView *)customHViewWithFrame:(CGRect)frame
{
    UIView *HView = [[UIView alloc] init];
    HView.frame = frame;
    HView.backgroundColor = COLOR_C(224, 224, 224, 1.0);
    return HView;
}

#pragma mark - 接口


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
