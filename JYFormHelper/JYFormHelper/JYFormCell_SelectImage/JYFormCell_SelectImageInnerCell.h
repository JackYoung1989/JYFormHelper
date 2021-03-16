//
//  JYFormCell_SelectImageInnerCell.h
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import <UIKit/UIKit.h>
#import "JYFileModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JYFormCell_SelectImageInnerCellType) {
    JYFormCell_SelectImageInnerCellTypeShowImage,
    JYFormCell_SelectImageInnerCellTypeAdd,
};

@interface JYFormCell_SelectImageInnerCell : UICollectionViewCell

@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, copy) void(^DeleteBlock)(NSInteger itemIndex);
@property (nonatomic, assign)JYFormCell_SelectImageInnerCellType type;
@property (nonatomic, strong)JYFileModel *model;

@end

NS_ASSUME_NONNULL_END
