//
//  BAScrollPageViewController.m
//  博爱答题
//
//  Created by boai on 15/12/8.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BAScrollPageViewController.h"
#import "BApageCell.h"
#import "BAUtilities.h"
#import "BAPageViewController.h"

#import "BAPageViewController.h"
#import "BACustomLable.h"
#import "BAButton.h"

#import "BACommentModel.h"
#import "BACommentCell.h"
#import "UIView+Single.h"
#import "UIButton+Single.h"
#import "UITextField+Single.h"

@interface BAScrollPageViewController ()

{
    // 解释分区
    UIView *subViewTwo;
    // 评论分区
    UIView *subViewThree;
    UIView *subViewFour;
    
    // 问题
    UIView *subViewOne;
    CGRect subViewOneFrame;
    // 答案
    CGRect contentLabelFrame;
    
    // 错误分区
    int sections;
    NSIndexPath *selectIndexPath;
    //正确答案所在位置
    NSIndexPath *trueIndexPath;
    
    // 高度
    CGFloat cellHeight;
}
@property (nonatomic, strong) NSMutableArray *dataTwoMArray;
@property (nonatomic, strong) NSMutableArray *dataOneMArray;

//评论view
@property (nonatomic,strong)UIView *commentView;
@property (nonatomic,strong)UIView *replyConmmentView;
//评论文本框
@property (nonatomic,strong)UITextField *commentTextFeild;
@property (nonatomic,strong)UITextField *replyCommentTextFeild;
//评论发送按钮
@property (nonatomic,strong)UIButton *commentBtn;
@property (nonatomic,strong)UIButton *replyCommentBtn;
//键盘弹起高度
@property (nonatomic,assign)CGRect frameOfKeyboard;


@end

@implementation BAScrollPageViewController


#pragma mark - 搭建ui界面

- (NSMutableArray *)dataTwoMArray
{
    if (!_dataTwoMArray)
    {
        _dataTwoMArray = [NSMutableArray array];
//        [_dataTwoMArray addObject:@""];
    }
    return _dataTwoMArray;
}

- (NSMutableArray *)dataOneMArray
{
    if (!_dataOneMArray)
    {
        _dataOneMArray = [NSMutableArray array];
        _dataOneMArray = [[BACommentModel demoData] mutableCopy];
    }
    return _dataOneMArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(reloadTitleWithPage:)])
        {
            [self.delegate reloadTitleWithPage:self.pageIndex];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    selectIndexPath = nil;
    trueIndexPath = nil;
}

- (void)createUI
{
    // 问题
    sections = 1;

    self.tableView = [[UITableView alloc] init];
    self.tableView.frame =  CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = COLOR_C(239, 239, 239, 1.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.tableView];
    
    // 问题分区
    subViewOneFrame = CGRectMake(0, 0, KSCREEN_WIDTH, 100);
    subViewOne = [[UIView alloc] initWithFrame:subViewOneFrame];
    subViewOne.backgroundColor = [UIColor whiteColor];
    
    // 问题
    [self setUpSubViewOne];
}

#pragma mark - tableView 的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }
    if (section == 1)
    {
        return 1;
    }
    if (section == 2)
    {
        return 1;
    }
    if (section == 3)
    {
        return self.dataOneMArray.count;
    }
    
    return 1;
}

#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        BApageCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.contentLabel.height>50 ? cell.contentLabel.height:50;
    }
    if (indexPath.section == 1)
    {
        return subViewTwo.height;
    }
    if (indexPath.section == 2)
    {
        return 40;
    }
    if (indexPath.section == 3)
    {
        BACommentCell *comentCell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return comentCell.frame.size.height;
//        return 92; // 5即消息上下的空间，可自由调整
    }

    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 3)
    {
        return 0;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"cell";
    BApageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell)
    {
        cell = [[BApageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    
    if (indexPath.section == 0)
    {
        //对已经选中的和正确答案的cell保持不变，除此外重新赋值
        if (selectIndexPath!=nil)
        {
            if(indexPath==selectIndexPath)
            {
                //错误
                cell.numberLabel.text = @"x";
                cell.numberLabel.backgroundColor = [UIColor redColor];
                cell.contentLabel.textColor = [UIColor redColor];
            }
            else
            {
                cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+(indexPath.row))];
            }
            
            if (indexPath==trueIndexPath)
            {
                //正确
                cell.numberLabel.backgroundColor = [UIColor greenColor];
                cell.numberLabel.text = @"√";
                cell.numberLabel.textColor = [UIColor whiteColor];
                cell.contentLabel.textColor = [UIColor greenColor];
            }
            
        }else{
            
            cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+(indexPath.row))];
        }
        //        cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+(indexPath.row))];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentLabel.text = [NSString stringWithFormat:@"第%ld行内容", (long)indexPath.row + 1];
        cell.contentLabel.numberOfLines = 0;
        
        //获取正确选项cell所在位置
        if ([cell.numberLabel.text isEqualToString:@"D"])
        {
            trueIndexPath = indexPath;
        }
        
        //设置颜色
        if (indexPath.row%2 == 0)
        {
            cell.backgroundColor = COLOR_C(245, 245, 245, 1.0);
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        return cell;
    }
    if (indexPath.section == 1)
    {
        cell.numberLabel.hidden = YES;
        cell.contentLabel.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 解释分区
        CGRect subViewTwoFrame = CGRectMake(0, 0, KSCREEN_WIDTH, 100);
        subViewTwo = [[UIView alloc] initWithFrame:subViewTwoFrame];
        subViewTwo.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:subViewTwo];
        
        // 弹出最佳解释 和 评论
        [self setUpWrongView];
        
        return cell;
    }
    if (indexPath.section == 2)
    {
        cell.numberLabel.hidden = YES;
        cell.contentLabel.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 解释分区
        CGRect subViewThreeFrame = CGRectMake(0, 0, KSCREEN_WIDTH, 40);
        subViewThree = [[UIView alloc] initWithFrame:subViewThreeFrame];
        subViewThree.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:subViewThree];
        
        // 弹出评论
        [self setUpSubViewThree];
        
        return cell;
    }
    if (indexPath.section == 3)
    {
        static NSString *reuse = @"myCell";
        BACommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!commentCell)
        {
            commentCell = [[BACommentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
        }
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置tableViewCell间的分割线的颜色
        [self.tableView setSeparatorColor:[UIColor greenColor]];
        
        BACommentModel *commentModel = self.dataOneMArray[indexPath.row];
        commentCell.userNameLabel.text = commentModel.userNameStr;
        commentCell.userImageView.image = [UIImage circleImageWithName:commentModel.userImageNameStr borderWidth:1.0 borderColor:[UIColor whiteColor]];
//        commentCell.commentLabel.text = commentModel.commentStr;
        commentCell.commentTimeLabel.text = commentModel.commentTimeStr;
        [commentCell setIntroductionText:commentModel.commentStr];
        
        // 回复按钮
        [commentCell.commentButton setTitle:@"回复" forState:UIControlStateNormal];
        [commentCell.commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [commentCell.commentButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        commentCell.commentButton.tag = 100 + indexPath.row;
        
        // 回复图片
        commentCell.commentImageView.image = [UIImage circleImageWithName:commentModel.commentImageStr borderWidth:1.0 borderColor:[UIColor whiteColor]];

        // 横线
        UIView *hView = [[UIView alloc] init];
        hView.frame = CGRectMake(55, commentCell.height-1, KSCREEN_WIDTH - 55, 1);
        hView.backgroundColor = COLOR_C(240, 240, 240, 1.0);
        
        [commentCell.contentView addSubview:hView];
//
//        // 用户图像
//        commentCell.userNameLabel.text = @"boai";
//        commentCell.userImageView.image = [UIImage circleImageWithName:@"tea" borderWidth:1.0 borderColor:[UIColor whiteColor]];
//        
//        // 用户名
//        commentCell.userNameLabel.text = @"博爱";
//        
//        // 评论内容
//        commentCell.commentLabel.text = [self.dataOneMArray objectAtIndex:indexPath.row];
//        
//        // 自动适应行高
////        CGSize size = CGSizeMake(KSCREEN_WIDTH - 40, MAXFLOAT);
////        CGSize labelsize =[commentCell.commentLabel.text boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
////        CGRect commentTimeLabelFrame = CGRectMake(20,0, labelsize.width, labelsize.height);
////        commentCell.commentTimeLabel.frame = commentTimeLabelFrame;
////        commentCell.commentTimeLabel.numberOfLines = 0;
////        [commentCell setIntroductionText:[self.dataOneMArray objectAtIndex:indexPath.row]];
//
//        // 回复评论内容
//        //    _reCommentLabel = [[UILabel alloc] init];
//        
//        // 评论时间
//        commentCell.commentTimeLabel.text = [self getCurrentDateAndTime];
//        
//        // 回复按钮
//        [commentCell.commentButton setTitle:@"回复" forState:UIControlStateNormal];
//        [commentCell.commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        [commentCell.commentButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        commentCell.commentButton.tag = 100 + indexPath.row;
//        
//        // 回复图片
//        commentCell.commentImageView.image = [UIImage circleImageWithName:@"pinglun" borderWidth:1.0 borderColor:[UIColor whiteColor]];
//        
////        cellHeight = commentCell.userNameLabel.frame.origin.y + commentCell.userNameLabel.height + commentCell.commentLabel.height + commentCell.commentTimeLabel.height ;
        
        return commentCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 需求：点击ABC选项为错误选项，只能点击一次，点击错误选项后，该错误选项为字体变为红色，同时D选项变为绿色，同时多出一个分区。。。
    // 弹出错误View
    // 保存选中的
    
    if (selectIndexPath)
    {
        //正确
        BApageCell *cell = [self.tableView cellForRowAtIndexPath:selectIndexPath];
        return;
    }
    
    selectIndexPath = indexPath;
    
    if (indexPath!=trueIndexPath)
    {
        sections = 4;
        [self.tableView reloadData];
    }
    else
    {
        //正确
        BApageCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.numberLabel.backgroundColor = [UIColor greenColor];
        cell.numberLabel.text = @"√";
        cell.numberLabel.textColor = [UIColor whiteColor];
        cell.contentLabel.textColor = [UIColor greenColor];
    }
}

#pragma mark - 自定义分区
#pragma mark 分区一 问题
- (void)setUpSubViewOne
{
    // 问题
    BACustomLable *testLabel = [[BACustomLable alloc] init];
    testLabel.text = self.testContenDetailStr;

    // 自动适应行高
    CGSize size = CGSizeMake(KSCREEN_WIDTH - 40, MAXFLOAT);
    CGSize labelsize =[testLabel.text boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGRect testLabelFrame = CGRectMake(20,0, labelsize.width, labelsize.height);
    [testLabel adjustsFontSizeToFitWidth];
    [testLabel custonmLabelWithFrame:testLabelFrame text:testLabel.text textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft];
    testLabel.numberOfLines = 0;
    
    // 判断问题中有没有图片，改变frame
    UIImageView *testImageView = [[UIImageView alloc] init];
    testImageView.frame = CGRectMake(0, testLabel.frame.origin.y + testLabel.height + 5, KSCREEN_WIDTH, 150);
    testImageView.image = [UIImage imageNamed:self.testImageNameStr];
    testImageView.contentMode = UIViewContentModeScaleAspectFit;
    testImageView.layer.cornerRadius = 5.0;
    if (!testImageView.image || testImageView.image == nil)
    {
        testImageView.height = 0;
    }
    
    // tableView的tableHeaderView 自动适应高度
    [subViewOne sizeToFit];
    CGRect newFrame = subViewOne.frame;
    newFrame.size.height = newFrame.size.height + subViewOne.frame.size.height;
    subViewOne.frame = newFrame;
    subViewOne.height = testImageView.frame.origin.y + testImageView.height + 5;
    
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:subViewOne];
    [self.tableView endUpdates];
    
    [subViewOne addSubview:testLabel];
    [subViewOne addSubview:testImageView];
}

#pragma mark 弹出最佳解释分区
- (void)setUpWrongView
{
    // 最佳解释
    CGRect bestExplanationLabelFrame = CGRectMake(20, 0, 80, 40);
    BACustomLable *bestExplanationLabel = [[BACustomLable alloc] custonmLabelWithFrame:bestExplanationLabelFrame text:@"最佳解释：" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
    
    // 难度
    
    // 解释内容
    BACustomLable *contentExplanationLabel = [[BACustomLable alloc] init];
    contentExplanationLabel.text = self.testContenDetailStr;
    // 自动适应行高
    CGSize size = CGSizeMake(KSCREEN_WIDTH - 40, 2000);
    CGSize labelsize = [contentExplanationLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGRect contentExplanationLabelFrame = CGRectMake(20,40, labelsize.width, labelsize.height);
    [contentExplanationLabel custonmLabelWithFrame:contentExplanationLabelFrame text:contentExplanationLabel.text textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
    contentExplanationLabel.numberOfLines = 0;

    subViewTwo.height = contentExplanationLabel.height + bestExplanationLabel.height + 5;
    
    [subViewTwo addSubview:bestExplanationLabel];
    [subViewTwo addSubview:contentExplanationLabel];
}

#pragma mark 弹出评论分区
- (void)setUpSubViewThree
{
    // 考友分析
    CGRect analyseTestLabelFrame = CGRectMake(20, 0, 80, 40);
    BACustomLable *analyseTestLabel = [[BACustomLable alloc] custonmLabelWithFrame:analyseTestLabelFrame text:@"考友分析：" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft];
    
    // 我来分析按钮
    CGRect analyseTestBtnFrame = CGRectMake(KSCREEN_WIDTH - 80, 5, 60, 30);
    BAButton *analyseTestBtn = [[BAButton alloc] custonmButtonWithFrame:analyseTestBtnFrame title:@"我来分析" state:UIControlStateNormal backgroundColor:[UIColor whiteColor]];
    analyseTestBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    analyseTestBtn.layer.borderWidth = 1.0;
    analyseTestBtn.tag = self.pageIndex;
    analyseTestBtn.layer.borderColor = COLOR_C(78, 183, 249, 1.0).CGColor;
    [analyseTestBtn setTitleColor:COLOR_C(78, 183, 249, 1.0) forState:UIControlStateNormal];
    [analyseTestBtn addTarget:self action:@selector(analyseTestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [subViewThree addSubview:analyseTestLabel];
    [subViewThree addSubview:analyseTestBtn];
}

#pragma mark - 按钮点击事件
#pragma mark 我来分析按钮
- (IBAction)analyseTestBtnClick:(UIButton *)sender
{
    _commentView = [UIView defaultManager];
    _commentTextFeild = [UITextField defaultManager];
    _commentBtn = [UIButton defaultManager];
    //设置文本框为第一响应者
    //自动弹出键盘
    [_commentTextFeild becomeFirstResponder];
    _commentTextFeild.layer.borderWidth = 1;
    _commentTextFeild.layer.borderColor = [COLOR_C(240, 240, 240, 1.0) CGColor];
    _commentTextFeild.layer.cornerRadius = 15.0;
    [_commentTextFeild addTarget:self action:@selector(replyReturn) forControlEvents:UIControlEventEditingDidEndOnExit];
    //"发送"按钮
    _commentBtn.tag = sender.tag;
    [_commentBtn addTarget:self action:@selector(sendMessageTo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_commentView];
    [_commentView addSubview:_commentTextFeild];
    [_commentView addSubview:_commentBtn];
}

#pragma mark - textField Delegate
#pragma mark 键盘操作
//键盘弹起时
-(void)openKeyboard:(NSNotification *)notification{
    //1.获取键盘的左顶点
    _frameOfKeyboard = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"frameOfKeyboard:%@",NSStringFromCGRect(_frameOfKeyboard));
    NSLog(@"frameOfKeyboard.height:%f",_frameOfKeyboard.size.height);
    
    //2.计算输入框视图的坐标信息
    CGRect frameOfInputTextView = self.commentView.frame;
    CGRect replyComentOfInputTextView = self.replyConmmentView.frame;
    
    frameOfInputTextView.origin.y = KSCREEN_HEIGHT - frameOfInputTextView.size.height - _frameOfKeyboard.size.height - 64;
    replyComentOfInputTextView.origin.y = KSCREEN_HEIGHT - replyComentOfInputTextView.size.height - _frameOfKeyboard.size.height - 64;
    NSLog(@"frameOfInputTextView.height:%f",self.commentView.frame.size.height);
    NSLog(@"replyComentOfInputTextView.height:%f",self.replyConmmentView.frame.size.height);
    //3.添加动画
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        //设置动画结束时 输入视图的位置
        self.commentView.frame = frameOfInputTextView;
        self.replyConmmentView.frame = replyComentOfInputTextView;
    } completion:nil];
    
}

//键盘收起时
- (void)closeKeyboard:(NSNotification *)notification{
    CGRect frameOfInputTextView = self.commentView.frame;
    CGRect replyCommentViewInputTextView = self.replyConmmentView.frame;
    frameOfInputTextView.origin.y = KSCREEN_HEIGHT - frameOfInputTextView.size.height ;
    replyCommentViewInputTextView.origin.y = KSCREEN_HEIGHT - replyCommentViewInputTextView.size.height ;
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.commentView.frame = frameOfInputTextView;
        self.replyConmmentView.frame = replyCommentViewInputTextView;
    } completion:nil];
}

//发送请求，添加评论到后台
-(IBAction)sendMessageTo:(UIButton *)sender
{
    NSLog(@"sender.tag :%ld",sender.tag);
    [self.dataOneMArray addObject:self.commentTextFeild.text];
//    self.dataOneMArray = [[self.dataOneMArray reverseObjectEnumerator] allObjects];
//
//    //一个section刷新
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
//    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
//
//    NSLog(@"评论内容：%@",self.dataOneMArray);
    
    [[[UIAlertView alloc] initWithTitle:nil message:@"暂时未开通此功能！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];

    
      //清空文本框
    self.commentTextFeild.text = @"";
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _commentView.frame;
        frame.origin.y = KSCREEN_HEIGHT + 54;
        _commentView.frame = frame;
    }];
    [_commentTextFeild resignFirstResponder];
}

-(void)replyReturn
{
    [self.replyCommentTextFeild resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _commentView.frame;
        frame.origin.y = KSCREEN_HEIGHT;
        _commentView.frame = frame;
    }];
    [self.view resignFirstResponder];
}

//点击return
-(void)addreturn
{
    [self.commentTextFeild resignFirstResponder];
}

#pragma mark 回复别人的评论按钮
- (IBAction)commentButtonClick:(UIButton *)sender
{
    NSInteger row = [self.tableView indexPathForCell:((BACommentCell*)[[sender superview]superview])].row;
    NSLog(@"MyRow:%ld",row);
    
//    BACommentCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:[self.tableView indexPathForCell:((BACommentCell*)[[sender superview]superview])]];

    //    self.sender_tag = sender.tag;
    _replyConmmentView = [UIView replyView];
    _replyCommentTextFeild = [UITextField replyTextField];
    _replyCommentBtn = [UIButton replyDefalutButton];
    //设置文本框为第一响应者
    //自动弹出键盘
    [_replyCommentTextFeild becomeFirstResponder];
    _replyCommentTextFeild.layer.borderWidth = 1;
    _replyCommentTextFeild.layer.borderColor = [COLOR_C(240, 240, 240, 1.0) CGColor];
    _replyCommentTextFeild.layer.cornerRadius = 3;
    _replyCommentTextFeild.placeholder = [NSString stringWithFormat:@"回复 %@：",@"博爱"];
    [_replyCommentTextFeild addTarget:self action:@selector(replyReturn) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //"发送"按钮
    _replyCommentBtn.tag = row;
    [_replyCommentBtn addTarget:self action:@selector(addMessageTo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_replyConmmentView];
    [_replyConmmentView addSubview:_replyCommentTextFeild];
    [_replyConmmentView addSubview:_replyCommentBtn];
}

-(IBAction)addMessageTo:(UIButton *)sender
{
    if(![_replyCommentTextFeild.text isEqualToString:@""])
    {
        [self.dataOneMArray addObject:self.replyCommentTextFeild.text];
//        self.dataOneMArray = [[self.dataOneMArray reverseObjectEnumerator] allObjects];
//        
//        //一个section刷新
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
//        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
        
//        NSLog(@"评论内容：%@",self.dataOneMArray);
        [[[UIAlertView alloc] initWithTitle:nil message:@"暂时未开通此功能！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    //清空文本框
    self.replyCommentTextFeild.text = @"";
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _replyConmmentView.frame;
        frame.origin.y = KSCREEN_HEIGHT;
        _replyConmmentView.frame = frame;
    }];
    [_replyCommentTextFeild resignFirstResponder];
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

@end
