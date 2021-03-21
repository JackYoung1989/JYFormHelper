//
//  JYPersonModel.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/20.
//  Copyright © 2021 JackYoung.com. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface JYPersonModel : NSObject

@property (nonatomic, copy)NSString *teamName;
@property (nonatomic, copy)NSString *userEmail;
@property (nonatomic, copy)NSString *userPhone;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *userBirth;
@property (nonatomic, copy)NSString *userHeadUrl;
@property (nonatomic, copy)NSString *logoUrl;
@property (nonatomic, copy)NSString *teamId;
@property (nonatomic, copy)NSString *employeeJob;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *userId;

@property (nonatomic, copy)NSString *totalPersonCount;//总人数

/// 事项详情中服务专员头像是否靠上
@property (nonatomic, assign) BOOL isTop;

@end

NS_ASSUME_NONNULL_END

