//
//  EAPToast.m
//  EAPController
//
//  Created by admin on 15/9/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "EAPToast.h"

@implementation EAPToast

-(id)initWithText:(NSString*)text_{
    if (self = [super init]) {
        text = [text_ copy];
        UIFont *font = [UIFont boldSystemFontOfSize:14];

        CGSize textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        UILabel *textLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width+12, textSize.height+6)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        contentView.layer.cornerRadius = 5.0f;
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        contentView.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.75f];
        [contentView addSubview:textLabel];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addTarget:self action:@selector(toastTaped) forControlEvents:UIControlEventTouchDown];
        contentView.alpha = 0.0f;
        duration = DEFAULT_DISPLAY_DURATION;
    }
    return self;
}

-(void)dismissToast {
    [contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender_{
    [self hideAnimation];
}

-(void)setDuration :(CGFloat)duration_{
    duration = duration_;
}

-(void)showAnimation {
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
    
}

-(void)hideAnimation {
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = window.center;
    [window addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}

-(void)showFromBottomOffset:(CGFloat) bottom_{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = CGPointMake(window.center.x, window.frame.size.height - (bottom_ + contentView.frame.size.height/2));
    [window addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}

+(void)showWithText:(NSString*)text_ {
    [EAPToast showWithText:text_ duration:DEFAULT_DISPLAY_DURATION];
}

+(void)showWithText:(NSString*)text_ duration:(CGFloat)duration_{
    EAPToast *toast = [[EAPToast alloc]initWithText:text_];
    [toast setDuration:duration_];
    [toast show];
}
+(void)showWithText:(NSString*)text_ bottomOffset:(CGFloat)bottomOffset_ {
    [EAPToast showWithText:text_ bottomOffset:bottomOffset_ duration:DEFAULT_DISPLAY_DURATION];
}
+(void)showWithText:(NSString*)text_ bottomOffset:(CGFloat)bottomOffset_ duration:(CGFloat)duration_{
    EAPToast *toast = [[EAPToast alloc]initWithText:text_];
    [toast setDuration:duration_];
    [toast showFromBottomOffset:bottomOffset_];
}

@end
