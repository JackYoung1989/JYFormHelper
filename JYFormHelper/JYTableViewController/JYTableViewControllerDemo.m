//
//  JYTableViewControllerDemo.m
//  Ccreate_iOS
//
//  Created by JackYoung on 2021/2/13.
//  Copyright © 2021 yunchuang. All rights reserved.
//

#import "JYTableViewControllerDemo.h"
#import "CCKeyValueModel.h"
#import "JYListModel.h"
#import "JYListCell.h"

//展示     
@interface JYTableViewControllerDemo ()

@end

@implementation JYTableViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小组详情";
    
    NSDictionary *dic = @{@"小组名称":@"土地事务处理组",
      @"服务专员":@"张建、王让、李然",
      @"关联企业":@"潍坊特钢集团有限公司、潍柴动力股份有限公司、歌尔声学股份有限公司",
      @"开始时间":@"2021/01/22 10:22",
      @"结束时间":@"2021/01/22 10:22",
      @"备注":@"事情进展顺利",
      @"是否推送消息":@"是",
                          @"消息内容":@"您已被王阳所关联，请注意查看"};
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < dic.allKeys.count; i ++) {
        CCKeyValueModel *model = [[CCKeyValueModel alloc] init];
        model.key = dic.allKeys[i];
        model.value = [dic objectForKey:model.key];
        [tempArray addObject:model];
    }
    JYListModel *model = [[JYListModel alloc] init];
    model.keyValuesArray = tempArray;
    self.dataSource = @[model];
    
    self.isHasHeaderRefresh = false;
    self.isHasFooterRefresh = false;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[JYListCell class] forCellReuseIdentifier:NSStringFromClass([JYListCell class])];
    self.tableView.backgroundColor = UIColor.yellowColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(-66 - kBottomInset);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYListCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYListCell class]) forIndexPath:indexPath];
    if (self.dataSource.count > 0) {
        listCell.model = self.dataSource[0];
    }
    return listCell;
}

@end
