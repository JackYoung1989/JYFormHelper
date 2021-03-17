//
//  JYFormCell_LabelSwitch.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/7.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_LabelSwitch.h"

@interface JYFormCell_LabelSwitch()

@property (nonatomic, strong) UISwitch *mySwitch;

@end

@implementation JYFormCell_LabelSwitch

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
    [self.contentView addSubview:self.mySwitch];
    [self.mySwitch addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.bottom.offset(-9);
        make.right.offset(-16);
    }];
}

- (void)onSwitchValueChanged:(UISwitch *)mySwitch {
    NSLog(@"%d",mySwitch.isOn);
    NSArray *optionsArray = self.model.optionArray;
    for (int i = 0; i < optionsArray.count; i ++) {
        JYKeyValueModel *model = optionsArray[i];
        model.isSelected = false;
        
        //选中状态
        if (mySwitch.isOn && [model.name isEqualToString:@"on"]) {
            model.isSelected = true;
            if (self.isSwitchOnBlock) {
                self.isSwitchOnBlock(true, mySwitch);
            }
        }
        
        //非选中状态
        if (!mySwitch.isOn && [model.name isEqualToString:@"off"]) {
            self.model.contentString = model.itemId;
            model.isSelected = true;
            if (self.isSwitchOnBlock) {
                self.isSwitchOnBlock(false, mySwitch);
            }
        }
    }
}

- (void)setModel:(JYFormModel *)model {
    [super setModel:model];
    self.titleLabel.text = model.title;
    NSArray *optionArray = self.model.optionArray;
    JYKeyValueModel *selectedModel;
    JYKeyValueModel *defaultSelectedModel;
    for (int i = 0; i < optionArray.count; i ++) {
        JYKeyValueModel *model = optionArray[i];
        if (model.isSelected) {
            selectedModel = model;
        }
        if ([model.name isEqualToString:@"off"]) {//默认关闭switch
            defaultSelectedModel = model;
        }
    }
    if (selectedModel) {
        if ([selectedModel.name isEqualToString:@"on"]) {
            [self.mySwitch setOn:true];
        } else {
            [self.mySwitch setOn:false];
        }
        self.model.contentString = selectedModel.itemId;
    } else if (defaultSelectedModel) {
        [self.mySwitch setOn:false];
        self.model.contentString = defaultSelectedModel.itemId;
    }
    
    if (model.isHaveSubTitle) {
        [self.subTitleLabelBottomConstraint install];
        [self.mySwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.offset(-16);
        }];
    }
    else {
        [self.subTitleLabelBottomConstraint uninstall];
        [self.mySwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.bottom.offset(-9);
            make.right.offset(-16);
        }];
    }
}

- (UISwitch *)mySwitch {
    if (_mySwitch == nil) {
        _mySwitch = [[UISwitch alloc] init];
//        _mySwitch.thumbTintColor = [UIColor colorWithHexString:@"#1E72FF"];
        _mySwitch.onTintColor = [UIColor colorWithHexString:@"#1E72FF"];
        _mySwitch.on = true;
    }
    return _mySwitch;
}

@end
