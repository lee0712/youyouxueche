//
//  BAWrongTestView.h
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selected)(NSIndexPath *indexPath, UITableView *tableView, UITableViewCell *cell);
typedef void(^seled)(selected);

@interface BAWrongTestView : UIView

@property (nonatomic, readonly, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *vcName;


/*----------------------------------------------
 *
 *  view just UIView and UIWindow,other return nil.
 *  size width > 60,<60 is 60. height > 30,<30 is 30
 **/


- (instancetype)initWithSize:(CGSize)size at:(id)view;

- (void)selected:(selected )seled;

@end
