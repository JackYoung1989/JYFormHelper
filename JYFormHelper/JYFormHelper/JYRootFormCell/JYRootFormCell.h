//
//  JYRootFormCell.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/6.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYFormModel.h"
#import "JYKeyValueModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^JYFormCell_ReturnBlockVoid)(void);

@interface JYRootFormCell : UITableViewCell

@property (nonatomic, strong)JYFormModel *model;
@property (nonatomic, copy)JYFormCell_ReturnBlockVoid refreshBlock;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) MASConstraint *subTitleLabelBottomConstraint;

@end

NS_ASSUME_NONNULL_END
