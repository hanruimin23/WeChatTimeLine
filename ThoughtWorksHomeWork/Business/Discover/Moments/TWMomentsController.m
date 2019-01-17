//
//  TWMomentsController.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWMomentsController.h"
#import "TWMacros.h"
#import "TWMomentsViewModel.h"
#import "TWUserInfoModel.h"
#import "TWTweetCell.h"
#import "TWTweetModel.h"
//#import "UIImageView+WebCache.h"
#import "UIImageView+TWWebCache.h"

@interface TWMomentsController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) TWUserInfoModel *infoModel;
@property (nonatomic,strong) NSArray *tweetArr;

@property (nonatomic,strong) UILabel *nicknameLabel;
@property (nonatomic,strong) UIImageView *profileImage;
@property (nonatomic,strong) UIImageView *avatarImage;

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) NSInteger num;

@end

@implementation TWMomentsController

#pragma mark - Property Get Method

- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_Width - 64 + 20 - 40, Screen_Width - 10 - 60 - 20 + 10, 15)];
        _nicknameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _nicknameLabel.textColor = [UIColor blackColor];
        _nicknameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nicknameLabel;
}

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 60 - 10, Screen_Width - 64 + 20 - 60, 60, 60)];
        _avatarImage.backgroundColor = [UIColor whiteColor];
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.borderColor = [UIColor grayColor].CGColor;
        _avatarImage.layer.borderWidth = 0.5;
    }
    return _avatarImage;
}

- (UIImageView *)profileImage{
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, Screen_Width, Screen_Width)];
        _profileImage.backgroundColor = [UIColor lightGrayColor];
    }
    return _profileImage;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width + 40 - 64)];
        _headView.backgroundColor = [UIColor whiteColor];
        [_headView addSubview:self.profileImage];
        [_headView addSubview:self.avatarImage];
        [_headView addSubview:self.nicknameLabel];
    }
    return _headView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;

    }
    return _tableView;
}

#pragma mark Normal Method

- (void)makeTableView{

    [self.view addSubview:self.tableView];
    UIView *view = [[UIView alloc] init];
    self.tableView.tableFooterView = view;
    self.tableView.tableHeaderView = self.headView;
    MJRefreshNormalHeader *ref_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullAndRequest)];
    self.tableView.mj_header = ref_header;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.num ++;
        [self getListWithPage:self.num];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"朋友圈";
    _num = 1;
    [self makeTableView];
    [self refreshUser];
    [self getListWithPage:1];
}

- (void)pullAndRequest{
    [self refreshUser];
    [self getListWithPage:1];;
}

- (void)refreshUser{
    TWMomentsViewModel *viewModel = [[TWMomentsViewModel alloc] init];
    [viewModel setBlocksWithSucBlock:^(id returnData) {
        self.infoModel = (TWUserInfoModel *)returnData;
        // 请注意打开VPN否则图片大概率加载超时
        [self.profileImage tw_setImageWithURL:self.infoModel.profileImage placeHolder:nil completion:nil];
        [self.avatarImage tw_setImageWithURL:self.infoModel.avatar placeHolder:nil completion:nil];
        self.nicknameLabel.text = self.infoModel.nick;

    } faiBlock:^(id returnData) {
        TWLog(@"error = %@",returnData);
    }];
    [viewModel getUserInfo];
}

- (void)getListWithPage:(NSInteger)page{

    TWMomentsViewModel *vm = [[TWMomentsViewModel alloc] init];
    [vm setBlocksWithSucBlock:^(id returnData) {
        self.tweetArr = (NSArray *)returnData;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } faiBlock:^(id returnData) {
        TWLog(@"error = %@",returnData);
    }];
    [vm getTweetListWithPage:page];
}

#pragma mark TableView Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweetArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    TWTweetModel *model = self.tweetArr[indexPath.row];
    TWTweetCell *cell = [TWTweetCell cellWithTableView:tableView];
    [cell refreshCellWithModel:model];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TWTweetModel *model = self.tweetArr[indexPath.row];
    TWTweetCell *cell = [TWTweetCell cellWithTableView:tableView];
    [cell refreshCellWithModel:model];
    return cell;
}


@end
