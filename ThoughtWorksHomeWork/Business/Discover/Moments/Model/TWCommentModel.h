//
//  TWCommentModel.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWSenderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWCommentModel : NSObject
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) TWSenderModel *sender;

@end

NS_ASSUME_NONNULL_END
