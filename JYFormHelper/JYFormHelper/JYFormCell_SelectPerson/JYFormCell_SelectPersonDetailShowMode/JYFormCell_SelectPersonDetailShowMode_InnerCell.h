//
//  JYFormCell_SelectPersonDetailShowMode_InnerCell.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/23.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYPersonModel.h"

typedef NS_ENUM(NSUInteger, PersonDetailsCellStyle) {
    PersonDetailsCellStyle_More,
    PersonDetailsCellStyle_Normal,
};

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_SelectPersonDetailShowMode_InnerCell : UICollectionViewCell

@property (nonatomic, assign)PersonDetailsCellStyle cellType;
@property (nonatomic, strong)JYPersonModel *model;

@end

NS_ASSUME_NONNULL_END
