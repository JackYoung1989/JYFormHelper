//
//  JYFormCell_GrayBarWithTitle.m
//  JackYoung
//
//  Created by 魏魏 on 2021/2/24.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_GrayBarWithTitle.h"

@interface JYFormCell_GrayBarWithTitle ()

@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) JYButton *rightBtn;
@property (nonatomic, weak) UIView *grayBar;

@end

@implementation JYFormCell_GrayBarWithTitle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIView *grayBar = [[UIView alloc] init];
    grayBar.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    [self.contentView addSubview:grayBar];
    [grayBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    self.grayBar = grayBar;
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.textColor = [UIColor colorWithHexString:@"#909399"];
    [grayBar addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
    }];
    self.descLabel = descLabel;
    
    JYButton *rightBtn = [JYButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [grayBar addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.equalTo(grayBar);
    }];
    rightBtn.hidden = true;
    self.rightBtn = rightBtn;
}

- (void)rightBtnClick
{
    if (self.btnClickBlock) {
        self.btnClickBlock(self.model);
    }
}

- (void)setModel:(JYFormModel *)model
{
    [super setModel:model];
    
    self.descLabel.text = model.contentDisplay;
    if ([JYEasyCodeHelper isNotEmpty:model.grayBarWithTitleColor]) {
        self.descLabel.textColor = model.grayBarWithTitleColor;
    }
    else {
        self.descLabel.textColor = [UIColor colorWithHexString:@"#909399"];
    }
    
    if ([JYEasyCodeHelper isNotEmpty:model.grayBarWithTitleFont]) {
        self.descLabel.font = model.grayBarWithTitleFont;
    }
    else {
        self.descLabel.font = [UIFont systemFontOfSize:13];
    }
    
    if ([JYEasyCodeHelper isNotEmpty:model.grayBarWithTitleRightImage]) {
        [self.rightBtn setImage:model.grayBarWithTitleRightImage forState:UIControlStateNormal];
        self.rightBtn.hidden = false;
    }
    else {
        [self.rightBtn setImage:[UIImage new] forState:UIControlStateNormal];
        self.rightBtn.hidden = true;
    }
}

@end
