//
//  BASpecialPracticeViewController.m
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BASpecialPracticeViewController.h"
#import "BASpecialPracticeView.h"

@interface BASpecialPracticeViewController ()

@end

@implementation BASpecialPracticeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"专项练习";
    self.view.backgroundColor = [UIColor whiteColor];
    
    BASpecialPracticeView *specialPracticeView = [[BASpecialPracticeView alloc] initWithSize:self.view.frame.size at:self.view];
    
    [specialPracticeView selected:^(NSIndexPath *indexPath, UICollectionView *collectionView, UICollectionViewCell *cell){
        
    }];
}



@end
