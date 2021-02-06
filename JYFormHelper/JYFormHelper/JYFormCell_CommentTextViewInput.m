//
//  JYFormCell_CommentTextViewInput.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/1.
//

#import "JYFormCell_CommentTextViewInput.h"

@interface JYFormCell_CommentTextViewInput()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;

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
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(15);
        make.right.offset(-16);
        make.height.offset(18);
    }];
    
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.right.offset(-16);
        make.height.offset(68);
        make.bottom.offset(-17);
    }];
}

- (void)setModel:(JYFormModel *)model {
    self.titleLabel.text = model.title;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"备注";
        [_titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"#202224"]];
    }
    return _titleLabel;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.text = @"请填写";
        [_textView setFont:[UIFont systemFontOfSize:16]];
        [_textView setTextColor:[UIColor colorWithHexString:@"#B5B9C6"]];
    }
    return _textView;
}

@end
