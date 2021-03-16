//
//  JYFormCell_SelectPersonDetailShowMode.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/23.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYPersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_SelectPersonDetailShowMode : UITableViewCell

@property (nonatomic, strong)NSArray <JYPersonModel *>*currentArray;
@property (nonatomic, strong)NSString *titleString;

@end

NS_ASSUME_NONNULL_END
