//
//  JYFormCell.m
//  iOS
//
//  Created by JackYoung on 2021/1/27.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYFormCell.h"
#import "JYFormModel.h"

@interface JYFormCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UIImageView *selectImage;
@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation JYFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createUI{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewDidChangeValue:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.inputTextField];
    
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
    
    [self.contentView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(26);
        make.left.equalTo(self.starLabel.mas_right).offset(10);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.top.offset(12);
        make.left.equalTo(self.starLabel.mas_right).offset(10);
        make.height.mas_greaterThanOrEqualTo(26);
        make.bottom.offset(-12);
    }];
        
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.left.offset(15);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentLabel.mas_bottom).offset(12);
    }];
}

- (void)setModel:(JYFormModel *)model {
    _model = model;
    if (model.style == JYFormModelCellStyleSelectShow) {
        model.isSelectable = true;
        model.isEditable = false;
        self.contentLabel.hidden = true;
        self.contentLabel.text = @"    ";
        self.inputTextField.hidden = false;
    } else if (model.style == JYFormModelCellStyleInputTextField) {
        model.isSelectable = false;
        model.isEditable = true;
        self.contentLabel.hidden = true;
        self.contentLabel.text = @"    ";
        self.inputTextField.hidden = false;
    } else if (model.style == JYFormModelCellStyleShowOnly) {
        model.isSelectable = false;
        model.isEditable = false;
        self.contentLabel.hidden = false;
        self.inputTextField.hidden = true;
    }
    self.inputTextField.keyboardType = model.keyboardType;
    self.starLabel.hidden = !model.isMust;
    if (model.title != nil) {
        self.titleLabel.text = model.title;
    } else {
        self.titleLabel.text = @"";
    }
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset([self.titleLabel.text widthForFont:self.titleLabel.font]);
    }];
    
    if (model.placeHolder != nil && ![model.placeHolder isEqualToString:@""]) {
        self.inputTextField.placeholder = model.contentString;
    }
    //优先显示contentDisplay，如果没有的话，显示contentString
    if (model.style == JYFormModelCellStyleShowOnly) {
        if (model.contentDisplay != nil && ![model.contentDisplay isEqualToString:@""]) {
            self.contentLabel.text = model.contentDisplay;
        } else if (model.contentString != nil && ![model.contentString isEqualToString:@""]){
            self.contentLabel.text = model.contentString;
        } else {
            self.contentLabel.text = @"--";
        }
    } else {
        if (model.contentDisplay != nil && ![model.contentDisplay isEqualToString:@""]) {
            self.inputTextField.text = model.contentDisplay;
        } else if (model.contentString != nil && ![model.contentString isEqualToString:@""]){
            self.inputTextField.text = model.contentString;
        } else if (model.isSelectable) {
            self.inputTextField.text = @"请选择";
        } else {
            self.inputTextField.text = @"";
        }
    }
    
    if (model.isSelectable) {
        self.inputTextField.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.inputTextField.rightViewMode = UITextFieldViewModeNever;
    }
    
    if (model.isEditable) {
        self.inputTextField.userInteractionEnabled = true;
    } else {
        self.inputTextField.userInteractionEnabled = false;
    }
}

#pragma mark ------------ textField delegate -------------------------
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.inputReturnBlock != nil) {
        self.inputReturnBlock(textField.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) { // 没有高亮选择的字
        if ((range.location > self.model.inputMaxLength - 1) && ![string isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"只能输入%ld位字符",self.model.inputMaxLength]];
            return NO;
        }
        return true;
    }
    return true;
}

- (void)textViewDidChangeValue:(NSNotification *)notification {
    UITextField *textField = (UITextField *)notification.object;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) { //没有高亮选择的字
        if (textField.text.length > self.model.inputMaxLength) {
            textField.text = [textField.text substringToIndex:self.model.inputMaxLength];
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat: @"只能输入%ld位字符",self.model.inputMaxLength]];
        }
    }
}

#pragma mark ------------ 懒加载 -------------------------
- (UIView *)bottomLine {
    if(!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    return _bottomLine;
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
        _titleLabel.textColor = [UIColor colorWithHexString:@"#303133"];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UITextField *)inputTextField {
    if(!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.textColor = [UIColor colorWithHexString:@"#606266"];
        _inputTextField.font = [UIFont systemFontOfSize:14];
        _inputTextField.text = @"请选择";
        _inputTextField.placeholder = @"请输入";
        _inputTextField.delegate = false;
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        rightImageView.image = [UIImage imageNamed:@"rightArrow"];
        _inputTextField.rightView = rightImageView;
        _inputTextField.rightViewMode = UITextFieldViewModeAlways;
        _inputTextField.delegate = self;
        _inputTextField.textAlignment = NSTextAlignmentRight;
    }
    return _inputTextField;
}

- (UILabel *)contentLabel {
    if(!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"这里是内容";
        _contentLabel.textColor = [UIColor colorWithHexString:@"#303133"];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
