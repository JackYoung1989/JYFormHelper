//
//  JYTableViewControllerDemo.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/13.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYTableViewControllerDemo.h"
#import "JYKeyValueModel.h"

//展示     
@interface JYTableViewControllerDemo ()

@end

@implementation JYTableViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择人员";
    
    self.dataSource = @[@"",@""];
    
    self.isHasHeaderRefresh = false;
    self.isHasFooterRefresh = false;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    [self.tableView registerClass:[JYListCell class] forCellReuseIdentifier:NSStringFromClass([JYListCell class])];
    self.tableView.backgroundColor = UIColor.yellowColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(-66 - kBottomInset);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    JYListCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYListCell class]) forIndexPath:indexPath];
//    if (self.dataSource.count > 0) {
//        listCell.model = self.dataSource[0];
//    }
//    return listCell;
    return nil;
}

@end
