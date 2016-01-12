//
//  BAScrollPageViewController.h
//  博爱答题
//
//  Created by boai on 15/12/8.
//  Copyright © 2015年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BAScrollPageViewControllerDelegate <NSObject>
@required
-(void)reloadTitleWithPage:(NSInteger)pageNumber;

@end

@interface BAScrollPageViewController : UIViewController
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageIndex;
// 问题文字
@property (nonatomic, strong) NSString *testContenDetailStr;
// 问题图片
@property (nonatomic, strong) NSString *testImageNameStr;



// 题目
//@property (nonatomic, strong) NSArray *testDataArray;

@property (nonatomic,weak) id<BAScrollPageViewControllerDelegate> delegate;


@end
