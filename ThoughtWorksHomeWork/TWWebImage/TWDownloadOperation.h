//
//  TWDownloadOperation.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/12.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWDownloadOperation : NSObject
@property (nonatomic,copy) NSString * operationID;
@property (nonatomic,assign) BOOL isCancelled;
@property (nonatomic,strong) NSData * imageData;

-(void)cancelDownload;
@end

NS_ASSUME_NONNULL_END
