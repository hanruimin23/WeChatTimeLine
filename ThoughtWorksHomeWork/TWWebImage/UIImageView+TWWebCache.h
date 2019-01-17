//
//  UIImageView+TWWebCache.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TWLoadImageCallBack)(UIImage * image);


@interface UIImageView (TWWebCache)
-(void)tw_setImageWithURL:(NSString *)urlStr placeHolder:(UIImage *)imageHolder completion:(TWLoadImageCallBack)completion;
@end

