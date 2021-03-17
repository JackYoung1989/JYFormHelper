//
//  JYTestModel.h
//  JYFormHelper
//
//  Created by JackYoung on 2021/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYTestModel : NSObject

@property (nonatomic, copy)NSString *startDefaultTime;//开始时间
@property (nonatomic, copy)NSString *inputDefaultText;//输入的默认内容
@property (nonatomic, copy)NSString *showOnlyText;
@property (nonatomic, copy)NSString *describeString;
@property (nonatomic, strong)NSArray *defaultPersonArray;//默认的人员
@property (nonatomic, strong)NSArray *defaultImageArray;//默认的图片
@property (nonatomic, strong)NSArray *defaultFileArray;//默认的文件

@end

NS_ASSUME_NONNULL_END
