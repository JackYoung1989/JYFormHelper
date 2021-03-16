//
//  JYFormCell_GrayBar.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/1.
//

#import "JYFormCell_GrayBar.h"

@implementation JYFormCell_GrayBar

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
        make.height.offset(10);
        make.bottom.offset(0);
    }];
}

@end
