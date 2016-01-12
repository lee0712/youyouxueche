//
//  BAPDCView.h
//  BAPDCViewTest
//
//  Created by 博爱之家 on 15/11/20.
//  Copyright © 2015年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selected)(NSIndexPath *indexPath, UITableView *tableView, UITableViewCell *cell);
typedef void(^seled)(selected);

@interface BAPDCView : UIView

@property (nonatomic, readonly, strong) UITableView *tableView;


/*----------------------------------------------
 *
 *  view just UIView and UIWindow,other return nil.
 *  size width > 60,<60 is 60. height > 30,<30 is 30
 **/


- (instancetype)initWithSize:(CGSize)size at:(id)view;

- (void)selected:(selected )seled;

@end
