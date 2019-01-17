//
//  TWImageManager.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "TWDownloadOperation.h"
typedef void(^TWloadImageCompletedBlock)(UIImage *image,NSData * data,NSError * error,BOOL finished,NSURL *imageUrl);

NS_ASSUME_NONNULL_BEGIN

@interface TWImageManager : NSObject
+(instancetype)shareInstance;

-(TWDownloadOperation *)loadImageWithUrl:(NSString *)urlStr Completed:(TWloadImageCompletedBlock)completedBlock;
-(UIImage *)loadImageOnlyCache:(NSString *)url;
-(UIImage *)loadImageOnlyDisk:(NSString *)url;

-(void)clearCache;
-(void)clearDisk;

@end

NS_ASSUME_NONNULL_END
