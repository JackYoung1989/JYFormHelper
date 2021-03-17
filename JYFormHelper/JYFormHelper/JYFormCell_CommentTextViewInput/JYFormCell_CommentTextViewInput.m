//
//  JYFormCell_CommentTextViewInput.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/1.
//

#import "JYFormCell_CommentTextViewInput.h"
#import "FSTextView.h"

@interface JYFormCell_CommentTextViewInput()

@property (nonatomic, strong) FSTextView *textView;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation JYFormCell_CommentTextViewInput

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
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.descLabel];
    weakSelf(self)
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(22);
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.textView addTextDidChangeHandler:^(FSTextView *textView) {
        weakSelf.model.contentString = textView.text;
    }];
    [self.textView addTextLengthDidMaxHandler:^(FSTextView *textView) {
        if (weakSelf.model.inputMaxLength != 0) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"最多输入%ld个字符",weakSelf.model.inputMaxLength]];
        }
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(11);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.right.offset(-16);
        make.height.offset(90);
        make.bottom.offset(-17);
    }];
}

- (void)setModel:(JYFormModel *)model {
    [super setModel:model];
    
    if ([JYEasyCodeHelper isNotEmpty:model.contentString]) {
        self.textView.text = model.contentString;
    } else {
        self.textView.text = @"";
    }
    
    self.descLabel.text = model.descString;
    
    if (model.placeHolder && ![model.placeHolder isEqualToString:@""]) {
        self.textView.placeholder = model.placeHolder;
    } else {
        self.textView.placeholder = @"请输入";
    }
    self.textView.maxLength = model.inputMaxLength;
    
    if (model.isHaveSubTitle) {
        [self.subTitleLabelBottomConstraint uninstall];
        [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(11);
            make.top.equalTo(self.subTitleLabel.mas_bottom).offset(0);
            make.right.offset(-16);
            make.height.offset(90);
            make.bottom.offset(-17);
        }];
    }
    else {
        [self.subTitleLabelBottomConstraint uninstall];
        [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(11);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
            make.right.offset(-16);
            make.height.offset(90);
            make.bottom.offset(-17);
        }];
    }
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[FSTextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:16]];
        [_textView setTextColor:[UIColor colorWithHexString:@"#202224"]];
    }
    return _textView;
}

- (UILabel *)descLabel
{
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _descLabel;
}
@end
