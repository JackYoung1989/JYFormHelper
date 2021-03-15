//
//  JYEasyCodeHelper.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/1/31.
//

#import "JYEasyCodeHelper.h"

@implementation JYEasyCodeHelper

+ (NSString *)imageURLAddHttp:(NSString *)imageUrl {
   
    if ([imageUrl hasPrefix:@"http://"]) {
        
        return imageUrl;
    }else {
        
        imageUrl = [NSString stringWithFormat:@"http://%@",imageUrl];
        return imageUrl;
    }
}

+ (CGFloat)getStringHeight:(NSString *)str Font:(UIFont*)font MaxWidth:(CGFloat)width
{
    NSDictionary * attribute = @{NSFontAttributeName:font};
    CGSize tempSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return ceil(tempSize.height)+1;
}

+ (CGFloat)getStringWidth:(NSString *)str Font:(UIFont*)font MaxHeight:(CGFloat)height
{
    NSDictionary * attribute = @{NSFontAttributeName:font};
    CGSize tempSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return ceil(tempSize.width)+1;
}

//判断是否为空
+ (BOOL)isNotEmpty:(id)data {
    if(data == nil) {
        return NO;
    }
    
    if ([data isKindOfClass:[NSString class]]) {
        return (![data isEqual:[NSNull null]] && data && ![data isEqualToString:@""] && data != nil && data != NULL && ![data isKindOfClass:[NSNull class]] && ![data isEqualToString:@"(null)"]);
    } else if ([data isKindOfClass:[NSArray class]]) {
        NSArray * array = data;
        return (array != nil && ![array isKindOfClass:[NSNull class]] && array.count !=0);
    } else if ([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = (NSDictionary *)data;
        return (dic && dic !=nil && ![dic isKindOfClass:[NSNull class]] && dic != NULL && dic.count);
    } else {
        return (![data isEqual:[NSNull null]] && ![data isKindOfClass:[NSNull class]] && data);
    }
}


@end
