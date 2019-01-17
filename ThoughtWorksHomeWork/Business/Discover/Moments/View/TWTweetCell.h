//
//  TWTweetCell.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTweetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWTweetCell : UITableViewCell

@property (nonatomic,assign) CGFloat cellHeight;

+ (TWTweetCell *)cellWithTableView:(UITableView *)tableView;

- (void)refreshCellWithModel:(TWTweetModel *)model;

@end

NS_ASSUME_NONNULL_END
