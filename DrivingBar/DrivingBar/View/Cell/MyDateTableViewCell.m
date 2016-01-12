//
//  MyDateTableViewCell.m
//  DrivingBar
//
//  Created by admin on 15/12/3.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "MyDateTableViewCell.h"
#import "public.h"

@implementation MyDateTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = CGRectMake(0,0,screen_width,40);
    if (self) {
        //name
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, screen_width*1/3-10, 30)];
        self.nameLabel.textColor=[UIColor blackColor];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];
        
        //预约
        self.yuyueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.nameLabel.frame.size.height+self.nameLabel.frame.origin.y+10, screen_width/4 -10, 20)];
        self.yuyueLabel.textColor=[UIColor grayColor];
        self.yuyueLabel.text = @"预约时间";
        self.yuyueLabel.textAlignment = NSTextAlignmentLeft;
        self.yuyueLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.yuyueLabel];
        
        //时间
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.yuyueLabel.frame.size.width+20, self.yuyueLabel.frame.origin.y, screen_width*3/4 -10, 20)];
        self.dateLabel.textColor=[UIColor blackColor];
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
          self.dateLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.dateLabel];
        
        //预约进度
        self.jinduLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width*4/5, 10, screen_width/4, 30)];
        self.jinduLabel.textColor=[UIColor redColor];
        self.jinduLabel.textAlignment = NSTextAlignmentLeft;
        self.jinduLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.jinduLabel];
        
        //评价
        self.pingjiaButton = [[UIButton alloc] initWithFrame:CGRectMake(self.jinduLabel.frame.origin.x, self.dateLabel.frame.origin.y+self.dateLabel.frame.size.height+10, 50, 25)];
        [self.pingjiaButton.layer setCornerRadius:5.0f];
        [self.pingjiaButton.layer setBorderWidth:1.0];
        [self.pingjiaButton.layer setBorderColor:[UIColor redColor].CGColor];
        
        [self.pingjiaButton setTitle:@"评价" forState:UIControlStateNormal];
        [self.pingjiaButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.pingjiaButton.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self.contentView addSubview:self.pingjiaButton];
        
        //line
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 112, screen_width, 8)];
        lineView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
        [self.contentView addSubview:lineView];
    }
    return self;
}

-(void)addPingjiaLabel{
    if (!self.pingjiaButton.superview) {
        [self.contentView addSubview:self.pingjiaButton];
    }
}
-(void)deletePingjiaLabel{
    if (self.pingjiaButton.superview) {
        [self.pingjiaButton removeFromSuperview];
    }
}
@end
