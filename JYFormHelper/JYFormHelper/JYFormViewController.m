//
//  JYFormViewController.m
//  iOS
//
//  Created by JackYoung on 2021/1/26.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "BRPickerView.h"
#import "JYFormViewController.h"
#import "JYFormModel.h"
#import "JYFormCell.h"
#import "JYFormCell_MultiSelect.h"
#import "JYFormCell_GrayBar.h"
#import "JYFormCell_SectionHeaderTitleLabel.h"
#import "JYFormCell_CommentTextViewInput.h"
#import "JYFormCell_SelectImageCell.h"
#import "JYKeyValueModel.h"
#import "JYFormCell_SelectFile.h"
#import "JYFormCell_SelectPerson.h"
#import "JYFormCell_SectionHeaderLightGrayTitle.h"
#import "JYFormCell_LabelSwitch.h"
#import "JYFormCell_RadioSelect.h"
#import "JYFormCell_GrayBarWithTitle.h"
#import "JYFormCellMultiLineInformationCell.h"
#import "JYFormCell_SelectShowWithImageCell.h"

//表单的根视图控制器
@interface JYFormViewController ()

@end

@implementation JYFormViewController

- (void)setDataModel:(NSObject *)dataModel {
    _dataModel = dataModel;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc] init];
    
    [self createUI];
}

- (void)setRequestURL_SaveDraftUrl:(NSString *)requestURL_SaveDraftUrl
{
    _requestURL_SaveDraftUrl = requestURL_SaveDraftUrl;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存草稿" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)itemClick
{
    [self submitOrSaveDraft:false];
}

- (void)createUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[JYFormCell_MultiSelect class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_MultiSelect class])];
    [self.tableView registerClass:[JYFormCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell class])];
    [self.tableView registerClass:[JYFormCell_GrayBar class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_GrayBar class])];
    [self.tableView registerClass:[JYFormCell_GrayBarWithTitle class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_GrayBarWithTitle class])];
    [self.tableView registerClass:[JYFormCell_SectionHeaderTitleLabel class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SectionHeaderTitleLabel class])];
    [self.tableView registerClass:[JYFormCell_CommentTextViewInput class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_CommentTextViewInput class])];
    [self.tableView registerClass:[JYFormCell_SelectImageCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SelectImageCell class])];
    [self.tableView registerClass:[JYFormCell_SelectFile class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SelectFile class])];
    [self.tableView registerClass:[JYFormCell_SelectPerson class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SelectPerson class])];
    [self.tableView registerClass:[JYFormCell_SectionHeaderLightGrayTitle class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SectionHeaderLightGrayTitle class])];
    [self.tableView registerClass:[JYFormCell_LabelSwitch class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_LabelSwitch class])];
    [self.tableView registerClass:[JYFormCell_RadioSelect class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_RadioSelect class])];
    [self.tableView registerClass:[JYFormCellMultiLineInformationCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCellMultiLineInformationCell class])];
    [self.tableView registerClass:[JYFormCell_SelectShowWithImageCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SelectShowWithImageCell class])];

    self.tableView.estimatedRowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.bottom.offset(-65 - kBottomInset);
    }];
    
    self.bottomBgView = [[UIView alloc] init];
    [self.view addSubview:self.bottomBgView];
    [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(66 + kBottomInset);
        make.bottom.offset(0);
    }];
    
    
    [self.submitButton addTarget:self action:@selector(onSubmitButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBgView addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(10);
        make.height.offset(45);
    }];
}

- (BOOL)navigationShouldPopOnBackButton {
    if (self.ifShowAlertWhenGoBack) {
        NSDictionary *dic = [self getAllFormData];
        BOOL flag = false;
        for (int i = 0; i < dic.allKeys.count; i ++) {
            NSObject *object = [dic objectForKey:dic.allKeys[i]];
            if (object && [object isKindOfClass:[NSArray class]]) {
                if(((NSArray *)object).count > 0) {
                    flag = true;
                    break;
                }
            } else if (object && [object isKindOfClass:[NSString class]]) {
                NSString *tempString = (NSString *)object;
                if (![tempString isEqualToString:@""]) {
                    flag = true;
                    break;
                }
            }
        }
        if (flag) {
            [self showAlertWithMessage:@"您所填写的内容暂未保存， 是否确定返回？" sureButtonTouchedBlock:^{
                [self.navigationController popViewControllerAnimated:true];
            }];
            return false;
        }
    }
    return true;
}

- (void)onSubmitButtonTouched
{
    [self submitOrSaveDraft:true];
}

/**
 点击是为了提交 or 保存草稿， true：提交   false：保存草稿
 */
- (void)submitOrSaveDraft:(BOOL)isSubmit
{
//    //为了测试的时候方便，可以删掉
//    NSDictionary *requestDic2 = [self getAllFormData];
//    NSLog(@"表单上面的内容是：%@",requestDic2);
//    if (requestDic2 == nil) {
//        return;;
//    }
    
    // 判断是否点击的是提交 需要校验必填项
    if (isSubmit) {
        //判断必填项是不是都有值。
        for (int i = 0; i < self.dataArray.count; i ++) {
            JYFormModel *model = self.dataArray[i];
            if (model.isMust) {
                if ((!model.contentString || [model.contentString isEqualToString:@""]) && (!model.childArray || model.childArray.count == 0)) {
                    [self showAlertWithMessage:[NSString stringWithFormat:@"请完善%@信息",model.title] sureButtonTouchedBlock:^{
                    }];
                    return;
                }
            }
            //判断如果输入框的字符少于最小字符，那么需要提示。
            if (model.inputMinLength != 0 && (model.style == JYFormModelCellStyle_InputTextField || model.style == JYFormModelCellStyle_CommentTextViewInput)) {
                //有输入内容的时候，采取判断；如果没有输入内容的话，不需要判断。
                if (model.contentString.length > 0 && model.contentString.length < model.inputMinLength) {
                    [self showAlertWithMessage:[NSString stringWithFormat:@"%@输入的内容少于%ld个字符，请继续输入",model.title,model.inputMinLength] sureButtonTouchedBlock:^{
                    }];
                    return;
                }
            }
            //判断输入框里面是不是只输入了空格,且将contentString去掉前后空格
            if (model.style == JYFormModelCellStyle_InputTextField || model.style == JYFormModelCellStyle_CommentTextViewInput) {
                if (model.contentString && ![model.contentString isEqualToString:@""]) {
                    NSString *tempString = [model.contentString trim];
                    if ([tempString isEqualToString:@""]) {
                        [self showAlertWithMessage:[NSString stringWithFormat:@"%@输入的内容不能都为空格，请重新输入",model.title] sureButtonTouchedBlock:^{
                        }];
                        return;
                    } else {
                        model.contentString = tempString;
                    }
                }
            }
        }
    }
    
    NSDictionary *requestDic = [self getAllFormData];
    NSLog(@"表单上面的内容是：%@",requestDic);
    //发起请求
    NSString *tempRequestUrl;
    // 点击的是保存草稿
    if (!isSubmit) {
        if (self.requestURL_SaveDraftUrl && !kStringIsEmpty(self.requestURL_SaveDraftUrl)) {
            tempRequestUrl = self.requestURL_SaveDraftUrl;
        }
    }
    else {
        if (self.dataModel != nil) {//“编辑”完成，提交表单
            if (self.requestURL_UpdateUrl && ![self.requestURL_UpdateUrl isEqualToString:@""]) {
                tempRequestUrl = self.requestURL_UpdateUrl;
                if ([JYEasyCodeHelper isNotEmpty:self.dataModel.formID]) {
                    [requestDic setValue:self.dataModel.formID forKey:@"id"];
                }
            }
        } else {//“新建”表单完成，提交表单
            if (self.requestURL && ![self.requestURL isEqualToString:@""]) {
                tempRequestUrl = self.requestURL;
            }
        }
    }
    
    if (tempRequestUrl && ![tempRequestUrl isEqualToString:@""]) {
        [SVProgressHUD show];
//        [NetworkHelper POSTForCode:[NSString stringWithFormat:@"%@%@",Base_URL,tempRequestUrl] parameters:requestDic success:^(NSInteger code, NSString * _Nonnull message, id  _Nullable responseObject) {
//            if (code == 200) {
//                // 如果是保存草稿
//                if (!isSubmit) {
//                    if (self.actionAfterSaveDraftSuccess) {
//                        self.actionAfterSaveDraftSuccess(responseObject);
//                    }
//                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//                }
//                else {
//                    if (self.actionAfterSubmitSuccess) {
//                        self.actionAfterSubmitSuccess(responseObject);
//                    }
//                    [SVProgressHUD dismiss];
//                    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
//                }
//            }
//            else {
//                [SVProgressHUD showErrorWithStatus:message];
//            }
//        } failure:^(NSError * _Nonnull error) {
//            [SVProgressHUD dismiss];
//            [SVProgressHUD showErrorWithStatus:@"提交失败"];
//        }];
    }
}

- (NSDictionary *)getAllFormData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < self.dataArray.count; i ++) {
        JYFormModel *model = self.dataArray[i];
        if (model.style == JYFormModelCellStyle_ImageSelect || model.style == JYFormModelCellStyle_FileSelect || model.style == JYFormModelCellStyle_PersonSelect) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSMutableArray *crossTeamArray = [[NSMutableArray alloc] init];
            for (JYKeyValueModel *tempModel in model.childArray) {
                [array addObject:tempModel.itemId];
                [crossTeamArray addObject:tempModel.tempString];
            }
            [params setValue:array forKey:model.requestKey];
            if (model.ifReturnAllPropertyOfSelectedModel && !kStringIsEmpty(model.identifier4ReturnAllPropertyOfSelectedModel)) {
                [params setValue:crossTeamArray forKey:model.identifier4ReturnAllPropertyOfSelectedModel];
            }
        } else if (model.style == JYFormModelCellStyle_SelectShow) {
            //如果是单点选择，可能多选，所以先找childArray里面的isSelect的model。
            if (model.childArray.count > 0) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (JYKeyValueModel *tempModel in model.childArray) {
                    if (tempModel.isSelected) {
                        [array addObject:tempModel.itemId];
                    }
                }
                if (model.requestKey && ![model.requestKey isEqualToString:@""]) {
                    [params setValue:array forKey:model.requestKey];
                } else {
                    [params setValue:array forKey:model.title];
                }
            } else {
                //处理一下时间的字符串，2021-03-06统一处理成2021/03/06
                if ([model.title containsString:@"时间"] && [JYEasyCodeHelper isNotEmpty:model.contentString]) {
                    NSMutableString *tempString = [NSMutableString stringWithString:model.contentString];
                    
                    NSRange range = {0,tempString.length};
                    
                    [tempString replaceOccurrencesOfString:@"-" withString:@"/" options:NSLiteralSearch range:range];
                    model.contentString = tempString;
                }
                if (model.requestKey && ![model.requestKey isEqualToString:@""]) {
                    [params setValue:model.contentString forKey:model.requestKey];
                } else {
                    [params setValue:model.contentString forKey:model.title];
                }
            }
        } else if (model.style == JYFormModelCellStyle_LabelSwitch) {
            if (model.optionArray.count > 0) {
                for (JYKeyValueModel *tempModel in model.optionArray) {
                    if ([tempModel.name isEqualToString:@"on"]) {
                        [params setValue:@"1" forKey:model.requestKey];
                    }
                    else {
                        [params setValue:@"0" forKey:model.requestKey];
                    }
                }
            }
        } else {
            if (model.requestKey && ![model.requestKey isEqualToString:@""]) {
                [params setValue:model.contentString forKey:model.requestKey];
            } else {
                [params setValue:model.contentString forKey:model.title];
            }
        }
    }
    return params;
}

#pragma mark - method
- (void)showAlertWithMessage:(NSString *)message sureButtonTouchedBlock:(void(^)(void))sureButtonTouchedBlock {
    UIAlertController* reSendVC = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction* reSendAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //确定时候的操作
        if (sureButtonTouchedBlock) {
            sureButtonTouchedBlock();
        }
    }];

    [cancelAction setValue:[UIColor colorWithHexString:@"#BFC2CC"] forKey:@"titleTextColor"];
    [reSendAction setValue:[UIColor colorWithHexString:@"#0090FF"] forKey:@"titleTextColor"];
    
    [reSendVC addAction:reSendAction];
    [reSendVC addAction:cancelAction];
    [self presentViewController:reSendVC animated:YES completion:nil];
}

#pragma mark -------------- UITableViewDelegate & dataSource --------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYFormModel *model = self.dataArray[indexPath.row];
    if (model.isHiddenCell) {
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYFormModel *model = self.dataArray[indexPath.row];
    if (model.style == JYFormModelCellStyle_GrayBar) {
        JYFormCell_GrayBar *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_GrayBar class])];
        return cell;
    } else if (model.style == JYFormModelCellStyle_GrayBarWithTitle) {
        JYFormCell_GrayBarWithTitle *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_GrayBarWithTitle class])];
        cell.model = model;
        return cell;
    } else if (model.style == JYFormModelCellStyle_MultiSelectButton) {
        JYFormCell_MultiSelect *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_MultiSelect class])];
        JYFormModel *tempModel = [[JYFormModel alloc] init];
        tempModel.title = @"JackYoung";
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i ++) {
            JYKeyValueModel *model = [[JYKeyValueModel alloc] init];
            model.name = [NSString stringWithFormat:@"item%d",i];
            [array addObject:model];
        }
        tempModel.childArray = array;
        cell.model = tempModel;
        return cell;
    } else if (model.style == JYFormModelCellStyle_SectionHeaderTitleLabel) {
        JYFormCell_SectionHeaderTitleLabel *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SectionHeaderTitleLabel class])];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else if (model.style == JYFormModelCellStyle_CommentTextViewInput) {
        JYFormCell_CommentTextViewInput *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_CommentTextViewInput class])];
        cell.model = self.dataArray[indexPath.row];
        weakSelf(self)
        cell.refreshBlock = ^{
            [weakSelf.tableView reloadData];
        };
        return cell;
    } else if (model.style == JYFormModelCellStyle_ImageSelect) {
        JYFormCell_SelectImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SelectImageCell class])];
        weakSelf(self);
        cell.refreshBlock = ^{
            [weakSelf.tableView reloadData];
        };
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else if (model.style == JYFormModelCellStyle_FileSelect) {
        JYFormCell_SelectFile *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SelectFile class])];
        weakSelf(self);
        cell.refreshBlock = ^{
            [weakSelf.tableView reloadData];
        };
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else if (model.style == JYFormModelCellStyle_PersonSelect) {
        JYFormCell_SelectPerson *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SelectPerson class])];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else if (model.style == JYFormModelCellStyle_SectionHeaderLightGrayTitle) {
        JYFormCell_SectionHeaderLightGrayTitle *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SectionHeaderLightGrayTitle class])];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else if (model.style == JYFormModelCellStyle_LabelSwitch) {
        JYFormCell_LabelSwitch *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_LabelSwitch class])];
        cell.model = self.dataArray[indexPath.row];
        weakSelf(self);
        cell.isSwitchOnBlock = ^(BOOL isOn, UISwitch * _Nonnull mySwitch) {
            if (weakSelf.isSwitchOnBlock) {
                weakSelf.isSwitchOnBlock(isOn, mySwitch);
            }
        };
        return cell;
    } else if (model.style == JYFormModelCellStyle_RadioSelect) {
        JYFormCell_RadioSelect *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_RadioSelect class])];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else if (model.style == JYFormModelCellStyle_SelectShow) {
        JYFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell class])];
        weakSelf(self);
        cell.refreshBlock = ^{
            [weakSelf.tableView reloadData];
        };
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else if (model.style == JYFormModelCellStyle_SelectShowWithImage) {
        JYFormCell_SelectShowWithImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SelectShowWithImageCell class])];
        weakSelf(self);
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else {
        JYFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell class])];
        cell.model = self.dataArray[indexPath.row];
        weakSelf(self);
        cell.refreshBlock = ^{
            [weakSelf.tableView reloadData];
        };
        return cell;
    }
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

#pragma mark ---------------- lazy loading -------------------------------
- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        _submitButton.backgroundColor = [UIColor colorWithHexString:@"#1E72FF"];
        _submitButton.layer.cornerRadius = 5;
        _submitButton.clipsToBounds = true;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_submitButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    return _submitButton;
}

@end
