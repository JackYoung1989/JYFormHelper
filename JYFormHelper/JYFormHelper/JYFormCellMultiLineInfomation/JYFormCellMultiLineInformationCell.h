//
//  JYFormCellMultiLineInformationCell.h
//  JackYoung
//
//  Created by 魏魏 on 2021/3/6.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYFormModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCellMultiLineInformationCell : UITableViewCell

@property (nonatomic, copy) JYFormModel *model;
@property (nonatomic, copy) void(^deleteBtnClickBlock)(JYFormModel *model);

@end

NS_ASSUME_NONNULL_END
