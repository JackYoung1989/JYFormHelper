//
//  JYFormCell_SelectImageInnerCell.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import "JYFormCell_SelectImageInnerCell.h"

@interface JYFormCell_SelectImageInnerCell()

@property (nonatomic,strong) UIImageView *pictureView;
@property (nonatomic,strong) UIImageView *addView;
@property (nonatomic,strong) NSString *headerImagePath;
@property (nonatomic,strong) UIButton *deleteButton;
@property (nonatomic,strong) UIButton *deleteBgButton;

@end

@implementation JYFormCell_SelectImageInnerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.pictureView = [[UIImageView alloc] init];
        self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
        self.pictureView.clipsToBounds = YES;
        [self.contentView addSubview:self.pictureView];
        [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.offset(9);
            make.right.offset(-9);
            make.height.mas_equalTo(56);
            make.width.mas_equalTo(56);
        }];
        self.pictureView.layer.masksToBounds = YES;
        self.pictureView.layer.cornerRadius = 5.0;
        
        self.addView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.addView];
        [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.offset(9);
            make.right.offset(-9);
            make.height.mas_equalTo(56);
            make.width.mas_equalTo(56);
        }];
        self.addView.backgroundColor = [UIColor whiteColor];
        self.addView.image = [UIImage imageNamed:@"add_image_button"];
        self.addView.hidden = YES;
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.pictureView.mas_right).offset(9);
            make.top.equalTo(self.pictureView.mas_top).offset(-9);
            make.width.height.mas_equalTo(18);
        }];
        [self.deleteButton setImage:[UIImage imageNamed:@"icon_delete_button"] forState:UIControlStateNormal];
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
    }
    return self;
}

- (void)setModel:(JYFileModel *)model {
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.absolutePath] placeholderImage:AvatorPlaceHolderImge];
}

- (void)deleteButtonClick {
    if (self.DeleteBlock && self.indexPath) {
        self.DeleteBlock(self.indexPath.row);
    }
}

- (void)setType:(JYFormCell_SelectImageInnerCellType)type {
    if (type == JYFormCell_SelectImageInnerCellTypeAdd) {
        self.pictureView.hidden = true;
        self.addView.hidden = false;
        self.deleteButton.hidden = true;
        self.deleteBgButton.hidden = true;
        self.deleteBgButton.enabled = false;
    } else {
        self.pictureView.hidden = false;
        self.addView.hidden = true;
        self.deleteButton.hidden = false;
        self.deleteBgButton.hidden = false;
        self.deleteBgButton.enabled = true;
    }
}

//- (void)setHeaderImagePath:(NSString *)headerImagePath {
//
//    _headerImagePath = headerImagePath;
//    if (kStringIsEmpty(headerImagePath)) {
//        self.pictureView.image = AvatorPlaceHolderImge;
//    }else {
//        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:[CommonFunction imageURLAddHttp:headerImagePath]] placeholderImage:AvatorPlaceHolderImge];
//    }
//
//}

@end
