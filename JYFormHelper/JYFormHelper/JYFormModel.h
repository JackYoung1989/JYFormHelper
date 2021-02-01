//
//  JYFormModel.h
//  iOS
//
//  Created by JackYoung on 2021/1/27.
//  Copyright © 2021 JackYoung. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JYFormModelCellStyle) {
    JYFormModelCellStyleSelectShow = 10,//请选择>, 内容>
    JYFormModelCellStyleInputTextField,//“请输入”，内容展示
    JYFormModelCellStyleShowOnly,//只展示内容
    JYFormModelCellStyleGrayBar,//cell中间的间隔灰条
    JYFormModelCellStyleMultiSelectButton,//多个按钮选择cell
};

@class JYKeyValueModel;
@interface JYFormModel : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)BOOL isMust;//是不是必填项
@property (nonatomic, copy)NSString *placeHolder;//当不是可选择状态，即，输入状态的时候才有用。
@property (nonatomic, copy)NSString *contentDisplay;//内容，用于展示内容，仅仅是显示
@property (nonatomic, copy)NSString *contentString;//内容，发送给后台的内容
@property (nonatomic, assign)BOOL isSelectable;//是不是可以选择项(单行)
@property (nonatomic, assign)BOOL isEditable;//1:editable 0:不可编辑，是不是处在编辑状态。
@property (nonatomic, copy)NSString *requestKey;//发起请求时候的Key，对应后台参数列表。
@property (nonatomic, copy)NSString *rightSelectButtonImage;//可选择按钮的名字，默认“>”
@property (nonatomic, strong)NSArray <JYKeyValueModel *>*childArray;//子数据的数组
@property (nonatomic, assign)JYFormModelCellStyle style;//cell的样式
@property (nonatomic, assign)NSInteger inputMaxLength;//最大输入限制
@property (nonatomic, assign)UIKeyboardType keyboardType;//如果是可以输入状态的时候，设置键盘类型

+ (id)getModelWithTitle:(NSString *)title inArray:(NSArray *)array;
+ (BOOL)insertModel:(JYFormModel *)model afterTitle:(NSString *)title inArray:(NSArray *)array;
+ (BOOL)deleteModelWithTitle:(NSString *)title inArray:(NSArray *)array;

@end

@interface JYKeyValueModel : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSNumber *itemId;
@property (nonatomic, assign)BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
