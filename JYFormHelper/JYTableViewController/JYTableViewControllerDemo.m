//
//  JYTableViewControllerDemo.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/13.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYTableViewControllerDemo.h"
#import "JYPersonSelectCell.h"

//展示     
@interface JYTableViewControllerDemo ()

//没有在本类（默认的或者请求下人员列表）数据中的人员数组，选择完的话，需要连同选择的人员，一起返回给formModel。
@property (nonatomic, strong)NSMutableArray *outOfScopeArray;

@end

@implementation JYTableViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择人员";
    self.outOfScopeArray = [[NSMutableArray alloc] init];
    
    NSString *personString = @"[{\"name\":\"Jack1\", \"id\":\"11111\", \"userPhone\":\"11111111111\"},{\"name\":\"Jack2\", \"id\":\"22222\", \"userPhone\":\"22222222222\"},{\"name\":\"Jack3\", \"id\":\"33333\", \"userPhone\":\"333333333\"},{\"name\":\"Jack4\", \"id\":\"44444\", \"userPhone\":\"444444444\"},{\"name\":\"Jack5\", \"id\":\"55555\", \"userPhone\":\"555555555\"}]";
    NSArray *personsArray = [NSArray modelArrayWithClass:[JYKeyValueModel class] json:personString];
    //在这里，上面的数据是假设从网络上下载的数据，可能是别的model，JYKeyValueModel.tempString保存该model的所有数据。防止后台需要更多model数据。
    if (self.ifReturnAllPropertyOfSelectedModel) {
        for (int i = 0; i < personsArray.count; i ++) {
            JYKeyValueModel *model = personsArray[i];
            model.tempString = model.modelToJSONString;
        }
    }
    self.dataSource = [NSMutableArray arrayWithArray:personsArray];
    
    self.isHasHeaderRefresh = false;
    self.isHasFooterRefresh = false;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[JYPersonSelectCell class] forCellReuseIdentifier:NSStringFromClass([JYPersonSelectCell class])];
    self.tableView.backgroundColor = UIColor.yellowColor;
    
    self.isHasSureButtonBelowTableView = true;
    weakSelf(self)
    self.sureButtonTouchedBlock = ^{
        if (weakSelf.selectedItemsArrayBlock) {
            NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:weakSelf.outOfScopeArray];
            for (int i = 0; i < weakSelf.dataSource.count; i ++) {
                JYKeyValueModel *model = weakSelf.dataSource[i];
                if (model.isSelected) {
                    [resultArray addObject:model];
                }
            }
            
            weakSelf.selectedItemsArrayBlock(resultArray);
        }
    };
    
    //默认已经选中的cell
    if (self.selectedArray.count > 0) {
        for (int j = 0; j < self.selectedArray.count; j ++) {
            JYKeyValueModel *tempModel = self.selectedArray[j];
            BOOL matched = false;
            for (int i = 0; i < self.dataSource.count; i ++) {
                JYKeyValueModel *model = self.dataSource[i];
                if ([tempModel.itemId isEqualToString:model.itemId]) {
                    model.isSelected = true;
                    matched = true;
                    break;
                }
            }
            if (!matched) {
                [self.outOfScopeArray addObject:tempModel];//默认的人员数据，没有在本类的数据中(来自网络请求)
            }
        }
    }
}

- (void)setSelectedArray:(NSArray *)selectedArray {
    _selectedArray = selectedArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYPersonSelectCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYPersonSelectCell class]) forIndexPath:indexPath];
    listCell.row = indexPath.row;
    listCell.radioReturnBlock = ^(NSInteger num, BOOL isSelected) {
        JYKeyValueModel *model = self.dataSource[num];
        model.isSelected = isSelected;
        [self.tableView reloadData];
    };
    if (self.dataSource.count > 0) {
        listCell.model = self.dataSource[indexPath.row];
    }
    return listCell;
}

@end
