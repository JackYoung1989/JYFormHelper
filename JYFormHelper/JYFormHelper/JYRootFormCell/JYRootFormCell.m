//
//  JYRootFormCell.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/6.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYRootFormCell.h"

@implementation JYRootFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self rootCreateUI];
    }
    return self;
}

- (void)rootCreateUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(26);
    }];
    
    [self.contentView addSubview:self.starLabel];
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.mas_right);
        make.width.offset(10);
        make.height.offset(16);
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.titleLabel);
        self.subTitleLabelBottomConstraint = make.bottom.mas_equalTo(-12);
    }];
    [self.subTitleLabelBottomConstraint uninstall];
    self.subTitleLabel.hidden = true;
}

- (void)setModel:(JYFormModel *)model {
    _model = model;
    if (model.backgroundColor) {
        self.contentView.backgroundColor = model.backgroundColor;
    }
    self.starLabel.hidden = !model.isMust;
    if (model.title != nil) {
        self.titleLabel.text = model.title;
    } else {
        self.titleLabel.text = @"";
    }
    
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    } else {
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#202224"];
    }
    
    if (!self.model.isHaveSubTitle) {
        self.subTitleLabel.hidden = true;
        self.subTitleLabel.text = @"";
        [self.subTitleLabelBottomConstraint uninstall];
    }
    else {
        self.subTitleLabel.hidden = false;
        self.subTitleLabel.text = self.model.subTitleString;
    }
    
    self.titleLabel.hidden = self.model.isHiddenTitle;
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset([self.titleLabel.text widthForFont:self.titleLabel.font] + 1);
    }];
}

- (UILabel *)starLabel {
    if(!_starLabel) {
        _starLabel = [[UILabel alloc] init];
        _starLabel.text = @"*";
        _starLabel.textColor = [UIColor colorWithHexString:@"#EB4F6A"];
        _starLabel.font = [UIFont systemFontOfSize:16];
    }
    return _starLabel;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"开始时间";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#202224"];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.text = @"";
        _subTitleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _subTitleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _subTitleLabel;
}

@end
