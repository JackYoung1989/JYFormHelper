//
//  JYFormCell_SelectImageInnerCell.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import "JYFormCell_SelectImageInnerCell.h"

@implementation JYFormCell_SelectImageInnerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pictureView = [[UIImageView alloc] init];
        self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
        self.pictureView.clipsToBounds = YES;
        [self.contentView addSubview:self.pictureView];
        [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.mas_equalTo(44);
        }];
        self.pictureView.layer.masksToBounds = YES;
        self.pictureView.layer.cornerRadius = 5.0;
        
        self.pictureLabel = [[UILabel alloc] init];
        self.pictureLabel.textColor = [UIColor whiteColor];
        self.pictureLabel.textAlignment = NSTextAlignmentCenter;
        self.pictureLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [self.contentView addSubview:self.pictureLabel];
        [self.pictureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.top.equalTo(self.contentView);
           make.height.mas_equalTo(44);
        }];
        
        self.addView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.addView];
        [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.mas_equalTo(44);
        }];
        self.addView.backgroundColor = [UIColor whiteColor];
        self.addView.image = [UIImage imageNamed:@"addImageButton"];
        self.addView.hidden = YES;
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(9);
            make.top.equalTo(self.contentView.mas_top).offset(-9);
            make.width.height.mas_equalTo(20);
        }];
        [self.deleteButton setImage:[UIImage imageNamed:@"deleteImageButton"] forState:UIControlStateNormal];
        self.deleteButton.hidden = YES;
        
        self.deleteBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.deleteBgButton];
        [self.deleteBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.pictureView.mas_right).offset(20);
            make.top.equalTo(self.pictureView.mas_top).offset(-20);
            make.width.height.mas_equalTo(40);
        }];
        [self.deleteBgButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBgButton.hidden = YES;
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.right.equalTo(self.pictureView);
            make.top.equalTo(self.pictureView.mas_bottom);
        }];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.numberOfLines = 2;
        self.nameLabel.text = @"抄送人";
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        //王亮增加-------显示“更多”按钮
        self.countLbl = [[UILabel alloc] init];
        [self.pictureView addSubview:self.countLbl];
        [self.countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.pictureView);
            make.size.equalTo(self.pictureView);
        }];
        self.countLbl.hidden = YES;
        self.countLbl.textAlignment = NSTextAlignmentCenter;
        self.countLbl.font = [UIFont systemFontOfSize:14];
        self.countLbl.textColor = [UIColor whiteColor];
        self.countLbl.backgroundColor = [UIColor colorWithHexString:@"#909399"];
        self.pictureView.backgroundColor = [UIColor colorWithHexString:@"#909399"];
        
        self.departNameLbl = [[UILabel alloc] init];
        [self.pictureView addSubview:self.departNameLbl];
        [self.departNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.pictureView);
            make.size.equalTo(self.pictureView);
        }];
        self.departNameLbl.hidden = YES;
        self.departNameLbl.textAlignment = NSTextAlignmentCenter;
        self.departNameLbl.font = [UIFont systemFontOfSize:14];
        self.departNameLbl.textColor = [UIColor whiteColor];
        self.departNameLbl.backgroundColor = UIColor.redColor;
    }
    return self;
}

- (void)deleteButtonClick {
    
    if (self.DeleteBlock) {
        self.DeleteBlock();
    }
}

- (void)setBAdd:(BOOL)bAdd {
    _bAdd = bAdd;
    if (bAdd) {
        self.pictureView.hidden = YES;
        self.addView.hidden = NO;
        self.deleteButton.hidden = YES;
        self.deleteBgButton.hidden = YES;
        self.deleteBgButton.enabled = NO;
    }else {
        self.pictureView.hidden = NO;
        self.addView.hidden = YES;
        self.deleteButton.hidden = NO;
        self.deleteBgButton.hidden = NO;
        self.deleteBgButton.enabled = YES;
    }
    self.countLbl.hidden = YES;
}

- (void)setHaveMore:(BOOL)haveMore{
    _haveMore = haveMore;
    if (haveMore) {
        self.countLbl.hidden = NO;
        self.pictureView.hidden = NO;
        self.addView.hidden = YES;
        self.deleteButton.hidden = YES;
        self.deleteBgButton.hidden = YES;
        self.deleteBgButton.enabled = NO;
        self.pictureView.image = nil;
    }
}
- (void)setNoDelete:(BOOL)noDelete{
    _noDelete = noDelete;
    if (noDelete) {
        self.countLbl.hidden = YES;
        self.pictureView.hidden = NO;
        self.addView.hidden = YES;
        self.deleteButton.hidden = YES;
        self.deleteBgButton.hidden = YES;
        self.deleteBgButton.enabled = NO;
    }

}

- (void)setHeaderImagePath:(NSString *)headerImagePath {
    
    _headerImagePath = headerImagePath;
    if (kStringIsEmpty(headerImagePath)) {
        if (self.isCustomApproval) {
            self.pictureView.image = [UIImage imageNamed:@"审批单管理员"];
        }
        else {
            self.pictureView.image = AvatorPlaceHolderImge;
        }
    }else {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:[JYEasyCodeHelper imageURLAddHttp:headerImagePath]] placeholderImage:AvatorPlaceHolderImge];
    }
    
}

@end
