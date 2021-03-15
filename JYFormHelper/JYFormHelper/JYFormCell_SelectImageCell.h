//
//  JYFormCell_SelectImageCell.h
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_SelectImageCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *recipientArray;
@property (nonatomic, copy) void(^selectedImageBlock)(void);
@property (nonatomic, copy) void(^deleteImageBlock)(NSUInteger index);

@property (nonatomic, assign) BOOL  hiddenAdd;

@end

NS_ASSUME_NONNULL_END
