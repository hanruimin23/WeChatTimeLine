//
//  TWRequestManager.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWRequestManager.h"


@implementation TWRequestManager

+ (void)httpRequestGetWithUrl:(NSString *)url
                    parameter:(NSDictionary *)parameter
                      success:(SuccessBlock)successBlock
                      failure:(FailureBlock)failBlock{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        failBlock(@"网络无法连接");
        return;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failBlock(error);
    }];
}

+ (void)httpRequestPostWithUrl:(NSString *)url
                     parameter:(NSDictionary *)parameter
                       success:(SuccessBlock)successBlock
                       failure:(FailureBlock)failBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        failBlock(@"网络无法连接");
        return;
    }
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

@end
