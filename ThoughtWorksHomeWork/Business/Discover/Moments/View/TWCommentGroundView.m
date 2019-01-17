//
//  TWCommentGroundView.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWCommentGroundView.h"
#import "TWMacros.h"
#import "TWCommentModel.h"
#import "TWCommentCell.h"
#import <QuartzCore/QuartzCore.h>

@interface TWCommentGroundView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *commentTable;
@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,strong) CAShapeLayer *threelayer;

@end

@implementation TWCommentGroundView

- (UITableView *)commentTable{
    if (!_commentTable) {
        _commentTable= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 60 - 30, 0)];
        _commentTable.backgroundColor = UIColorFromHex(0xf3f3f5);
        _commentTable.scrollEnabled = NO;
        _commentTable.delegate = self;
        _commentTable.dataSource = self;
        _commentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _commentTable;
}

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xf3f3f5);
        [self layoutMarker];
    }
    return self;
}

- (void)layoutMarker{

    self.threelayer = [CAShapeLayer new];

    UIBezierPath *three = [UIBezierPath bezierPath];
    [three moveToPoint:CGPointMake(15.8, -5)];
    [three addLineToPoint:CGPointMake( 21.6, 0)];
    [three addLineToPoint:CGPointMake( 10, 0)];
    [three addLineToPoint:CGPointMake(15.8, -5)];


    self.threelayer.path = three.CGPath;
    UIColor *color = UIColorFromHex(0xf3f3f5);
    self.threelayer.strokeColor = color.CGColor;
    self.threelayer.fillColor = color.CGColor;
    [self.layer addSublayer:self.threelayer];
}

- (void)refreshByArr:(NSArray *)arr{

    self.threelayer.hidden = (self.frame.size.height == 0);
    if (arr && arr.count > 0) {

        [self addSubview:self.commentTable];
        self.dataArr = arr;
        self.commentTable.frame = self.bounds;
        [self.commentTable reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWCommentCell *commentCell = [TWCommentCell cellWithTableView:tableView];
    return [commentCell heightWithModel:self.dataArr[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWCommentCell *cell = [TWCommentCell cellWithTableView:tableView];
    [cell refreshCellWithModel:self.dataArr[indexPath.row]];
    return cell;
}

@end
