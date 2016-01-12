//
//  BAWrongTestViewController.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BAWrongTestViewController.h"
#import "BAUtilities.h"
#import "BAButton.h"
#import "BAWrongTestView.h"

@interface BAWrongTestViewController ()

@end

@implementation BAWrongTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的错题";
    self.view.backgroundColor = COLOR_C(245, 245, 245, 1.0);
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(removeButtonClick:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    BAWrongTestView *wrongTestView = [[BAWrongTestView alloc] initWithSize:self.view.frame.size at:self.view];
    wrongTestView.vcName = @"BAWrongTestViewController";
    [wrongTestView selected:^(NSIndexPath *indexPath, UITableView *tableView, UITableViewCell *cell) {
        
    }];
}

- (IBAction)removeButtonClick:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您当前点击的是【我的错题】清空按钮"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


@end
