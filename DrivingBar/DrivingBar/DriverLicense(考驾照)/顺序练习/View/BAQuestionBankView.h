//
//  BAQuestionBankView.h
//  优优学车
//
//  Created by boai on 15/12/12.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^selected)(NSIndexPath *indexPath, UICollectionView *collectionView, UICollectionViewCell *cell);
typedef void(^seled)(selected);

//
//@protocol BAQuestionBankViewDelegate <NSObject>
//@optional
//- (void)didSelectIndex:(NSInteger)index;
//@end
@interface BAQuestionBankView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, readonly, strong) UICollectionView *collectionView;
//@property(nonatomic,assign) id <BAQuestionBankViewDelegate> delegate;

@property (nonatomic, strong) NSArray *testDataArray;
/*----------------------------------------------
 *
 *  view just UIView and UIWindow,other return nil.
 *  size width > 60,<60 is 60. height > 30,<30 is 30
 **/

- (instancetype)initWithSize:(CGSize)size at:(id)view;

- (void)selected:(selected )seled;
//- (void)showInView:(UIViewController *)Sview;


@end
