//
//  JYPersonSelectCell.h
//  JYFormHelper
//
//  Created by JackYoung on 2021/3/21.
//

#import <UIKit/UIKit.h>
#import "JYKeyValueModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^JYFormCell_ReturnBlockWithInterger1)(NSInteger num, BOOL isSelected);
@interface JYPersonSelectCell : UITableViewCell

@property (nonatomic, strong)JYKeyValueModel *model;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, copy) JYFormCell_ReturnBlockWithInterger1 radioReturnBlock;

@end

NS_ASSUME_NONNULL_END
