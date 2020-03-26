//
//  SingleFileModel.h
//  githubInfo
//
//  Created by cch on 2020/3/24.
//  Copyright © 2020 cch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface SingleFileModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *avatar_url;
@property (strong, nonatomic) NSString<Optional> *name;
@property (strong, nonatomic) NSString<Optional> *bio;
@property (strong, nonatomic) NSString<Optional> *login;
@property (strong, nonatomic) NSString<Optional> *site_admin;
@property (strong, nonatomic) NSString<Optional> *location;
@property (strong, nonatomic) NSString<Optional> *blog;

@end

NS_ASSUME_NONNULL_END
