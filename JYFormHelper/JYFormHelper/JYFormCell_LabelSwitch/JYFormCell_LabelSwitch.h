//
//  JYFormCell_LabelSwitch.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/7.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYFormModel.h"
#import "JYRootFormCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_LabelSwitch : JYRootFormCell
/**
 isOn 是switch的开关状态。
 mySwitch 是当前的switch，可以设置开关。
 */
@property (nonatomic, copy) void(^isSwitchOnBlock)(BOOL isOn, UISwitch *mySwitch);

@end

NS_ASSUME_NONNULL_END
