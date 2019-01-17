//
//  TWTweetCell.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWTweetCell.h"
#import "TWCommentGroundView.h"
#import "UIImageView+TWWebCache.h"
#import "TWMacros.h"
#import "TWCommentModel.h"
@interface TWTweetCell(){

    CGFloat groundWidth;
    CGFloat imageWidth;
    CGFloat spaceWidth;
}

@property (nonatomic,strong) TWTweetModel *tweet;

@property (nonatomic,strong) UIImageView *avatarImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *imageGround;

@property (nonatomic,strong) TWCommentGroundView *commentView;

@end

@implementation TWTweetCell

- (TWCommentGroundView *)commentView{
    if (!_commentView) {
        _commentView = [[TWCommentGroundView alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.imageGround.frame) + 10, Screen_Width - 60 - 30, 0)];
    }
    return _commentView;
}

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
        _avatarImage.image = [UIImage imageNamed:@"default"];
        _avatarImage.backgroundColor = [UIColor lightGrayColor];
    }
    return _avatarImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, Screen_Width - 60 - 30, 18)];
        _nameLabel.textColor = UIColorFromHex(0x616887);
        _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];

    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.nameLabel.frame)+10, Screen_Width - 60 - 30, 0)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)imageGround{
    if (!_imageGround) {
        _imageGround = [[UIView alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.contentLabel.frame)+10, Screen_Width - 60 - 30, 0)];//100
        _imageGround.backgroundColor = [UIColor whiteColor];
    }
    return _imageGround;
}




#pragma mark -----------------------------------

+ (TWTweetCell *)cellWithTableView:(UITableView *)tableView{

    TWTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[TWTweetCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)init{

    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.avatarImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.imageGround];
        [self addSubview:self.commentView];

        [self initData];

        self.cellHeight = 180;
    }
    return self;
}

- (void)refreshCellWithModel:(TWTweetModel *)model{

    self.tweet = model;
     // 请注意打开VPN否则图片大概率加载超时
    [self.avatarImage tw_setImageWithURL:model.sender.avatar placeHolder:nil completion:nil];
    self.nameLabel.text = model.sender.nick;
    self.cellHeight = CGRectGetMaxY(self.avatarImage.frame);

    if (model.content) {
        CGFloat contentHeight = [self setLabel:self.contentLabel font:15 width:CGRectGetWidth(self.contentLabel.frame) string:model.content];
        self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.contentLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + 10, CGRectGetWidth(self.contentLabel.frame), contentHeight);
    }else{
        self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.contentLabel.frame), CGRectGetMaxY(self.nameLabel.frame), CGRectGetWidth(self.contentLabel.frame), 0);
    }
    self.cellHeight = CGRectGetMaxY(self.contentLabel.frame);

    if (model.images && model.images.count > 0) {
        CGFloat groundHeight = [self getImageGroundHeightWithArr:model.images];
        self.imageGround.frame = CGRectMake(CGRectGetMinX(self.imageGround.frame), CGRectGetMaxY(self.contentLabel.frame) + 10, CGRectGetWidth(self.imageGround.frame), groundHeight);

        [self layoutImageGround];
    }else{
        self.imageGround.frame = CGRectMake(CGRectGetMinX(self.imageGround.frame), CGRectGetMaxY(self.contentLabel.frame), CGRectGetWidth(self.imageGround.frame), 0);
    }
    self.cellHeight = CGRectGetMaxY(self.imageGround.frame);




    if (model.comments && model.comments.count > 0) {
        CGFloat commHeight = [self getCommentHeightWithArr:model.comments font:13 width:Screen_Width - 90];//[self getCommentHeightWithArr:model.comments];
        self.commentView.frame = CGRectMake(CGRectGetMinX(self.commentView.frame), CGRectGetMaxY(self.imageGround.frame) + 10, CGRectGetWidth(self.commentView.frame), commHeight);
    }else{
        self.commentView.frame = CGRectMake(CGRectGetMinX(self.commentView.frame), CGRectGetMaxY(self.imageGround.frame), CGRectGetWidth(self.commentView.frame), 0);
    }
    [self layoutCommentView];
    self.cellHeight = CGRectGetMaxY(self.commentView.frame);


    if (self.cellHeight < 60) {
        self.cellHeight = 60;
    }
    self.cellHeight += 20;
}

- (void)layoutCommentView{

    [self.commentView refreshByArr:self.tweet.comments];
}

- (void)layoutImageGround{


    for (int i = 0; i < self.tweet.images.count; i++) {

        CGFloat x = 0;
        CGFloat y = 0;
        x = (i % 3) * (imageWidth + spaceWidth);
        y = (i / 3) * (imageWidth + spaceWidth);

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWidth, imageWidth)];
        imageView.backgroundColor = [UIColor lightGrayColor];
         // 请注意打开VPN否则图片大概率加载超时
        [imageView tw_setImageWithURL:self.tweet.images[i] placeHolder:nil completion:nil];
        [self.imageGround addSubview:imageView];
    }
}

- (CGFloat)getCommentHeightWithArr:(NSArray *)arr{
    return arr.count * 40;
}

- (CGFloat)getCommentHeightWithArr:(NSArray *)arr font:(CGFloat)font width:(CGFloat)width{
    CGFloat add = 0;
    for (TWCommentModel *model in arr) {

        NSString *content = [NSString stringWithFormat:@"%@:%@ %@ %@",model.sender.nick,model.content,model.content,model.content];
        NSAttributedString *name = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
        CGRect nameRect = [name boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        CGSize nameSize = nameRect.size;
        add = add + nameSize.height + 6;
    }
    return add;
}

- (CGFloat)setLabel:(UILabel *)label font:(CGFloat)font width:(CGFloat)width string:(NSString *)string{

    NSAttributedString *name = [[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    CGSize nameSize = nameRect.size;
    label.attributedText = name;
    return nameSize.height;
}

- (void)initData{

    groundWidth = Screen_Width - 90;
    imageWidth = 70;
    if (IsIPhone6) {
        imageWidth = 88;
    }
    if (IsIPhone6Plus) {
        imageWidth = 101;
    }

    spaceWidth = (groundWidth - imageWidth * 3)/2;
}

- (CGFloat)getImageGroundHeightWithArr:(NSArray *)arr{

    if (arr.count == 0) {
        return 0;
    }else{
        NSInteger line = (arr.count -1)/3;
        if (line == 0) {
            return imageWidth;
        }
        if (line == 1) {
            return imageWidth * 2 + spaceWidth;
        }
        if (line == 2) {
            return groundWidth;
        }
        return 0;
    }
}

@end
