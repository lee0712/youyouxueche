//
//  BAQuestionBankView.m
//  优优学车
//
//  Created by boai on 15/12/12.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BAQuestionBankView.h"
#import "BAUtilities.h"
#import "BAButton.h"

static NSString *reuseIdentifier = @"cell";
@interface BAQuestionBankView ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>
{
    // 分区View
    UIView *subViewOne;
    UIView *subViewTwo;
    UILabel *numberLabel;
}

@property (strong, readwrite, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) CGSize size;
@property (copy, nonatomic) selected selected;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation BAQuestionBankView

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
        
        CGRect questionBankViewFrame = CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64);
        self.layout= [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:questionBankViewFrame collectionViewLayout:self.layout];
        
//        [self animeData];
        [self setUplayout];
    }
    return self;
}

- (void)setUplayout
{
    //创建布局对象时，设置与布局有关的参数信息
    //配置参数
    //由于继承自flowLayout,所以才有以下属性，
    //如果继承自UICollectionViewLayout，则没有如下属性
    self.layout.minimumInteritemSpacing = 9; // item间距(最小值)
    self.layout.minimumLineSpacing = 9; // 行间距
    self.layout.sectionInset = UIEdgeInsetsMake(6, 6, 5, 5);//设置section的边距
    self.layout.itemSize = CGSizeMake(50, 50);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.layer.cornerRadius = 5.0f;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // headView
    // 正确
    CGRect rightLabelFrame = CGRectMake(20, 0, 60, 50);
    UILabel *rightLabel = [self customLabelWithFrame:rightLabelFrame text:[NSString stringWithFormat:@"对 %d", 2001]];
    rightLabel.textColor = [UIColor greenColor];
    
    // 错误
    CGRect wrongLabelFrame = CGRectMake(rightLabelFrame.origin.x + rightLabel.width + 5, 0, rightLabel.width, 50);
    UILabel *wrongLabel = [self customLabelWithFrame:wrongLabelFrame text:[NSString stringWithFormat:@"错 %d", 1111]];
    wrongLabel.textColor = [UIColor redColor];
    
    // 未答
    CGRect notAnswerLabelFrame = CGRectMake(wrongLabelFrame.origin.x + wrongLabel.width + 5, 0, rightLabel.width + 25, 50);
    UILabel *notAnswerLabel = [self customLabelWithFrame:notAnswerLabelFrame text:[NSString stringWithFormat:@"未答 %d", 9999]];
    notAnswerLabel.textColor = [UIColor lightGrayColor];
    
    // 清空按钮
    CGRect emptyBtnFrame = CGRectMake(KSCREEN_WIDTH - 70, 10, 60, 30);
    BAButton *emptyBtn = [[BAButton alloc] custonmButtonWithFrame:emptyBtnFrame title:@"清空按钮" state:UIControlStateNormal backgroundColor:[UIColor whiteColor]];
    emptyBtn.layer.borderWidth = 1.0;
    emptyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    emptyBtn.layer.borderColor = COLOR_C(78, 183, 249, 1.0).CGColor;
    [emptyBtn setTitleColor:COLOR_C(78, 183, 249, 1.0) forState:UIControlStateNormal];
    [emptyBtn addTarget:self action:@selector(emptyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 章节
    CGRect chapterLabelFrame = CGRectMake(0, 50, KSCREEN_WIDTH, 50);
    UILabel *chapterLabel = [self customLabelWithFrame:chapterLabelFrame text:[NSString stringWithFormat:@"    第%d章 %@", 2, @"道路交通安全法律、法规和规章"]];
    chapterLabel.backgroundColor = COLOR_C(233, 233, 233, 1.0);
    chapterLabel.textColor = [UIColor lightGrayColor];
    
    [self.collectionView addSubview:rightLabel];
    [self.collectionView addSubview:wrongLabel];
    [self.collectionView addSubview:notAnswerLabel];
    [self.collectionView addSubview:emptyBtn];
    [self.collectionView addSubview:chapterLabel];

    [self addSubview:self.collectionView];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.testDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UICollectionViewCell alloc] init];
    }
    else
    {
        while ([cell.contentView.subviews lastObject]!=nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    /**
     *  选项字母ABCD
     */
    numberLabel = [[UILabel alloc] init];
    numberLabel.frame = CGRectMake(0, 0, 50, 50);
    numberLabel.layer.cornerRadius = numberLabel.frame.size.width / 2;
    numberLabel.clipsToBounds = YES;
    numberLabel.layer.borderWidth = 1.0;
    numberLabel.layer.borderColor = COLOR_C(224, 224, 224, 1.0).CGColor;
    numberLabel.backgroundColor = [UIColor whiteColor];
    numberLabel.font = [UIFont systemFontOfSize:18];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = COLOR_C(117, 117, 117, 1.0);
    numberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    // cell点击变色
//    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
//    selectedBGView.backgroundColor = [UIColor greenColor];
//    cell.selectedBackgroundView = selectedBGView;
    
    
    [cell.contentView addSubview:numberLabel];
    
    return cell;
}

#pragma mark --UICollectionViewDelegate
//返回这个UICollectionView是否可以被选择

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您当前点击的是第%ld个按钮",(long)indexPath.row+1] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size= {KSCREEN_WIDTH,50*2};
    return size;
}


- (void)selected:(selected)seled
{
    self.selected = seled;
}

#pragma mark - 自定义控件
#pragma mark 自定义Label
- (UILabel *)customLabelWithFrame:(CGRect)frame text:(NSString *)text
{
    UILabel *customLabel = [[UILabel alloc] init];
    customLabel.frame = frame;
    customLabel.text = text;
    customLabel.font = [UIFont systemFontOfSize:15];
//    customLabel.textColor = [UIColor whiteColor];
    //    customLabel.textAlignment = NSTextAlignmentCenter;
    
    return customLabel;
}

#pragma mark 自定义按钮
- (UIButton *)customButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
}

#pragma mark - 按钮点击事件
- (IBAction)emptyBtnClick:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前点击的是清空记录按钮" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

// cell点击变色
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
// cell点击变色
//- (void)collectionView:(UICollectionView *)collectionView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([collectionView isEqual:self.collectionView])
//    {
//        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//        [numberLabel setBackgroundColor:[UIColor redColor]];
//    } else {
//        UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
//        [numberLabel setBackgroundColor:[UIColor blueColor]];
//    }
//}




@end
