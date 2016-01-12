//
//  MenuTableViewCell.m
//  DrivingBar
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//
#import "public.h"
#import "MenuTableViewCell.h"

@implementation MenuTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = CGRectMake(0,0,screen_width,40);
    if (self) {
        //name
        self.menuIm = [[UIImageView alloc] initWithFrame:CGRectMake(18, 15, 20, 20)];
 
        [self.contentView addSubview:self.menuIm];
        
        //预约
        self.menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.menuIm.frame.origin.x+self.menuIm.frame.size.width+34, self.menuIm.frame.origin.y, screen_width/2, 20)];
        self.menuLabel.textColor=[UIColor grayColor];
 
        self.menuLabel.font = [UIFont systemFontOfSize:14];
       [self.contentView addSubview:self.menuLabel];
    }
    return self;
}

@end
