//
//  TWMacros.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/12.
//  Copyright © 2019 jackie. All rights reserved.
//

#ifndef TWMacros_h
#define TWMacros_h

#import "AFNetworking.h"
#import "MJRefresh.h"
#define GET_USERINFO_URL                    @"http://thoughtworks-ios.herokuapp.com/user/jsmith"
#define GET_TWEETS_URL                      @"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets"

typedef void(^SuccessBlock)(id returnData);
typedef void(^FailureBlock)(id returnData);

#define TWLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//屏幕大小
#define Screen_Height   [[UIScreen mainScreen] bounds].size.height
#define Screen_Width    [[UIScreen mainScreen] bounds].size.width
// 判断设备判断
#define IsIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
/// 根据16进制hex 获取颜色
#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
//不同屏幕尺寸字体适配
#define kScreenWidthRatio  (UIScreen.mainScreen.bounds.size.width / 375.0)
#define kScreenHeightRatio (UIScreen.mainScreen.bounds.size.height / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]

#endif /* TWMacros_h */
