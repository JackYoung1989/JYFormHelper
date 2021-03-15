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
@property (nonatomic, copy)NSString *employeeHiredate;
@property (nonatomic, copy)NSString *departmentIdArrayName;
@property (nonatomic, copy)NSString *userGender;
@property (nonatomic, copy)NSString *employeeNo;
@property (nonatomic, copy)NSString *userPhone;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *employeePositiveTime;
@property (nonatomic, copy)NSString *employeeOfficeLocation;
@property (nonatomic, copy)NSString *jobRank;
@property (nonatomic, copy)NSString *rank;
@property (nonatomic, copy)NSString *departmentMasterName;
@property (nonatomic, copy)NSString *firstTimeWorkingHours;
@property (nonatomic, copy)NSString *affiliateDepartmentMap;
@property (nonatomic, copy)NSString *userBirth;
@property (nonatomic, strong)NSArray *roleIds;//这是个数组
@property (nonatomic, copy)NSString *ownerDepartmentId;
@property (nonatomic, copy)NSString *userHeadUrl;
@property (nonatomic, copy)NSString *logoUrl;
@property (nonatomic, copy)NSString *teamType;
@property (nonatomic, copy)NSString *employeeDescribe;
@property (nonatomic, copy)NSString *employeeType;
@property (nonatomic, strong)NSArray *departmentIdArray;
@property (nonatomic, strong)NSArray *organizationIdDict;
@property (nonatomic, copy)NSString *phonePrefix;
@property (nonatomic, copy)NSString *probationPeriod;
@property (nonatomic, copy)NSString *teamId;
@property (nonatomic, copy)NSString *employeeJob;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *departmentIdMaster;
@property (nonatomic, copy)NSString *affiliateDepartmentNames;
@property (nonatomic, copy)NSString *employeeStatus;
@property (nonatomic, copy)NSString *ownerDepartmentName;
@property (nonatomic, copy)NSString *userId;

@property (nonatomic, copy)NSString *totalPersonCount;//总人数

@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, copy)NSString *createByName;
@property (nonatomic, copy)NSString *commentContent;
@property (nonatomic, copy)NSString *createByHeadUrl;

/// 事项详情中服务专员头像是否靠上
@property (nonatomic, assign) BOOL isTop;

@end

NS_ASSUME_NONNULL_END
