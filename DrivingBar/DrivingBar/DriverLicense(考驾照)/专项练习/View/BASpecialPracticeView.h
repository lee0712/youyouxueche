//
//  BASpecialPracticeView.h
//  优优学车
//
//  Created by boai on 15/12/16.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selected)(NSIndexPath *indexPath, UICollectionView *collectionView, UICollectionViewCell *cell);
typedef void(^seled)(selected);


@interface BASpecialPracticeView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, readonly, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *specialPracticeDataArray;

/*----------------------------------------------
 *
 *  view just UIView and UIWindow,other return nil.
 *  size width > 60,<60 is 60. height > 30,<30 is 30
 **/

- (instancetype)initWithSize:(CGSize)size at:(id)view;

- (void)selected:(selected )seled;

@end
