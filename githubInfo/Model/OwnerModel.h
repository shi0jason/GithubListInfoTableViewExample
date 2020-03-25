//
//  OwnerModel.h
//  githubInfo
//
//  Created by cch on 2020/3/24.
//  Copyright © 2020 cch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface OwnerModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *login;
@property (strong, nonatomic) NSString<Optional> *id;
@property (strong, nonatomic) NSString<Optional> *node_id;
@property (strong, nonatomic) NSString<Optional> *avatar_url;
@property (strong, nonatomic) NSString<Optional> *gravatar_id;
@property (strong, nonatomic) NSString<Optional> *url;
@property (strong, nonatomic) NSString<Optional> *html_url;
@property (strong, nonatomic) NSString<Optional> *followers_url;
@property (strong, nonatomic) NSString<Optional> *following_url;
@property (strong, nonatomic) NSString<Optional> *gists_url;
@property (strong, nonatomic) NSString<Optional> *starred_url;
@property (strong, nonatomic) NSString<Optional> *subscriptions_url;
@property (strong, nonatomic) NSString<Optional> *organizations_url;
@property (strong, nonatomic) NSString<Optional> *repos_url;
@property (strong, nonatomic) NSString<Optional> *events_url;
@property (strong, nonatomic) NSString<Optional> *received_events_url;
@property (strong, nonatomic) NSString<Optional> *type;
@property (strong, nonatomic) NSString<Optional> *site_admin;

@end

NS_ASSUME_NONNULL_END
