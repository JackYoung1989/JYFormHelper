//
//  JYPersonSelectCell.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/3/21.
//

#import "JYPersonSelectCell.h"

@interface JYPersonSelectCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *radioButton;
@property (nonatomic, strong) UIImageView *companyImageView;

@end

@implementation JYPersonSelectCell

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
    
    [self.contentView addSubview:self.companyImageView];
    [self.companyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(12);
        make.width.offset(40);
        make.height.offset(40);
        make.bottom.offset(-12);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.companyImageView.mas_right).offset(10);
        make.right.offset(-60);
        make.centerY.equalTo(self.companyImageView);
        make.height.offset(20);
    }];

    [self.contentView addSubview:self.radioButton];
    [self.radioButton addTarget:self action:@selector(onRadioButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.radioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(0);
        make.height.width.offset(50);
    }];
}

- (void)onRadioButtonTouched:(UIButton *)button {
    if (self.radioReturnBlock) {
        self.radioReturnBlock(self.row, !button.isSelected);
    }
}

- (void)setModel:(JYKeyValueModel *)model {
    _model = model;
    self.titleLabel.text = model.name;
    self.radioButton.selected = model.isSelected;
    [self.companyImageView setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholder:AvatorPlaceHolderImge];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"客户管理";
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"#303133"]];
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

- (UIImageView *)companyImageView {
    if (_companyImageView == nil) {
        _companyImageView = [[UIImageView alloc] init];
        _companyImageView.layer.cornerRadius = 5;
        _companyImageView.clipsToBounds = true;
        _companyImageView.backgroundColor = UIColor.greenColor;
    }
    return _companyImageView;
}

@end
