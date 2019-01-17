//
//  TWDownloadOperation.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/12.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWDownloadOperation.h"

@implementation TWDownloadOperation

-(instancetype)init{
    if (self = [super init]) {
        _isCancelled = NO;
    }
    return self;
}

/*  发送图片下载完毕的通知,便于有多个控件同事设置相同的图片*/
- (void)setImageData:(NSData *)imageData{
    _imageData = imageData;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reReadImageAfterDownload" object:nil
                                                      userInfo:@{@"url":_operationID,@"data":_imageData}];
}

-(void)cancelDownload{
    @synchronized (self) {
        if (!_isCancelled) {
            _isCancelled = YES;
        }
    }
}

@end
