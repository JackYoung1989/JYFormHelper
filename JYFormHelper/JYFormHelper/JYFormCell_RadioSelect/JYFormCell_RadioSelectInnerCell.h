//
//  JYFormCell_RadioSelectInnerCell.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/8.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYKeyValueModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^JYFormCell_ReturnBlockWithInterger)(NSInteger num);

@interface JYFormCell_RadioSelectInnerCell : UITableViewCell

@property (nonatomic, strong)JYKeyValueModel *model;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, copy) JYFormCell_ReturnBlockWithInterger radioReturnBlock;

@end

NS_ASSUME_NONNULL_END
