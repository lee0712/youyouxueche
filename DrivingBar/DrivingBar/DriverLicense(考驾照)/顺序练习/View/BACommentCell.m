//
//  BACommentCell.m
//  优优学车
//
//  Created by boai on 15/12/15.
//  Copyright © 2015年 粤嵌股份公司. All rights reserved.
//

#import "BACommentCell.h"
#import "BAUtilities.h"

@implementation BACommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initWithSubViews];
//        [self initLayout];
    }
    return self;
}

- (void)initWithSubViews
{
    // 用户图像
    _userImageView = [[UIImageView alloc] init];
    _userImageView.frame = CGRectMake(10, 5, 40, 40);
    _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
    _userImageView.clipsToBounds = YES;
    _userImageView.layer.borderWidth = 3.0f;
    _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _userImageView.backgroundColor = [UIColor clearColor];
    
    // 用户名
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.frame = CGRectMake(55, 12, KSCREEN_WIDTH - 40 - 10 - 5, 20);
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.textColor = [UIColor lightGrayColor];
    
    // 评论内容
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = [UIFont systemFontOfSize:16];
    _commentLabel.numberOfLines = 0;
//    [self setIntroductionText:self.commentLabel.text];
//    CGFloat contentX = CGRectGetMaxX(self.userNameLabel.frame);
//    CGSize contentSize = [self sizeWithString:_commentLabel.text font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(KSCREEN_WIDTH - 40, MAXFLOAT)];
//    CGFloat contentY = CGRectGetMaxY(self.userNameLabel.frame) + 10;
//    CGFloat contentW = contentSize.width + 10;
//    CGFloat contentH = contentSize.height;
    _commentLabel.frame = CGRectMake(55, 40, KSCREEN_WIDTH - 55 - 20, 40);
    
    // 回复评论内容
//    _reCommentLabel = [[UILabel alloc] init];
    
    // 评论时间
    _commentTimeLabel = [[UILabel alloc] init];
    _commentTimeLabel.frame = CGRectMake(55, CGRectGetMaxY(self.commentLabel.frame) + self.commentLabel.height + 5, 150, 20);
    _commentTimeLabel.font = [UIFont systemFontOfSize:12];
    _commentTimeLabel.textColor = [UIColor lightGrayColor];
    
    // 回复按钮
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.frame = CGRectMake(KSCREEN_WIDTH - 40 - 10, CGRectGetMaxY(self.commentLabel.frame) + self.commentLabel.height + 5, 40, 20);
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 回复图片
    _commentImageView = [[UIImageView alloc] init];
    _commentImageView.frame = CGRectMake(KSCREEN_WIDTH - 40 - 10 - 20, CGRectGetMaxY(self.commentLabel.frame) + self.commentLabel.height + 5, 20, 20);
    
//    // 横线
//    _hView = [[UIView alloc] init];
//    _hView.frame = CGRectMake(CGRectGetMaxX(self.userNameLabel.frame), CGRectGetMaxY(self.commentTimeLabel.frame) + self.commentTimeLabel.height + 5, KSCREEN_WIDTH - 55, 1);
//    _hView.backgroundColor = COLOR_C(240, 240, 240, 1.0);
    
    [self.contentView addSubview:_userImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_commentLabel];
    [self.contentView addSubview:_commentTimeLabel];
    [self.contentView addSubview:_commentImageView];
    [self.contentView addSubview:_commentButton];
//    [self.contentView addSubview:_hView];
}

//- (void)initLayout
//{
//    for (UIView *view in [self.contentView subviews])
//    {
//        view.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    
//    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_userImageView, _userNameLabel, _commentLabel, _commentTimeLabel, _commentImageView, _commentButton, _hView);
//    
//    // 用户图像
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_userImageView(40)]" options:0 metrics:nil views:viewDict]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_userImageView(40)]" options:0 metrics:nil views:viewDict]];
//    
//    // 用户名
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-5-[_userNameLabel(200)]" options:0 metrics:nil views:viewDict]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_userNameLabel(20)]" options:0 metrics:nil views:viewDict]];
//    
//    // 评论内容
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-5-[_commentLabel]-10-|" options:0 metrics:nil views:viewDict]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_userNameLabel]-10-[_commentLabel(20)]" options:0 metrics:nil views:viewDict]];
//    
//    // 评论时间
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-5-[_commentTimeLabel(150)]" options:0 metrics:nil views:viewDict]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_commentLabel]-7-[_commentTimeLabel(20)]" options:0 metrics:nil views:viewDict]];
//    
//    // 回复按钮
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_commentButton(40)]-10-|" options:0 metrics:nil views:viewDict]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_commentLabel]-7-[_commentButton(20)]" options:0 metrics:nil views:viewDict]];
//    
//    // 回复图片
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_commentImageView(20)]-0-[_commentButton]" options:0 metrics:nil views:viewDict]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_commentLabel]-7-[_commentImageView(20)]" options:0 metrics:nil views:viewDict]];
//    
//    // 横线
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-5-[_hView]-20-|" options:0 metrics:nil views:viewDict]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_commentButton]-5-[_hView(1)]" options:0 metrics:nil views:viewDict]];
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//赋值 and 自动换行,计算出cell的高度
- (void)setIntroductionText:(NSString*)text
{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.commentLabel.text = text;
    //设置label的最大行数
    self.commentLabel.numberOfLines = 10;
    // 自动适应行高
    CGSize size = CGSizeMake(KSCREEN_WIDTH - 55 - 20, MAXFLOAT);
    CGSize labelsize =[self.commentLabel.text boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    self.commentLabel.frame = CGRectMake(self.commentLabel.frame.origin.x, self.commentLabel.frame.origin.y, labelsize.width, labelsize.height);
    
    //计算出自适应的高度
    frame.size.height = labelsize.height+100;
    
    self.frame = frame;
}

//- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
//{
//    NSDictionary *dict = @{NSFontAttributeName : font};
//    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
//    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
//    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
//    return size;
//}

@end
