//
//  PersonInfoController.m
//  githubInfo
//
//  Created by cch on 2020/3/24.
//  Copyright © 2020 cch. All rights reserved.
//

#import "PersonInfoController.h"
#import "TableViewDataViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface PersonInfoController(){
    UIImageView *ownerPhoto;
    UIImageView *userView;
    UIImageView *locationView;
    UIImageView *blogView;
    
    UILabel *loginNameLabel;
    UILabel *bioLabel;
    
    UILabel *loginLabel;
    UILabel *locationLabel;
    UIButton *blogLinkButton;
}
@end
@implementation PersonInfoController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    [self setupConstraint];
}
#pragma mark - Initial UIView
- (UIImageView *)initialImageView {
    return [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
}
- (UILabel *)initialLabelView {
   UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
- (UIButton *)initialButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn addTarget:self
            action:@selector(addClickEvent)
  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
#pragma mark - Event
- (void)addClickEvent {
    if (blogLinkButton.titleLabel.text.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:blogLinkButton.titleLabel.text]
                                           options:@{}
                                 completionHandler:nil];
    }
}
#pragma mark - UI
- (void)setupUI {
    [self.view setBackgroundColor:UIColor.whiteColor];
    // Image
    ownerPhoto = [self initialImageView];
    userView = [self initialImageView];
    locationView = [self initialImageView];
    blogView = [self initialImageView];
    //Label
    loginNameLabel = [self initialLabelView];
    bioLabel = [self initialLabelView];
    loginLabel = [self initialLabelView];
    locationLabel = [self initialLabelView];
    blogLinkButton = [self initialButton];
    
    [self.view addSubview:ownerPhoto];
    [self.view addSubview:userView];
    [self.view addSubview:locationView];
    [self.view addSubview:blogView];
    [self.view addSubview:loginNameLabel];
    [self.view addSubview:bioLabel];
    [self.view addSubview:loginLabel];
    [self.view addSubview:locationLabel];
    [self.view addSubview:blogLinkButton];
    
    [loginNameLabel setTextAlignment:NSTextAlignmentCenter];
    [bioLabel setTextAlignment:NSTextAlignmentCenter];
    blogLinkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    ownerPhoto.layer.cornerRadius = 125;
    ownerPhoto.clipsToBounds = true;

    [ownerPhoto setImage:[UIImage imageNamed:@"photo.png"]];
    [userView setImage:[UIImage imageNamed:@"user.png"]];
    [locationView setImage:[UIImage imageNamed:@"Location.png"]];
    [blogView setImage:[UIImage imageNamed:@"Link.png"]];
}
#pragma mark - Data
- (void)setInfoLink:(NSString *)infoLink {
    _infoLink = infoLink;
    [self setDataToUI];
}
- (void)setDataToUI {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading";
    
    TableViewDataViewModel *dataModel = [[TableViewDataViewModel alloc] init];
    [dataModel handleDataWithLink:_infoLink handler:^(SingleFileModel * _Nonnull model) {        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->ownerPhoto sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]
                                placeholderImage:[UIImage imageNamed:@"photo.png"]
                                         options:SDWebImageRetryFailed|SDWebImageLowPriority
                                       completed:nil];
        });
        [self->loginNameLabel setText:model.name == nil ? @"no name info" : model.name];
        [self->bioLabel setText:model.bio == nil ? @"no bio info" : model.bio];
        [self->loginLabel setText:model.login == nil ? @"no login info" : model.login];
        [self->locationLabel setText:model.location == nil ? @"no location info" : model.location];
        [self->blogLinkButton setTitle:model.blog == nil ? @"no blog link info" : model.blog forState:UIControlStateNormal];
        
        [self->loginNameLabel setTextColor:model.name == nil ? UIColor.redColor : UIColor.blackColor];
        [self->bioLabel setTextColor:model.bio == nil ? UIColor.redColor : UIColor.blackColor];
        [self->loginLabel setTextColor:model.login == nil ? UIColor.redColor : UIColor.blackColor];
        [self->locationLabel setTextColor:model.location == nil ? UIColor.redColor : UIColor.blackColor];
        [self->blogLinkButton setTitleColor:model.blog == nil ? UIColor.redColor : UIColor.blueColor forState:UIControlStateNormal];

        [hud hideAnimated:YES];
    }];
}
#pragma mark - Constraint
- (void)setupConstraint {
    ownerPhoto.translatesAutoresizingMaskIntoConstraints = NO;
    userView.translatesAutoresizingMaskIntoConstraints = NO;
    locationView.translatesAutoresizingMaskIntoConstraints = NO;
    blogView.translatesAutoresizingMaskIntoConstraints = NO;
    
    loginNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    bioLabel.translatesAutoresizingMaskIntoConstraints = NO;
    loginLabel.translatesAutoresizingMaskIntoConstraints = NO;
    locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    blogLinkButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [ownerPhoto.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:80.0],
        [ownerPhoto.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [ownerPhoto.heightAnchor  constraintEqualToConstant:250.0],
        [ownerPhoto.widthAnchor  constraintEqualToConstant:250.0],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [loginNameLabel.topAnchor constraintEqualToAnchor:ownerPhoto.bottomAnchor constant:20.0],
        [loginNameLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [loginNameLabel.heightAnchor  constraintEqualToConstant:40.0],
        [loginNameLabel.widthAnchor  constraintEqualToConstant:200.0],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [bioLabel.topAnchor constraintEqualToAnchor:loginNameLabel.bottomAnchor constant:20.0],
        [bioLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [bioLabel.heightAnchor  constraintEqualToConstant:40.0],
        [bioLabel.widthAnchor  constraintEqualToConstant:200.0],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [userView.topAnchor constraintEqualToAnchor:bioLabel.bottomAnchor constant:20.0],
        [userView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [userView.heightAnchor  constraintEqualToConstant:40.0],
        [userView.widthAnchor  constraintEqualToConstant:40.0],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [locationView.topAnchor constraintEqualToAnchor:userView.bottomAnchor constant:20.0],
        [locationView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [locationView.heightAnchor  constraintEqualToConstant:40.0],
        [locationView.widthAnchor  constraintEqualToConstant:40.0],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [blogView.topAnchor constraintEqualToAnchor:locationView.bottomAnchor constant:20.0],
        [blogView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [blogView.heightAnchor  constraintEqualToConstant:40.0],
        [blogView.widthAnchor  constraintEqualToConstant:40.0],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [loginLabel.topAnchor constraintEqualToAnchor:bioLabel.bottomAnchor constant:20.0],
        [loginLabel.leadingAnchor constraintEqualToAnchor:userView.trailingAnchor constant:20.0],
        [loginLabel.heightAnchor  constraintEqualToConstant:40.0],
        [loginLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [locationLabel.topAnchor constraintEqualToAnchor:loginLabel.bottomAnchor constant:20.0],
        [locationLabel.leadingAnchor constraintEqualToAnchor:locationView.trailingAnchor constant:20.0],
        [locationLabel.heightAnchor  constraintEqualToConstant:40.0],
        [locationLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [blogLinkButton.topAnchor constraintEqualToAnchor:locationLabel.bottomAnchor constant:20.0],
        [blogLinkButton.leadingAnchor constraintEqualToAnchor:blogView.trailingAnchor constant:20.0],
        [blogLinkButton.heightAnchor  constraintEqualToConstant:40.0],
        [blogLinkButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
}
@end
