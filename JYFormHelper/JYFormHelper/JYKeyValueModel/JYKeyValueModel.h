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

//这三个变量用于FormCell得到数据时候，存储数据用的。遍历每个keyValueModel就能得到在表单中修改的数据。
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

//************************* 分界线 ****************************************

//下面两个值是用来展示的时候，左边是key，右边是value；用于cell中字段展示。
@property (nonatomic, copy)NSString *key;
@property (nonatomic, copy)NSString *value;

@end

NS_ASSUME_NONNULL_END
