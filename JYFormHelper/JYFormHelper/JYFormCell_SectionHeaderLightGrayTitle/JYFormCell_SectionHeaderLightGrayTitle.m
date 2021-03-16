//
//  JYFormCell_SectionHeaderTitleLabel.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/1.
//

#import "JYFormCell_SectionHeaderLightGrayTitle.h"

@interface JYFormCell_SectionHeaderLightGrayTitle()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation JYFormCell_SectionHeaderLightGrayTitle

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
        make.left.offset(16);
        make.top.offset(18);
        make.bottom.offset(-10);
        make.right.offset(-16);
        make.height.offset(18);
    }];
    
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.left.offset(0);
        make.height.mas_equalTo(0.5);
        make.bottom.offset(0);
    }];
}

- (void)setModel:(JYFormModel *)model {
    self.titleLabel.text = model.title;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"客户管理";
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"#909399"]];
    }
    return _titleLabel;
}

- (UIView *)bottomLine {
    if(!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    return _bottomLine;
}

@end
