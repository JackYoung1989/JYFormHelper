//
//  JYFormCell_SelectFileAddCell.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/7.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectFileAddCell.h"

@interface JYFormCell_SelectFileAddCell()

@property (nonatomic,strong) UIImageView *addView;

@end

@implementation JYFormCell_SelectFileAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.addView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.addView];
        [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.offset(0);
            make.height.width.mas_equalTo(60);
            make.bottom.offset(0);
        }];
        self.addView.backgroundColor = [UIColor whiteColor];
        self.addView.image = [UIImage imageNamed:@"addImage"];
    }
    return self;
}

@end
