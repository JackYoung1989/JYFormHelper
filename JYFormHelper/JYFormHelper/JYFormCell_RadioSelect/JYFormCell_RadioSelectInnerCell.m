//
//  JYFormCell_RadioSelectInnerCell.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/8.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_RadioSelectInnerCell.h"

@interface JYFormCell_RadioSelectInnerCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *radioButton;

@end

@implementation JYFormCell_RadioSelectInnerCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(-60);
        make.top.offset(0);
        make.height.offset(50);
        make.bottom.offset(0);
    }];

    [self.contentView addSubview:self.radioButton];
    [self.radioButton addTarget:self action:@selector(onRadioButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.radioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(0);
        make.height.width.offset(50);
    }];
}

- (void)onRadioButtonTouched {
    if (self.radioReturnBlock) {
        self.radioReturnBlock(self.row);
    }
}

- (void)setModel:(JYKeyValueModel *)model {
    _model = model;
    self.titleLabel.text = model.name;
    self.radioButton.selected = model.isSelected;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"客户管理";
        [_titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"#202224"]];
    }
    return _titleLabel;
}

- (UIButton *)radioButton {
    if (_radioButton == nil) {
        _radioButton = [[UIButton alloc] init];
        [_radioButton setImage:[UIImage imageNamed:@"radio_unSelected"] forState:UIControlStateNormal];
        [_radioButton setImage:[UIImage imageNamed:@"radio_Selected"] forState:UIControlStateSelected];
    }
    return _radioButton;
}

@end
