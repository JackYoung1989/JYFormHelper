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

@end
