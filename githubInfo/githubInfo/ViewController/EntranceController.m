//
//  ViewController.m
//  githubInfo
//
//  Created by cch on 2020/3/23.
//  Copyright © 2020 cch. All rights reserved.
//

#import "EntranceController.h"
#import "EntranceControllerCell.h"
#import "OwnerModel.h"
#import "TableViewDataViewModel.h"
#import "PersonInfoController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#define cellWidth [UIScreen mainScreen].bounds.size.width * 0.6
#define cellHeight 80

@interface EntranceController()<UITableViewDelegate, UITableViewDataSource, TableViewDataViewModel>{
    NSMutableArray *result;
    TableViewDataViewModel *dataModel;

    MBProgressHUD *phud;
    UITableView *tableview;
}

@end

@implementation EntranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self accessData];
}
- (void)accessData {
    if (!dataModel) {
        dataModel = [[TableViewDataViewModel alloc] init];
        dataModel.delegate = self;
    }
    
    phud = [self setupProgressBar];
    [dataModel handleData:^(NSArray * _Nonnull list) {
        self->result = [[NSMutableArray alloc] initWithArray:list];
        [self->tableview reloadData];
        [self->phud hideAnimated:YES];
    }];
}
- (void)setupTableView {
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [tableview registerClass:[EntranceControllerCell class] forCellReuseIdentifier:@"Cell"];
}
- (MBProgressHUD *)setupProgressBar {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.text = @"Loading";
    hud.label.textColor = UIColor.whiteColor;
    [hud showAnimated:YES];
    return hud;
}
#pragma mark - AlertView
- (void)showAlert {
    if (phud) {
        [phud hideAnimated:YES];
    }
    UIAlertAction *reAccess = [UIAlertAction actionWithTitle:@"retry"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        [self accessData];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"NetWork UnReachable"
                                                                             message:@"Please Check your Connection"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:reAccess];
    [alertController addAction:cancel];

    [self presentViewController:alertController animated:NO completion:nil];
}

#pragma mark - Delegate
- (void)NetWorkError {
    [self showAlert];
}
#pragma mark - Tableview DataSource && Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return result.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EntranceControllerCell *cell = [[EntranceControllerCell alloc] initWithFrame:CGRectMake(0, 0, cellWidth, 50)];
    OwnerModel *model = result[indexPath.row];
    [cell setData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //send "login"
    OwnerModel *model = result[indexPath.row];
    NSString * ownerLink = [NSString stringWithFormat:@"https://api.github.com/users/%@",model.login];
    PersonInfoController *vc = [[PersonInfoController alloc] init];
    vc.infoLink = ownerLink;
    [self.navigationController pushViewController:vc animated:true];
}
@end
