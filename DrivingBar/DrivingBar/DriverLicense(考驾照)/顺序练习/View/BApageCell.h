//
//  BApageCell.h
//  博爱答题
//
//  Created by boai on 15/12/8.
//  Copyright © 2015年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BApageCell : UITableViewCell

/**
 *  选项字母ABCD
 */
@property (nonatomic, strong) UILabel *numberLabel;

/**
 *  内容
 */
@property (nonatomic, strong) UILabel *contentLabel;


//给问题赋值并且实现自动换行
//- (void)setIntroductionText:(NSString*)text;

@end
