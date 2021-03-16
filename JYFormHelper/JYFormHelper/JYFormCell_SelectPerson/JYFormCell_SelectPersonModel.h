//
//  JYFormCell_SelectPersonModel.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/10.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_SelectPersonModel : NSObject

@property (nonatomic, copy)NSString *employeeJob;
@property (nonatomic, copy)NSString *teamId;
@property (nonatomic, copy)NSString *userPhone;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *employeeName;
@property (nonatomic, copy)NSString *userHeadUrl;
@property (nonatomic,strong) NSNumber *departmentIdMaster;

@end

NS_ASSUME_NONNULL_END
