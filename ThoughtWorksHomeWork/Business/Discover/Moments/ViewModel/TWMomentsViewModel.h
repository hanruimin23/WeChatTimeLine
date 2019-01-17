//
//  TWMomentsViewModel.h
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/13.
//  Copyright © 2019 jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWMomentsViewModel : NSObject

@property (nonatomic,copy) SuccessBlock sucBlock;
@property (nonatomic,copy) FailureBlock faiBlock;

- (void)setBlocksWithSucBlock:(SuccessBlock)sucBlock
                     faiBlock:(FailureBlock)faiBlock;

- (void)getUserInfo;

- (void)getTweetListWithPage:(NSInteger)page;

@end

NS_ASSUME_NONNULL_END
