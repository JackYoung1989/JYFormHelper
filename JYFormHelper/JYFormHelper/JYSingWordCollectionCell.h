//
//  JYSingWordCollectionCell.h
//  iOS
//
//  Created by JackYoung on 2021/1/26.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^cellBlock)(NSIndexPath *indexPath,BOOL isSelected);

@interface JYSingWordCollectionCell : UICollectionViewCell

@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, copy)NSString *titleString;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, copy)cellBlock block;

@end

NS_ASSUME_NONNULL_END
