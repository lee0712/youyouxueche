//
//  BASpecialPracticeView.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BASpecialPracticeView.h"
#import "BAUtilities.h"
#import "BASpecialPracticeViewCell.h"

#import "BACustomLable.h"
#import "BAPageViewController.h"

static NSString *reuseIdentifier = @"cell";
@interface BASpecialPracticeView ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>
{
    // 分区View
    UIView *subViewOne;
    UIView *subViewTwo;
    UILabel *_numberLabel;
}

@property (strong, readwrite, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) CGSize size;
@property (copy, nonatomic) selected selected;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation BASpecialPracticeView

- (NSArray *)specialPracticeDataArray
{
    if (!_specialPracticeDataArray)
    {
        _specialPracticeDataArray = @[@"时间题", @"距离题", @"罚款题", @"时间题", @"时间题", @"时间题", @"时间题", @"时间题", @"距离题", @"时间罚款题", @"时间罚款题", @"时间罚款题", @"时间罚款题", @"时间罚款题", @"时间罚款题", @"时间罚款题", @"时间罚款题"];
    }
    return _specialPracticeDataArray;
}

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
        
        CGRect questionBankViewFrame = CGRectMake(0, 10, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        self.layout= [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:questionBankViewFrame collectionViewLayout:self.layout];
        
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
    self.layout.minimumInteritemSpacing = 2; // item间距(最小值)
    self.layout.minimumLineSpacing = 2; // 行间距
    self.layout.sectionInset = UIEdgeInsetsMake(6, 6, 5, 5);//设置section的边距
    self.layout.itemSize = CGSizeMake(KSCREEN_WIDTH/2 - 1, 50);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = COLOR_C(239, 239, 239, 1.0);
    self.collectionView.layer.cornerRadius = 5.0f;
    [self.collectionView registerClass:[BASpecialPracticeViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.scrollEnabled = YES;
    
    [self addSubview:self.collectionView];
}


#pragma mark <UICollectionViewDataSource>
//section 的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.specialPracticeDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";

    BASpecialPracticeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[BASpecialPracticeViewCell alloc] init];
    }
    
    [cell sizeToFit];
    
    cell.backgroundColor = [UIColor whiteColor];
    for (NSUInteger i = 0; i< _specialPracticeDataArray.count; i++)
    {
        if (indexPath.row == i)
        {
            cell.testNumberLable.text = [NSString stringWithFormat:@"%lu", i+1];
            cell.classNameLabel.text = [NSString stringWithFormat:@"%@ [%lu]", _specialPracticeDataArray[i],i+1];
        }
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KSCREEN_WIDTH/2-1, 50);
}
//定义每个UICollectionView 的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0,0);
}

//定义每个UICollectionView 的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BAPageViewController *pageVC = [[BAPageViewController alloc] init];
    pageVC.testVCName = @"BASpecialPracticeView";
    [[self viewController].navigationController pushViewController:pageVC animated:YES];
}

- (void)selected:(selected)seled
{
    self.selected = seled;
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
