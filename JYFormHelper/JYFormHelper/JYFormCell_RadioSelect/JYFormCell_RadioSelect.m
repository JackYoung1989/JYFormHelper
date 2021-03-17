//
//  JYFormCell_RadioSelect.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/8.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_RadioSelect.h"
#import "JYFormCell_RadioSelectInnerCell.h"

@interface JYFormCell_RadioSelect()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation JYFormCell_RadioSelect

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(0);
    }];
}

- (void)setModel:(JYFormModel *)model {
    [super setModel:model];
    for (int i = 0; i < model.optionArray.count; i ++) {
        JYKeyValueModel *tempModel = model.optionArray[i];
        if (tempModel.isSelected) {
            self.model.contentString = tempModel.itemId;
            break;
        }
    }
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(0);
        make.height.offset(model.optionArray.count * 50);
    }];
}

#pragma mark -------------------- UITableViewDelegate & DataSource --------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.optionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYFormCell_RadioSelectInnerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_RadioSelectInnerCell class])];
    cell.model = self.model.optionArray[indexPath.row];
    weakSelf(self)
    cell.radioReturnBlock = ^(NSInteger num) {
        weakSelf.model.contentString = ((JYKeyValueModel *)weakSelf.model.optionArray[num]).itemId;
        NSArray *array = weakSelf.model.optionArray;
        for (int i = 0; i < array.count; i ++) {
            JYKeyValueModel *model = array[i];
            if (i == num) {
                model.isSelected = true;
            } else {
                model.isSelected = false;
            }
        }
        [weakSelf.tableView reloadData];
    };
    cell.row = indexPath.row;
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JYFormCell_RadioSelectInnerCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_RadioSelectInnerCell class])];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

@end
