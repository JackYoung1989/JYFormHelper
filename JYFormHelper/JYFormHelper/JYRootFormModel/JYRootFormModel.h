//
//  JYRootFormModel.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/21.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 该model为所有详情页面数据的根model，用于编辑页面提交数据的时候，用到该ID；
 只要用到formViewController自动提交，model必须继承该model
 */
@interface JYRootFormModel : NSObject

@property (nonatomic, copy)NSString *formID;

@end

NS_ASSUME_NONNULL_END
