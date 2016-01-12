//
//  BAPageViewController.h
//  博爱答题
//
//  Created by boai on 15/12/8.
//  Copyright © 2015年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAScrollPageViewController.h"

@interface BAPageViewController : UIViewController
<
    UIPageViewControllerDataSource,
    UIPageViewControllerDelegate,
    BAScrollPageViewControllerDelegate
>

@property (strong, nonatomic) UIPageViewController *pageController;
// 内容数组
@property (strong, nonatomic) NSMutableArray *pageContentArrayM;
// 问题文字数组
@property (strong, nonatomic) NSMutableArray *testContentArrayM;
// 问题图片数组
@property (strong, nonatomic) NSArray *testImageArray;

@property (nonatomic, strong) NSString *testVCName;


- (BAScrollPageViewController *)viewControllerAtIndex:(NSUInteger)index;


@end
