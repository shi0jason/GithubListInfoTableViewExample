//
//  ViewController.m
//  githubInfo
//
//  Created by cch on 2020/3/26.
//  Copyright © 2020 cch. All rights reserved.
//

#import "EntranceController.h"

#define cellWidth [UIScreen mainScreen].bounds.size.width * 0.6
#define cellHeight 80

@interface EntranceController()<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *result;
    UITableView *tableview;
}

@end

@implementation EntranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    [self accessData];
}
- (void)accessData {

}
- (void)setupTableView {
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [tableview registerClass:[EntranceControllerCell class] forCellReuseIdentifier:@"Cell"];
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
    return [UITableViewCell new];
}
@end
