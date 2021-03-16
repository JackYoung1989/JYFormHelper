//
//  JYFormCell_SectionHeaderTitleLabel.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/1.
//

#import "JYFormCell_SectionHeaderTitleLabel.h"

@interface JYFormCell_SectionHeaderTitleLabel()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JYFormCell_SectionHeaderTitleLabel

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
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
}

- (void)setModel:(JYFormModel *)model {
    self.titleLabel.text = model.title;
    if (model.backgroundColor) {
        self.contentView.backgroundColor = model.backgroundColor;
    }
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

@end
