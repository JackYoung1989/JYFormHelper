//
//  JYTableViewControllerDemo.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/13.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYTableViewController.h"
#import "JYFormCell_SelectPersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYTableViewControllerDemo : JYTableViewController

@property (nonatomic, strong)NSArray *selectedArray;
/**
 选择了的人员列表。包括默认传进来的人员。
 */
@property (nonatomic, copy)void(^selectedItemsArrayBlock)(NSArray <JYFormCell_SelectPersonModel *>*keyValueArray);

@end

NS_ASSUME_NONNULL_END
