//
//  JYFormViewController.h
//  iOS
//
//  Created by JackYoung on 2021/1/26.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYRootFormModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFormViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/**
 编辑表单的时候，需要传入带有数据的model，dataModel接收该model；
 */
@property (nonatomic, strong)JYRootFormModel *dataModel;

/**
 在点击“返回”按钮的时候，是不是要弹窗提示，“您所填写的内容暂未保存， 是否确定返回？”
 */
@property(nonatomic, assign) BOOL ifShowAlertWhenGoBack;

/**
 后台的url地址，去掉域名的URL地址,如果有这个url，点击提交，直接将表单提交后台。
 */
@property(nonatomic, copy) NSString *requestURL;

/**
 后台的url地址，去掉域名的URL地址,如果有这个url，点击提交，直接将表单提交后台。编辑后提交的url
 */
@property(nonatomic, copy) NSString *requestURL_UpdateUrl;

/**
 后台的url地址，去掉域名的URL地址,如果有这个url，右上角有保存草稿
 */
@property(nonatomic, copy) NSString *requestURL_SaveDraftUrl;

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
/**
 底部背景，可自定义
 */
@property(nonatomic, strong) UIView *bottomBgView;

/**
 底部提交按钮，可自定义
 */
@property(nonatomic, strong) UIButton *submitButton;

/**
 提交表单成功之后，执行的操作。
 */
@property (nonatomic, copy)void(^actionAfterSubmitSuccess)(id responseObject);

/**
 保存草稿成功之后，执行的操作。
 */
@property (nonatomic, copy)void(^actionAfterSaveDraftSuccess)(id responseObject);

/**
 isOn 是switch的开关状态。
 mySwitch 是当前的switch，可以设置开关。
 */
@property (nonatomic, copy) void(^isSwitchOnBlock)(BOOL isOn, UISwitch *mySwitch);

/**
 JYFormCellMultiLineInformationCell 点击删除按钮的回调
 */
@property (nonatomic, copy) void(^multiLineDeleteBtnClick)(void);

/**
 描述：子类可以重写该方法，一定要调用父类获取表单数据。
 作用：处理类似于后台要数字类型，统一的表单数据是String的情况，在该方法修改。
 */
- (NSDictionary *)getAllFormData;
/**
 提示框
 */
- (void)showAlertWithMessage:(NSString *)message sureButtonTouchedBlock:(void(^)(void))sureButtonTouchedBlock;

@end

NS_ASSUME_NONNULL_END
