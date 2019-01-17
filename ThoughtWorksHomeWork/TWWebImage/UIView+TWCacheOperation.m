//
//  UIView+TWCacheOperation.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/12.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "UIView+TWCacheOperation.h"
#import <objc/runtime.h>

static char OperationKey;

@implementation UIView (TWCacheOperation)

- (NSMutableDictionary *)operationDictionary{
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &OperationKey);
    if (operations) {
        return  operations;
    }
    operations = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &OperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}

// 设置UIView 所对应的操作
- (void)tw_setImageLoadOperation:(TWDownloadOperation *)operation forKey:(NSString *)key{
    [self tw_cancelImageLoadOperationWithKey:key];
    NSMutableDictionary * dic = [self operationDictionary];
    [dic setObject:operation forKey:key];
}

//暂停当前UIView key对应的操作
- (void)tw_cancelImageLoadOperationWithKey:(NSString *)key{
    NSMutableDictionary *operationsDic = [self operationDictionary];
    id operation = operationsDic[key];
    if (operation && [operation isKindOfClass:[TWDownloadOperation class]]) {
        [operation cancelDownload];
    }
    [operationsDic removeObjectForKey:key];
}

//删除UIView key对应的所有操作
- (void)tw_removeImageLoadOperationWithKey:(NSString *)key{
    NSMutableDictionary * operationDic = [self operationDictionary];
    [operationDic removeObjectForKey:key];
}

@end
