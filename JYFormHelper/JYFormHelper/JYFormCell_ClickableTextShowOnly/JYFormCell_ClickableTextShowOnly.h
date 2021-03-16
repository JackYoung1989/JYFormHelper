//
//  JYFormCell_ClickableTextShowOnly.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/18.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYRootFormCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_ClickableTextShowOnly : JYRootFormCell

@property (nonatomic, copy) void(^didClickModelBlock)(JYKeyValueModel *model, NSString *cellTitle);

@end

NS_ASSUME_NONNULL_END
