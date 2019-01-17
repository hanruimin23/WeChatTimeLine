//
//  TWRequestManager.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWMacros.h"



@interface TWRequestManager : NSObject
+ (void)httpRequestGetWithUrl:(NSString *)url
                    parameter:(NSDictionary *)parameter
                      success:(SuccessBlock)successBlock
                      failure:(FailureBlock)failBlock;

+ (void)httpRequestPostWithUrl:(NSString *)url
                     parameter:(NSDictionary *)parameter
                       success:(SuccessBlock)successBlock
                       failure:(FailureBlock)failBlock;

@end


