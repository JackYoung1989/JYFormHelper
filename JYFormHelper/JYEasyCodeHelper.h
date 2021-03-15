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

@end

NS_ASSUME_NONNULL_END
