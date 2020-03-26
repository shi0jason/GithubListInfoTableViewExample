//
//  TableViewDataViewModel.h
//  githubInfo
//
//  Created by cch on 2020/3/24.
//  Copyright © 2020 cch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleFileModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol TableViewDataViewModel <NSObject>

- (void)NetWorkError;

@end


@interface TableViewDataViewModel : NSObject

@property (nonatomic, weak) id<TableViewDataViewModel> __nullable delegate;

- (void)handleData:(void (^)(NSArray *list))result;
- (void)handleDataWithLink:(NSString *)link handler:(void (^)(SingleFileModel *model))result;

@end

NS_ASSUME_NONNULL_END
