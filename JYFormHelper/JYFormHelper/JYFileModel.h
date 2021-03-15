//
//  JYFileModel.h
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYFileModel : NSObject

@property (nonatomic, assign) BOOL ifFirstFile;//是不是第一个文件，第一个文件cell应该显示“附件：”，否则不显示
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileType;
@property (nonatomic, copy) NSString *fileUrl;
@property (nonatomic, copy) NSString *fileSynopsis;//字节大小

@property (nonatomic, copy) NSString *absolutePath;
@property (nonatomic, copy) NSString *fileSize;
@property (nonatomic, copy) NSString *originalFileName;

@end

NS_ASSUME_NONNULL_END
