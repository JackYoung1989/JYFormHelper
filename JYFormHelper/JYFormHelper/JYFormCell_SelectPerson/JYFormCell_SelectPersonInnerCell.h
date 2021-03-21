//
//  JYFormCell_SelectPersonInnerCell.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/10.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DeleteItemWithIndexBlockType)(NSInteger index);

typedef NS_ENUM(NSUInteger, JYFormCell_SelectPersonInnerCellType) {
    JYFormCell_SelectPersonInnerCellTypeShowPerson,
    JYFormCell_SelectPersonInnerCellTypeAdd,
    JYFormCell_SelectPersonInnerCellTypeMore,
};

@interface JYFormCell_SelectPersonInnerCell : UICollectionViewCell

@property (nonatomic, assign)JYFormCell_SelectPersonInnerCellType cellType;
@property (nonatomic, strong)JYKeyValueModel *personModel;
@property (nonatomic, copy)DeleteItemWithIndexBlockType deleteItemWithIndexBlock;
@property (nonatomic, assign)NSInteger itemIndex;
@property (nonatomic, assign)NSInteger totalCount;//一共多少人，用于显示总人数

@end

NS_ASSUME_NONNULL_END
