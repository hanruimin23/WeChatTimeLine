//
//  TWCommentCell.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWCommentModel.h"
#import "TWMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWCommentCell : UITableViewCell

+ (TWCommentCell *)cellWithTableView:(UITableView *)tableView;

- (void)refreshCellWithModel:(TWCommentModel *)model;

- (CGFloat)heightWithModel:(TWCommentModel *)model;

@end

NS_ASSUME_NONNULL_END
