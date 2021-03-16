//
//  JYFormCell_SelectPersonDetailShowMode_InnerCell.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/23.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectPersonDetailShowMode_InnerCell.h"

@interface JYFormCell_SelectPersonDetailShowMode_InnerCell()

@property (nonatomic, strong)UIImageView *headerImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *moreLabel;

@end

@implementation JYFormCell_SelectPersonDetailShowMode_InnerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#909399"]]];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.layer.cornerRadius = 5;
    _headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(40);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"姓名";
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = [UIColor colorWithHexString:@"#606266"];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_bottom).offset(8);
        make.centerX.equalTo(self.headerImageView);
    }];
    
    _moreLabel = [[UILabel alloc] init];
    _moreLabel.text = @"";
    _moreLabel.font = [UIFont systemFontOfSize:14];
    _moreLabel.layer.cornerRadius = 5;
    _moreLabel.layer.masksToBounds = YES;
    _moreLabel.hidden = YES;
    _moreLabel.textColor = [UIColor whiteColor];
    _moreLabel.backgroundColor = UIColor.darkGrayColor;
    _moreLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_moreLabel];
    [_moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(40);
    }];
}

- (void)setModel:(JYPersonModel *)model {
    self.nameLabel.text = model.userName;
    self.moreLabel.text = model.totalPersonCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.userHeadUrl] placeholderImage:AvatorPlaceHolderImge];
    if (self.cellType == PersonDetailsCellStyle_More) {
        self.headerImageView.backgroundColor = [UIColor darkGrayColor];
        [self.headerImageView setImage:nil];
        self.moreLabel.hidden = false;
        self.nameLabel.text = @"更多";
    } else {
        self.headerImageView.backgroundColor = [UIColor redColor];
        self.moreLabel.hidden = true;
    }
}

- (void)setCellType:(PersonDetailsCellStyle)cellType {
    _cellType = cellType;
    if (cellType == PersonDetailsCellStyle_More) {
        self.headerImageView.backgroundColor = [UIColor darkGrayColor];
        [self.headerImageView setImage:nil];
        self.moreLabel.hidden = false;
        self.nameLabel.text = @"更多";
    } else {
        self.headerImageView.backgroundColor = [UIColor redColor];
        self.moreLabel.hidden = true;
    }
}

@end
