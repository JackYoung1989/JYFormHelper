//
//  JYKeyValueModel.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/8.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYKeyValueModel.h"

@implementation JYKeyValueModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"itemId" : @"id"};
}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"childNodes":[CMFillInReportTemplateListItemModel class]};
//}

@end
