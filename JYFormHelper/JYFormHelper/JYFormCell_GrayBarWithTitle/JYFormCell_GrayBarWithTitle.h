//
//  JYFormCell_GrayBarWithTitle.h
//  JackYoung
//
//  Created by 魏魏 on 2021/2/24.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYFormModel.h"
#import "JYRootFormCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_GrayBarWithTitle : JYRootFormCell

@property (nonatomic, copy) void(^btnClickBlock)(JYFormModel *model);

//@property (nonatomic, strong) JYFormModel *model;

@end

NS_ASSUME_NONNULL_END
