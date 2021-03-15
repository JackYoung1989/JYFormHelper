//
//  JYEasyCodeHelper.h
//  JYFormHelper
//
//  Created by JackYoung on 2021/1/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^block)(NSString *resultText);

@interface JYEasyCodeHelper : NSObject

//判断图片Url是否带http://
+ (NSString *)imageURLAddHttp:(NSString *)imageUrl;

/**
 获取字符串的高
 */
+ (CGFloat)getStringHeight:(NSString *)str Font:(UIFont*)font MaxWidth:(CGFloat)width;

/**
 获取字符串的宽
 */
+ (CGFloat)getStringWidth:(NSString *)str Font:(UIFont*)font MaxHeight:(CGFloat)height;

/**
 判断对象是不是空，不为空，返回true；
 */
+ (BOOL)isNotEmpty:(id)data;

@end

NS_ASSUME_NONNULL_END
