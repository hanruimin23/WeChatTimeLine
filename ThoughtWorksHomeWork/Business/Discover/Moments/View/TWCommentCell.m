//
//  TWCommentCell.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWCommentCell.h"

@interface TWCommentCell ()
@property (nonatomic,strong) UILabel *commentLabel;
@end

@implementation TWCommentCell

- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, Screen_Width - 90 -5, 0)];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.numberOfLines = 0;
        _commentLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _commentLabel;
}

+ (TWCommentCell *)cellWithTableView:(UITableView *)tableView{

    TWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[TWCommentCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xf3f3f5);
        [self addSubview:self.commentLabel];
    }
    return self;
}

- (CGFloat)heightWithModel:(TWCommentModel *)model{

    NSString *content = [NSString stringWithFormat:@"%@:%@ %@ %@",model.sender.nick,model.content,model.content,model.content];
    NSAttributedString *name = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(Screen_Width - 90, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    CGSize nameSize = nameRect.size;
    return nameSize.height + 6;
}

- (void)refreshCellWithModel:(TWCommentModel *)model{

    NSString *nick = [NSString stringWithFormat:@"%@:",model.sender.nick];
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@",model.content,model.content,model.content];
    NSString *content = [NSString stringWithFormat:@"%@%@",nick,text];

    NSMutableAttributedString *beforeStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [beforeStr addAttribute:NSForegroundColorAttributeName value:UIColorFromHex(0x616887) range:[content rangeOfString:nick]];
    [beforeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:[content rangeOfString:nick]];
    [beforeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[content rangeOfString:text]];
    self.commentLabel.attributedText = beforeStr;

    CGRect nameRect = [beforeStr boundingRectWithSize:CGSizeMake(Screen_Width - 90, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    self.commentLabel.frame = CGRectMake(CGRectGetMinX(self.commentLabel.frame), CGRectGetMinY(self.commentLabel.frame), CGRectGetWidth(self.commentLabel.frame), nameRect.size.height);
}


@end
