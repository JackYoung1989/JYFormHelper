//
//  JYFormCell_SelectPersonInnerCell.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/10.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectPersonInnerCell.h"

@interface JYFormCell_SelectPersonInnerCell()

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIButton *deleteButton;
@property (nonatomic, strong)UIButton *addPersonButton;
@property (nonatomic, strong)UILabel *personCountLabel;

@end

@implementation JYFormCell_SelectPersonInnerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.left.offset(5);
            make.right.offset(-5);
            make.height.offset(40);
            make.width.offset(40);
        }];
        
        [self.imageView addSubview:self.personCountLabel];
        [self.personCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
            make.width.offset(40);
            make.height.offset(12);
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(8);
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(12);
            make.bottom.offset(0);
        }];
        
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton addTarget:self action:@selector(onDeleteButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_top).offset(-20);
            make.right.equalTo(self.imageView.mas_right).offset(20);
            make.width.height.offset(40);
        }];
        
        [self.contentView addSubview:self.addPersonButton];
        [self.addPersonButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.left.offset(5);
            make.right.offset(-5);
            make.height.offset(40);
            make.width.offset(40);
        }];
    }
    return self;
}

- (void)setPersonModel:(JYFormCell_SelectPersonModel *)personModel {
    self.nameLabel.text = kStringIsEmpty(personModel.userName) ? personModel.employeeName : personModel.userName;
    if (self.cellType == JYFormCell_SelectPersonInnerCellTypeMore) {
        [self.imageView setImage:[UIImage imageWithColor:[UIColor darkGrayColor]]];
        self.nameLabel.text = @"更多";
    } else {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:personModel.userHeadUrl] placeholderImage:AvatorPlaceHolderImge];
    }
}

- (void)setTotalCount:(NSInteger)totalCount {
    _totalCount = totalCount;
    self.personCountLabel.text = [NSString stringWithFormat:@"%ld人",totalCount];
}

- (void)onDeleteButtonTouched {
    if (self.deleteItemWithIndexBlock) {
        self.deleteItemWithIndexBlock(self.itemIndex);
    }
}

- (void)setCellType:(JYFormCell_SelectPersonInnerCellType)cellType {
    _cellType = cellType;
    if (cellType == JYFormCell_SelectPersonInnerCellTypeShowPerson) {
        self.addPersonButton.hidden = true;
        self.imageView.hidden = false;
        self.nameLabel.hidden = false;
        self.deleteButton.hidden = false;
        self.personCountLabel.hidden = true;
    } else if (cellType == JYFormCell_SelectPersonInnerCellTypeAdd) {
        self.addPersonButton.hidden = false;
        self.imageView.hidden = true;
        self.nameLabel.hidden = true;
        self.deleteButton.hidden = true;
        self.personCountLabel.hidden = true;
    } else {//更多
        self.addPersonButton.hidden = true;
        self.imageView.hidden = false;
        self.nameLabel.hidden = false;
        self.deleteButton.hidden = true;
        self.personCountLabel.hidden = false;
    }
    
    if (self.cellType == JYFormCell_SelectPersonInnerCellTypeMore) {
        [self.imageView setImage:[UIImage imageWithColor:[UIColor darkGrayColor]]];
        self.nameLabel.text = @"更多";
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 3;
        _imageView.clipsToBounds = true;
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#606266"];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)personCountLabel {
    if (!_personCountLabel) {
        _personCountLabel = [[UILabel alloc] init];
        _personCountLabel.textColor = UIColor.whiteColor;
        _personCountLabel.font = [UIFont systemFontOfSize:12];
        _personCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _personCountLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_delete_button"] forState:UIControlStateNormal];
        [_deleteButton setImageEdgeInsets:UIEdgeInsetsMake(8, -8, 0, 0)];
    }
    return _deleteButton;
}
    
- (UIButton *)addPersonButton {
    if (!_addPersonButton) {
        _addPersonButton = [[UIButton alloc] init];
        [_addPersonButton setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        _addPersonButton.userInteractionEnabled = false;
    }
    return _addPersonButton;
}

@end
