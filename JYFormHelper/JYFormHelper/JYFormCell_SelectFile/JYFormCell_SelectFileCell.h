//
//  JYFormCell_SelectFileCell.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/7.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DeleteItemWithIndexBlockType)(NSInteger index);

@class JYFileModel;
@interface JYFormCell_SelectFileCell : UITableViewCell

@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)JYFileModel *fileModel;
@property (nonatomic, copy)DeleteItemWithIndexBlockType deleteItemWithIndexBlock;

@end

NS_ASSUME_NONNULL_END
