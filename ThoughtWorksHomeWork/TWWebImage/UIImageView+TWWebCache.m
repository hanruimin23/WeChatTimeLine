//
//  UIImageView+TWWebCache.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "UIImageView+TWWebCache.h"
#import "UIView+TWCacheOperation.h"
#import <objc/runtime.h>
#import "TWImageManager.h"
static char TWImageUrlKey;
@implementation UIImageView (TWWebCache)
-(void)tw_setImageWithURL:(NSString *)urlStr placeHolder:(UIImage *)imageHolder completion:(TWLoadImageCallBack)completion{

    [self tw_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &TWImageUrlKey, urlStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (imageHolder) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = imageHolder;
        });
    }
    if (urlStr) {
        __weak typeof(self) weak_self = self;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            TWDownloadOperation * operation = [TWImageManager.shareInstance loadImageWithUrl:urlStr Completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished, NSURL *imageUrl) {
                if (!weak_self) {
                    return ;
                }
                if (image) {
                    self.image = image;
                    [weak_self setNeedsDisplay];
                    completion?completion(image):nil;
                }else if(error){
                    completion?completion(nil):nil;
                    NSLog(@"TWWebImage-ERROR: %@",error.localizedDescription);
                }
            }];
            [self tw_setImageLoadOperation:operation forKey:@"UIImageViewLoad_Operation"];
        });
    }else{
        NSLog(@"TWWebImage-ERROR: url error!");
    }
}
///取消当前图片的设置任务
-(void)tw_cancelCurrentImageLoad{
    [self tw_cancelImageLoadOperationWithKey:@"UIImageViewLoad_Operation"];
}
@end
