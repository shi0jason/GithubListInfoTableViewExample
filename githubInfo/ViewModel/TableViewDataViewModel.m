//
//  TableViewDataViewModel.m
//  githubInfo
//
//  Created by cch on 2020/3/24.
//  Copyright © 2020 cch. All rights reserved.
//

#import "TableViewDataViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "OwnerModel.h"
#import <netdb.h>

@implementation TableViewDataViewModel {
    NSMutableArray *resultList;
}

- (void)handleData:(void (^)(NSArray *list))result {
    if ([self checkNetworkAvailability]) {
        resultList = [NSMutableArray array];
        NSArray *list = @[@"https://api.github.com/users",@"https://api.github.com/users?since=46",@"https://api.github.com/users?since=91"];
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_queue_create("com.app", DISPATCH_QUEUE_CONCURRENT);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.completionQueue = queue;
        for(int k = 0; k < list.count; k++) {
            dispatch_group_enter(group);
            
            dispatch_async(queue, ^{
                [manager GET:list[k] parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                    [self->resultList addObjectsFromArray:responseObject];
                    dispatch_group_leave(group);
                } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                    dispatch_group_leave(group);
                }];
            });
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"id"
                                                                         ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
            NSArray *sortedArray = [self->resultList sortedArrayUsingDescriptors:sortDescriptors];
            [self->resultList removeAllObjects];
            for (NSDictionary *dict in sortedArray) {
                NSError *error;
                OwnerModel *model = [[OwnerModel alloc] initWithDictionary:dict error:&error];
                [self->resultList addObject:model];
            }
            result(self->resultList);
        });
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(NetWorkError)]) {
            [self.delegate NetWorkError];
        }
    }
}
- (void)handleDataWithLink:(NSString *)link handler:(nonnull void (^)(SingleFileModel * _Nonnull))result{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    dispatch_queue_t queue = dispatch_queue_create("com.app.single", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [manager GET:link parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSError *error;
                SingleFileModel *model = [[SingleFileModel alloc] initWithDictionary:responseObject error:&error];
                result(model);
            }
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        }];
    });
}
#pragma mark - Network Check
- (Boolean)checkNetworkAvailability {
    struct addrinfo *result;
    int error;
    error = getaddrinfo("google.com", NULL, NULL, &result);
    if (error != 0) { // not network
        return false ;
    } else { //networkable
        return true ;
    }
}

@end
