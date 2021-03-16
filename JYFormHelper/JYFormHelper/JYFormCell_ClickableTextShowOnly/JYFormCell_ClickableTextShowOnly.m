//
//  JYFormCell_ClickableTextShowOnly.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/18.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_ClickableTextShowOnly.h"
#import <YYLabel.h>

@interface JYFormCell_ClickableTextShowOnly()

@property (nonatomic, strong) YYLabel *contentLabel;
@property (nonatomic, strong) NSMutableArray *rangeArray;

@end

@implementation JYFormCell_ClickableTextShowOnly

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.rangeArray = [[NSMutableArray alloc] init];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.top.offset(12);
        make.left.equalTo(self.starLabel.mas_right).offset(10);
        make.height.mas_greaterThanOrEqualTo(26);
        make.bottom.offset(-12);
    }];
}

- (void)setModel:(JYFormModel *)model {
    [super setModel:model];
    [self setAttributedStringWithModel];
    if (model.isHaveSubTitle) {
        [self.subTitleLabelBottomConstraint install];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-16);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.starLabel.mas_right).offset(10);
            make.height.mas_greaterThanOrEqualTo(26);
        }];
    }
    else {
        [self.subTitleLabelBottomConstraint uninstall];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-16);
            make.top.offset(12);
            make.left.equalTo(self.starLabel.mas_right).offset(10);
            make.height.mas_greaterThanOrEqualTo(26);
            make.bottom.offset(-12);
        }];
    }
}

/**
 传入的model.optionArray中的各个元素name值不能为@“”或者nil
 */
- (void)setAttributedStringWithModel {
    //自适应高度,求宽度
    CGFloat attributedLabelWidth = 0;
    if (self.model.title && ![self.model.title isEqualToString:@""]) {
        CGFloat titleWidth = [JYEasyCodeHelper getStringWidth:self.model.title Font:self.titleLabel.font MaxHeight:MAXFLOAT];
        attributedLabelWidth = kScreenWidth - titleWidth - 2 * 16 - 25;
    }
    
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int i = 0; i < self.model.optionArray.count; i ++) {
        JYKeyValueModel *model = self.model.optionArray[i];
        if (model.name && ![model.name isEqualToString:@""]) {
            [string appendString:model.name];
        } else {
            return;
        }
    }
    
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString:string];
    text.lineSpacing = 10;
    text.font = [UIFont systemFontOfSize:16];
    text.color = [UIColor colorWithHexString:@"#303133"];
    
    //给每个option添加点击时间
    NSInteger location = 0;
    for (int i = 0; i < self.model.optionArray.count; i ++) {
        JYKeyValueModel *model = self.model.optionArray[i];
        UIColor *tempColor = [UIColor colorWithHexString:@"#1E72FF"];
        NSRange range = NSMakeRange(location, model.name.length);
        [self.rangeArray addObject:[NSNumber numberWithInteger:location]];
        [text setTextHighlightRange:range color:tempColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            for (int i = 0; i < self.rangeArray.count; i ++) {
                NSNumber *number = self.rangeArray[i];
                if (number.integerValue == range.location) {
                    NSLog(@"点击了第%d个item",i);
                    if (self.didClickModelBlock) {
                        self.didClickModelBlock(self.model.optionArray[i], self.model.title);
                    }
                    break;
                }
            }
        }];
        location = location + model.name.length;
    }
    
    self.contentLabel.preferredMaxLayoutWidth = attributedLabelWidth;//最大宽度
    self.contentLabel.attributedText = text;
}

- (YYLabel *)contentLabel {
    if(!_contentLabel) {
        _contentLabel = [[YYLabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#303133"];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
