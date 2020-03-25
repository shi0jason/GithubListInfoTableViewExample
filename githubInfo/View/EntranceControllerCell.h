//
//  EntranceControllerCell.h
//  githubInfo
//
//  Created by cch on 2020/3/23.
//  Copyright © 2020 cch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnerModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
NS_ASSUME_NONNULL_BEGIN

@interface EntranceControllerCell : UITableViewCell

//elemenet object
@property (strong, nonatomic) UIImageView *imageContainer;
@property (strong, nonatomic) UILabel *titleContainer;


//DataSet
@property (nonatomic,strong) OwnerModel *data;

@end

NS_ASSUME_NONNULL_END
