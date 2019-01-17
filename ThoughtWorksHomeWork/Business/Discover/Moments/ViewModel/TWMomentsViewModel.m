//
//  TWMomentsViewModel.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWMomentsViewModel.h"
#import "TWRequestManager.h"
#import "TWUserInfoModel.h"
#import "TWSenderModel.h"
#import "TWTweetModel.h"
#import "TWCommentModel.h"

@interface TWMomentsViewModel()
@property (nonatomic,strong) TWUserInfoModel *userModel;
@property (nonatomic,strong) NSMutableArray *tweetArr;
@end

@implementation TWMomentsViewModel

- (void)setBlocksWithSucBlock:(SuccessBlock)sucBlock faiBlock:(FailureBlock)faiBlock{
    self.sucBlock = sucBlock;
    self.faiBlock = faiBlock;
}

- (void)getUserInfo{

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSDictionary *memoryDic = [def objectForKey:@"user"];
    if (memoryDic) {
        [self userModelFromDic:memoryDic];
    }

    [TWRequestManager httpRequestGetWithUrl:GET_USERINFO_URL parameter:nil success:^(id returnData) {

        [self userModelFromDic:returnData];
        [def setObject:returnData forKey:@"user"];
        [def synchronize];
    } failure:^(id returnData) {
        self.faiBlock(returnData);
    }];
}

- (void)userModelFromDic:(id)dic{

    NSDictionary *dict = (NSDictionary *)dic;
    self.userModel = [[TWUserInfoModel alloc] init];
    self.userModel.avatar = [dict objectForKey:@"avatar"];
    self.userModel.nick = [dict objectForKey:@"nick"];
    self.userModel.profileImage = [dict objectForKey:@"profile-image"];
    self.userModel.userName = [dict objectForKey:@"username"];
    self.sucBlock(self.userModel);
}

- (void)getTweetListWithPage:(NSInteger)page{

    [TWRequestManager httpRequestGetWithUrl:GET_TWEETS_URL parameter:nil success:^(id returnData) {

        [self tweetArrayFromArr:returnData Page:page];
    } failure:^(id returnData) {
        self.faiBlock(returnData);
    }];
}

- (void)tweetArrayFromArr:(id)arr Page:(NSInteger)page{

    self.tweetArr = [[NSMutableArray alloc] init];

    for (NSDictionary *dic in (NSArray *)arr) {

        if (!dic[@"sender"]) {
            continue;
        }
        if (!dic[@"content"] && !dic[@"images"]) {
            continue;
        }

        NSDictionary *senderDic = dic[@"sender"];
        TWSenderModel *senderModel = [[TWSenderModel alloc] init];
        senderModel.avatar = senderDic[@"avatar"];
        senderModel.nick = senderDic[@"nick"];
        senderModel.username = senderDic[@"username"];

        NSArray *imageArr = dic[@"images"];
        NSMutableArray *imgArray = [[NSMutableArray alloc] init];
        if (imageArr && imageArr.count > 0) {
            for (NSDictionary *urlDic in imageArr) {
                [imgArray addObject:urlDic[@"url"]];
            }
        }

        NSArray *commentsArr = dic[@"comments"];
        NSMutableArray *commentArray = [[NSMutableArray alloc] init];
        if (commentsArr && commentsArr.count > 0) {
            for (NSDictionary *commDic in commentsArr) {
                [commentArray addObject:[self commentModelFromDic:commDic]];
            }
        }

        TWTweetModel *model = [[TWTweetModel alloc] init];
        model.sender = senderModel;
        model.content = dic[@"content"];
        model.images = imgArray;
        model.comments = commentArray;

        [self.tweetArr addObject:model];
    }

    if (page * 5 < self.tweetArr.count) {
        NSArray *arr = [self.tweetArr subarrayWithRange:NSMakeRange(0, page * 5)];
        self.sucBlock(arr);
    }else{
        self.sucBlock(self.tweetArr);
    }
}


- (TWCommentModel *)commentModelFromDic:(NSDictionary *)dic{

    TWSenderModel *sender = [[TWSenderModel alloc] init];
    sender.avatar = dic[@"sender"][@"avatar"];
    sender.nick = dic[@"sender"][@"nick"];
    sender.username = dic[@"sender"][@"username"];

    TWCommentModel *commentModel = [[TWCommentModel alloc] init];
    commentModel.content = dic[@"content"];
    commentModel.sender = sender;

    return commentModel;
}



@end
