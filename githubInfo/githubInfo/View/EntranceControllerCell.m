//
//  EntranceControllerCell.m
//  githubInfo
//
//  Created by cch on 2020/3/23.
//  Copyright © 2020 cch. All rights reserved.
//

#import "EntranceControllerCell.h"
#define cellHeight 80
@implementation EntranceControllerCell


#pragma mark - Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    _imageContainer.image = nil;
}
#pragma mark - Set Data
- (void)setData:(OwnerModel *)data {
    if (data) {
        _data = data;
        [self loadViewData];
    }
}
- (void)loadViewData {
    OwnerModel *model = _data;
    if ([model isKindOfClass:[OwnerModel class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageContainer sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]
                                   placeholderImage:[UIImage imageNamed:@"photo.png"]
                                            options:SDWebImageRetryFailed|SDWebImageLowPriority
                                          completed:nil];
        });
        [self.titleContainer setText:model.login];
    }
}
#pragma mark - Initial Func
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
        
    _imageContainer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _imageContainer.contentMode = UIViewContentModeScaleAspectFill;
    _imageContainer.layer.cornerRadius = cellHeight / 2;
    _imageContainer.clipsToBounds = true;
    [self addSubview:_imageContainer];

    _titleContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _titleContainer.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleContainer];
    
    [self setupConstraints];
    return self;
}
#pragma mark - Set Constraint
- (void)setupConstraints {
    _imageContainer.translatesAutoresizingMaskIntoConstraints = NO;
    _titleContainer.translatesAutoresizingMaskIntoConstraints = NO;
        
    [NSLayoutConstraint activateConstraints:@[
        [_imageContainer.topAnchor constraintEqualToAnchor:self.topAnchor],
        [_imageContainer.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_imageContainer.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_imageContainer.trailingAnchor constraintEqualToAnchor:_titleContainer.leadingAnchor constant:-10],
        [_imageContainer.widthAnchor constraintEqualToConstant:cellHeight],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [_titleContainer.topAnchor constraintEqualToAnchor:self.topAnchor],
        [_titleContainer.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_titleContainer.widthAnchor constraintEqualToConstant:cellHeight],
    ]];
}
@end
