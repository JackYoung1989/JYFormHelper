//
//  JYFormModel.m
//  iOS
//
//  Created by JackYoung on 2021/1/27.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYFormModel.h"

@implementation JYFormModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestKey = @"";
    }
    return self;
}

//通过model的title，查找array中是不是存在该model,如果存在返回model，否则返回nil
+ (id)getModelWithTitle:(NSString *)title inArray:(NSArray *)array {
    if (!title || [title isEqualToString:@""]) {
        return nil;
    }
    for (JYFormModel *model in array) {
        if ([model.title isEqualToString:title]) {
            return model;
        }
    }
    return nil;
}

//将model插入在制定title的model后面。true：成功 false：失败
+ (BOOL)insertModel:(JYFormModel *)model afterTitle:(NSString *)title inArray:(NSMutableArray *)array {
    if (!title || [title isEqualToString:@""] || array.count == 0) {
        return false;
    }
    for (int i = 0; i < array.count; i ++) {
        JYFormModel *tempModel = array[i];
        if ([tempModel.title isEqualToString:title]) {
            [array insertObject:model atIndex:i + 1];
            return true;
        }
    }
    return false;
}

//如果title相同，将model从数组中删掉。true:有且删掉了 false：可能没有
+ (BOOL)deleteModelWithTitle:(NSString *)title inArray:(NSMutableArray *)array {
    if (!title || [title isEqualToString:@""] || array.count == 0) {
        return false;
    }
    for (int i = 0; i < array.count; i ++) {
        JYFormModel *tempModel = array[i];
        if ([tempModel.title isEqualToString:title]) {
            [array removeObject:tempModel];
            return true;
        }
    }
    return false;
}

@end
