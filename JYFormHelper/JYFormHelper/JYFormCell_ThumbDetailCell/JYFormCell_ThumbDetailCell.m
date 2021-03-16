//
//  JYFormCell_ThumbDetailCell.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/23.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_ThumbDetailCell.h"
#import "JYKeyValueModel.h"

@interface JYFormCell_ThumbDetailCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *thumbImageView;

@end

@implementation JYFormCell_ThumbDetailCell

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
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.top.offset(0);
    }];
    
    [self.contentView addSubview:self.thumbImageView];
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.centerY.offset(0);
        make.height.offset(18);
        make.width.offset(18);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumbImageView.mas_right).offset(5);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.right.offset(-16);
        make.height.offset(18);
    }];
}

- (void)setModel:(JYFormModel *)model {
    if (model.backgroundColor) {
        self.contentView.backgroundColor = model.backgroundColor;
    }
    NSMutableString *tempString = [[NSMutableString alloc] init];
    for (int i = 0; i < model.optionArray.count; i ++) {
        JYKeyValueModel *tempModel = model.optionArray[i];
        if (i == 3) {
            break;
        }
        if (i == model.optionArray.count - 1) {
            [tempString appendFormat:@"%@",tempModel.name];
        } else {
            [tempString appendFormat:@"%@、",tempModel.name];
        }
    }
    
    if (model.optionArray.count > 3) {
        [tempString appendFormat:@"等%ld人点赞",model.optionArray.count];
    } else {
        [tempString appendString:@"点赞"];
    }
    self.titleLabel.text = tempString;
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

- (UIImageView *)thumbImageView {
    if (_thumbImageView == nil) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.image = [UIImage imageNamed:@"Report_hb_yizan"];
    }
    return _thumbImageView;
}

@end
