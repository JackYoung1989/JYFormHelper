//
//  JYFormCellMultiLineInformationCell.m
//  JackYoung
//
//  Created by 魏魏 on 2021/3/6.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCellMultiLineInformationCell.h"
#import "JYFormCell.h"
#import "JYFormCell_GrayBarWithTitle.h"

@interface JYFormCellMultiLineInformationCell () <UITableViewDelegate,UITableViewDataSource,UIDocumentPickerDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation JYFormCellMultiLineInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.offset(0);
        make.right.offset(-0);
        make.height.mas_equalTo(50 * 6);
        make.bottom.offset(-0);
    }];
}

- (void)setModel:(JYFormModel *)model
{
    _model = model;
    [self.tableView reloadData];
}

#pragma mark --------- UITabelViewDelegate & DataSource ------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        JYFormCell_GrayBarWithTitle *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_GrayBarWithTitle class])];
        cell.model = self.model;
        @weakify(self);
        cell.btnClickBlock = ^(JYFormModel * _Nonnull model) {
            @strongify(self);
            if (self.deleteBtnClickBlock) {
                self.deleteBtnClickBlock(model);
            }
        };
        return cell;
    } else {
        JYFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell class])];
        cell.model = self.model.multilineArray[indexPath.row - 1];
        return cell;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JYFormCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell class])];
        [_tableView registerClass:[JYFormCell_GrayBarWithTitle class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_GrayBarWithTitle class])];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.clipsToBounds = true;
        _tableView.scrollEnabled = false;
    }
    return _tableView;
}

@end
