//
//  JYFormModel.h
//  iOS
//
//  Created by JackYoung on 2021/1/27.
//  Copyright © 2021 JackYoung. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JYFormModelCellStyle) {
    JYFormModelCellStyle_SelectShow = 10,//请选择>, 内容>
    JYFormModelCellStyle_InputTextField,//“请输入”，内容展示
    JYFormModelCellStyle_ShowOnly,//只展示内容
    JYFormModelCellStyle_ClickableTextShowOnly,//只展示内容,内容可以点击，不同内容返回不同model
    JYFormModelCellStyle_GrayBar,//cell中间的间隔灰条
    JYFormModelCellStyle_MultiSelectButton,//多个按钮选择cell
    JYFormModelCellStyle_SectionHeaderTitleLabel,//sectionHeader灰色背景，上面显示标题titleLabel
    JYFormModelCellStyle_CommentTextViewInput,//类似于评论一样的textView输入框
    JYFormModelCellStyle_ImageSelect,//图片选择
    JYFormModelCellStyle_FileSelect,//文件选择
    
    JYFormModelCellStyle_PersonSelect,//人员选择
    
    
    JYFormModelCellStyle_SectionHeaderLightGrayTitle,//section标题,灰色文字，下面带线
    JYFormModelCellStyle_LabelSwitch,//左边是label，右边是switch开关
    JYFormModelCellStyle_RadioSelect,//左边是label，右边是radio按钮
    JYFormModelCellStyle_DepartmentSelect,//部门选择
    
    
    /**
     下面是用于详情展示的cell类型
     */
    JYFormModelCellStyle_PersonSelect_DetailShowMode,//人员选择,详情页面展示状态。
    JYFormModelCellStyle_ThumbDetailModel,//谁谁点赞了
    
    /**
     王路飞建立的
     */
    JYFormModelCellStyle_GrayBarWithTitle,//cell默认灰色文字 灰色背景 不带线 有属性可以改值
    
    JYFormModelCellStyle_Multiline_Information,//一组多行输入信息cell 带删除
    JYFormModelCellStyle_SelectShowWithImage,//图片> 选择样式 右边是图片
};

typedef NS_ENUM(NSUInteger, JYFormModelCellSelectPersonStyle) {
    JYFormModelCellSelectPersonStyle_MultiTeamMultiSelect,//多团队多选人
    JYFormModelCellSelectPersonStyle_SingleTeamMultiSelect,//单团队多选人
    JYFormModelCellSelectPersonStyle_SpecifiedSingleTeamMultiSelect,//指定单团队多选人 需要传teamId
};

@class JYKeyValueModel;
@class JYSelectDepartmentModel;
@class JYFileModel;
@interface JYFormModel : NSObject

@property (nonatomic, strong)UIColor *backgroundColor;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)UIColor *titleColor;
@property (nonatomic, assign)BOOL isBottomLineHidden;//底部灰线隐藏
@property (nonatomic, assign)BOOL isHiddenCell;//是否隐藏cell 实际上是高度改为0
@property (nonatomic, assign)BOOL isMust;//是不是必填项
@property (nonatomic, assign)BOOL isHiddenTitle;//是否隐藏标题 默认不隐藏
@property (nonatomic, assign)BOOL isHaveSubTitle;//是否有副标题 默认没有
@property (nonatomic, copy)NSString *subTitleString;//副标题名称
@property (nonatomic, copy)NSString *placeHolder;//当不是可选择状态，即，输入状态的时候才有用。
@property (nonatomic, copy)NSString *contentDisplay;//内容，用于展示内容，仅仅是显示
@property (nonatomic, copy)NSString *contentString;//内容，发送给后台的内容
@property (nonatomic, assign)BOOL isSelectable;//是不是可以选择项(单行)
@property (nonatomic, assign)BOOL isNotEditable;//1:editable 0:不可编辑，是不是处在编辑状态。
@property (nonatomic, copy)NSString *requestKey;//发起请求时候的Key，对应后台参数列表。
@property (nonatomic, copy)NSString *rightSelectButtonImage;//可选择按钮的名字，默认“>”
@property (nonatomic, strong)NSArray <JYKeyValueModel *>*childArray;//子数据的数组
@property (nonatomic, strong)NSArray <JYKeyValueModel *>*optionArray;//可选内容的数组，用于选择控件
@property (nonatomic, strong)NSArray *multilineArray;//可选内容的数组，用于选择控件
@property (nonatomic, strong)NSArray <JYSelectDepartmentModel *>*departmentArray;//部门
@property (nonatomic, assign) BOOL isSetDraftFileOrImage; //是否设置过草稿中的附加或者图片
@property (nonatomic, strong)NSArray <JYFileModel *>*fileOrImageArray;//拉取草稿得到的附件或图片数组
@property (nonatomic, assign)JYFormModelCellStyle style;//cell的样式
@property (nonatomic, assign)NSInteger inputMaxLength;//最大输入限制
@property (nonatomic, assign)NSInteger inputMinLength;//最少输入限制，提交表单的时候需要提示“最少字符”
@property (nonatomic, assign)UIKeyboardType keyboardType;//如果是可以输入状态的时候，设置键盘类型

//仅限于JYFormModelCellStyle_ShowOnly用，默认向左对齐，可设置向右对齐。
@property (nonatomic, assign)NSTextAlignment showTextAlignment;

/// 仅限于JYFormModelCellStyle_GrayBarWithTitle类型的cell用
@property (nonatomic, strong) UIColor *grayBarWithTitleColor;
@property (nonatomic, strong) UIFont *grayBarWithTitleFont;
@property (nonatomic, strong) UIImage *grayBarWithTitleRightImage;

/// 仅限于JYFormModelCellStyle_SelectShowWithImage类型的cell用
@property (nonatomic, copy) NSString *placeHolderImage;

/// 仅限于JYFormModelCellSelectPersonStyle_SpecifiedSingleTeamMultiSelect类型的cell用
@property (nonatomic, copy) NSString *specifiedSingleTeamId;


/**
 仅仅用在选择人员时候，控制人员选择页面的类型。
 */
@property (nonatomic, assign)JYFormModelCellSelectPersonStyle selectPersonStyle;
/**
 discuss：是不是将选择的model所有属性都返回到getAllFromData,key = identifier4ReturnAllPropertyOfSelectedModel。和这个key需要搭配使用。
 是不是将选择的model的所有数据转成jsonString，赋值TempString。
 在JYFormViewController子类：getAllFromData里，可得到该TempString的数组。
 大多数用在选择人、file、image等cell中。
 */
@property (nonatomic, assign)BOOL ifReturnAllPropertyOfSelectedModel;
/**
 如果ifReturnAllPropertyOfSelectedModel = true；那么该值不为空。
 */
@property (nonatomic, copy)NSString *identifier4ReturnAllPropertyOfSelectedModel;

@property (nonatomic, copy)NSString *descString;//仅仅用于textView形式的cell 标题后面的描述

+ (id)getModelWithTitle:(NSString *)title inArray:(NSArray *)array;
+ (BOOL)insertModel:(JYFormModel *)model afterTitle:(NSString *)title inArray:(NSArray *)array;
+ (BOOL)deleteModelWithTitle:(NSString *)title inArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
