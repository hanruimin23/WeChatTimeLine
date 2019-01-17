//
//  TWDownloader.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWDownloadOperation.h"
typedef void(^TWDownImageCompletedBlock)(NSData * data, NSError * error, BOOL finished);
typedef void(^TWDownImageProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

NS_ASSUME_NONNULL_BEGIN

@interface TWDownloader : NSObject
+(instancetype)shareInstance;

-(TWDownloadOperation *)downloadImageWithUrl:(NSURL *)url CompletedBlock:(TWDownImageCompletedBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
