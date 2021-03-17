//
//  JYFormCell.m
//  iOS
//
//  Created by JackYoung on 2021/1/27.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYFormCell.h"
#import "JYFormModel.h"
#import "BRPickerView.h"

@interface JYFormCell()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UIImageView *selectImage;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *selectOnlyButton;//仅仅用在是select类型的cell上

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
    
    [self.contentView addSubview:self.selectOnlyButton];
    [self.selectOnlyButton addTarget:self action:@selector(onSelectOnlyButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectOnlyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)onSelectOnlyButtonTouched:(UIButton *)button {
    if (self.model.optionArray && self.model.optionArray.count > 0) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        JYKeyValueModel *defaultSelectedModel;
        NSInteger defaultSelectIndex = 0;
        for (int i = 0; i < self.model.optionArray.count; i ++) {
            JYKeyValueModel *model = self.model.optionArray[i];
            [tempArray addObject:model.name];
            if (model.isSelected) {
                defaultSelectedModel = model;
                defaultSelectIndex = i;
            }
        }
        [BRStringPickerView showPickerWithTitle:@"请选择" dataSourceArr:tempArray selectIndex:defaultSelectIndex resultBlock:^(BRResultModel * _Nullable resultModel) {
            NSLog(@"%@",self.model);
            self.model.contentDisplay = resultModel.value;
            NSArray *tempArray = self.model.optionArray;
            for (JYKeyValueModel *model in tempArray) {
                if ([model.name isEqualToString:resultModel.value]) {
                    self.model.contentString = model.itemId;
                    if (self.refreshBlock) {
                        self.refreshBlock();
                    }
                    break;
                }
            }
        }];
    }
}

- (void)setModel:(JYFormModel *)model {
    [super setModel:model];
    
    self.bottomLine.hidden = model.isBottomLineHidden;
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.top.offset(12);
        make.left.equalTo(self.starLabel.mas_right).offset(10);
        make.height.mas_greaterThanOrEqualTo(26);
        make.bottom.offset(-12);
    }];
    
    if (model.style == JYFormModelCellStyle_SelectShow) {
        model.isSelectable = true;
        model.isNotEditable = true;
        self.contentLabel.hidden = true;
        self.contentLabel.text = @"    ";
        self.inputTextField.hidden = false;
    } else if (model.style == JYFormModelCellStyle_InputTextField) {
        model.isSelectable = false;
//        model.isEditable = true;
        self.contentLabel.hidden = true;
        self.contentLabel.text = @"    ";
        self.inputTextField.hidden = false;
    } else if (model.style == JYFormModelCellStyle_ShowOnly) {
        model.isSelectable = false;
        model.isNotEditable = true;
        self.contentLabel.hidden = false;
        self.inputTextField.hidden = true;
    }
    //selectOnlyButton只有当optionArray里面有选项的时候才能用到。
//    if (model.style == JYFormModelCellStyle_SelectShow && (model.optionArray.count > 0 || [model.title isEqualToString:@"关联企业"] || [model.title isEqualToString:@"关联项目"])) {
    if (model.style == JYFormModelCellStyle_SelectShow && (model.optionArray.count > 0 || [model.title isEqualToString:@"关联企业"])) {
        self.selectOnlyButton.hidden = false;
    } else {
        self.selectOnlyButton.hidden = true;
    }
    self.inputTextField.keyboardType = model.keyboardType;
    
    if (model.placeHolder != nil && ![model.placeHolder isEqualToString:@""]) {
        self.inputTextField.placeholder = model.placeHolder;
    }
    //优先显示contentDisplay，如果没有的话，显示contentString
    if (model.style == JYFormModelCellStyle_ShowOnly) {
        if (model.contentDisplay != nil && ![model.contentDisplay isEqualToString:@""]) {
            self.contentLabel.text = model.contentDisplay;
            self.contentLabel.font = [UIFont systemFontOfSize:16];
            self.contentLabel.textColor = [UIColor colorWithHexString:@"#202224"];
        } else if (model.contentString != nil && ![model.contentString isEqualToString:@""]){
            self.contentLabel.text = model.contentString;
            self.contentLabel.font = [UIFont systemFontOfSize:16];
            self.contentLabel.textColor = [UIColor colorWithHexString:@"#202224"];
        } else if (model.placeHolder != nil && ![model.placeHolder isEqualToString:@""]){
            self.contentLabel.text = model.placeHolder;
            self.contentLabel.font = [UIFont systemFontOfSize:14];
            self.contentLabel.textColor = [UIColor colorWithHexString:@"#909399"];
        } else {
            self.contentLabel.text = @"--";
            self.contentLabel.font = [UIFont systemFontOfSize:16];
            self.contentLabel.textColor = [UIColor colorWithHexString:@"#202224"];
        }
        
        //判断左对齐还是右对齐。
        if (model.showTextAlignment == NSTextAlignmentRight) {
            self.contentLabel.textAlignment = NSTextAlignmentRight;
        } else {
            self.contentLabel.textAlignment = NSTextAlignmentLeft;
        }
        //判断如果内容超过一行，textAlignment = left，否则，=right；
//        CGFloat contentLabelWidth = KScreenWidth - 16 - 10 - 90 - 9;
//        if ([CommonFunction getStrHeight:self.contentLabel.text Font:self.contentLabel.font MaxWidth:contentLabelWidth] > 25) {//多于一行
//            self.contentLabel.textAlignment = NSTextAlignmentLeft;
//        } else {
//            self.contentLabel.textAlignment = NSTextAlignmentRight;
//        }
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
    
    if (!model.isNotEditable) {
        self.inputTextField.userInteractionEnabled = true;
    } else {
        self.inputTextField.userInteractionEnabled = false;
    }
    
    if (!kStringIsEmpty(model.rightSelectButtonImage)) {
        UIImageView *imageView = (UIImageView *)self.inputTextField.rightView;
        imageView.image = [UIImage imageNamed:model.rightSelectButtonImage];
        self.inputTextField.text = @"";
        self.inputTextField.placeholder = @"";
    }
    else {
        UIImageView *imageView = (UIImageView *)self.inputTextField.rightView;
        imageView.image = [UIImage imageNamed:@"rightArrow"];
        self.inputTextField.placeholder = model.placeHolder;
    }
}

#pragma mark ------------ textField delegate -------------------------
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.model.contentString = textField.text;
}

- (void)textViewDidChangeValue:(NSNotification *)notification {
    UITextField *textField = (UITextField *)notification.object;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) { //没有高亮选择的字
        if (self.model.inputMaxLength != 0 && textField.text.length > self.model.inputMaxLength) {
            textField.text = [textField.text substringToIndex:self.model.inputMaxLength];
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat: @"只能输入%ld位字符",self.model.inputMaxLength]];
        }
    }
}

#pragma mark ------------ 懒加载 -------------------------
- (UIView *)bottomLine {
    if(!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    }
    return _bottomLine;
}

- (UITextField *)inputTextField {
    if(!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.textColor = [UIColor colorWithHexString:@"#606266"];
        _inputTextField.font = [UIFont systemFontOfSize:14];
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
        _contentLabel.textColor = [UIColor colorWithHexString:@"#202224"];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIButton *)selectOnlyButton {
    if (!_selectOnlyButton) {
        _selectOnlyButton = [[UIButton alloc] init];
        _selectOnlyButton.backgroundColor = [UIColor clearColor];
    }
    return _selectOnlyButton;
}

@end
