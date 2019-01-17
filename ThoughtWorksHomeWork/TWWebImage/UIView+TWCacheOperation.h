//
//  UIView+TWCacheOperation.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/12.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWDownloadOperation.h"

NS_ASSUME_NONNULL_BEGIN

//该view所对应的操作
@interface UIView (TWCacheOperation)
///设置UIView 所对应的操作
-(void)tw_setImageLoadOperation:(TWDownloadOperation *)operation forKey:(NSString *)key;

///暂停当前UIView key对应的所有操作
-(void)tw_cancelImageLoadOperationWithKey:(NSString *)key;

///删除UIView key对应的所有操作
-(void)tw_removeImageLoadOperationWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
