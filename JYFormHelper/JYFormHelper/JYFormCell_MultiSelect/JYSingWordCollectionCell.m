//
//  JYSingWordCollectionCell.m
//  iOS
//
//  Created by JackYoung on 2021/1/26.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYSingWordCollectionCell.h"

@interface JYSingWordCollectionCell()

@property (nonatomic, strong)UIButton *titleButton;
@property (nonatomic, strong)UIImageView *rightCornerImage;

@end

@implementation JYSingWordCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.titleButton = [[UIButton alloc] init];
        [self.titleButton setTitleColor:[UIColor colorWithHexString:@"#328CFF"] forState:UIControlStateSelected];
        [self.titleButton setTitleColor:[UIColor colorWithHexString:@"#303133"] forState:UIControlStateNormal];
        [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.titleButton setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [self addSubview:self.titleButton];
        [self.titleButton addTarget:self action:@selector(onTitleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        self.rightCornerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downRightCornerImage"]];
        self.rightCornerImage.hidden = true;
        [self.titleButton addSubview:self.rightCornerImage];
        [self.rightCornerImage mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.bottom.offset(0);
          make.width.mas_equalTo(20);
          make.height.mas_equalTo(14);
        }];
    }
    return self;
}

- (void)onTitleButtonTouched:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.selected) {
        [self.titleButton setBackgroundColor:[UIColor colorWithHexString:@"#F2F8FF"]];
        self.rightCornerImage.hidden = false;
        [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    } else {
        [self.titleButton setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        self.rightCornerImage.hidden = true;
        [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if (self.block != nil) {
        self.block(self.indexPath,button.selected);
    }
}

- (void)setTitleString:(NSString *)titleString {
    [self.titleButton setTitle:titleString forState:UIControlStateNormal];
}

- (void)setIsSelected:(BOOL)isSelected {//只是改变按钮状态
    self.titleButton.selected = isSelected;
    if (isSelected) {
        [self.titleButton setBackgroundColor:[UIColor colorWithHexString:@"#F2F8FF"]];
        self.rightCornerImage.hidden = false;
        [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    } else {
        [self.titleButton setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        self.rightCornerImage.hidden = true;
        [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
}

@end
