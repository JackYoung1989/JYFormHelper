//
//  JYFormCell.h
//  iOS
//
//  Created by JackYoung on 2021/1/27.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYFormModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell : UITableViewCell

@property (nonatomic, strong)JYFormModel *model;
@property (nonatomic, copy)block inputReturnBlock;

@end

NS_ASSUME_NONNULL_END
