//
//  JYKeyValueModel.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/8.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYKeyValueModel : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *itemId;
@property (nonatomic, assign)BOOL isSelected;

/**
 存放人的头像，公司的logo
 */
@property (nonatomic, copy)NSString *imageUrl;
/**
 临时用的字符串，大部分用于存放原来model的json字符串,便于之后的地方用到原来model的数据，JYKeyValueModel相当于原来model的抽象。
 */
@property (nonatomic, copy)NSString *tempString;

@end

NS_ASSUME_NONNULL_END
