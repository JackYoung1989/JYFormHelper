//
//  JYFormViewController.m
//  iOS
//
//  Created by JackYoung on 2021/1/26.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYFormViewController.h"
#import "JYFormModel.h"
#import "JYFormCell.h"
#import "JYFormCell_MultiSelect.h"
#import "JYFormCell_GrayBar.h"
#import "JYFormCell_SectionHeaderTitleLabel.h"
#import "JYFormCell_CommentTextViewInput.h"

//自定义Ai报告
@interface JYFormViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JYFormViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc] init];
    
    JYFormModel *model = [[JYFormModel alloc] init];
    model.title = @"学生范围";
    model.requestKey = @"";//人或部门ID集合
    model.isMust = true;
    model.placeHolder = @"请选择666";
    model.style = JYFormModelCellStyle_SelectShow;
    [self.dataArray addObject:model];

    JYFormModel *model1 = [[JYFormModel alloc] init];
    model1.title = @"毕业时间";
    model1.requestKey = @"";//查询日期类型 0其他时间段 1日报 2周报 3月报
    model1.isMust = true;
    model1.isSelectable = true;
    model1.placeHolder = @"请选择";
    model1.style = JYFormModelCellStyle_SelectShow;
    [self.dataArray addObject:model1];

    JYFormModel *model2 = [[JYFormModel alloc] init];
    model2.title = @"学生范围";
    model2.requestKey = @"";
    model2.style = JYFormModelCellStyle_SelectShow;
    [self.dataArray addObject:model2];
    
    JYFormModel *model6 = [[JYFormModel alloc] init];
    model6.title = @"这是个section";
    model6.style = JYFormModelCellStyle_SectionHeaderTitleLabel;
    [self.dataArray addObject:model6];
    
    JYFormModel *model3 = [[JYFormModel alloc] init];
    model3.title = @"毕业时间";
    model3.requestKey = @"";
    model3.style = JYFormModelCellStyle_SelectShow;
    [self.dataArray addObject:model3];
    
    JYFormModel *model4 = [[JYFormModel alloc] init];
    model4.title = @"可以输入";
    model4.requestKey = @"";
    model4.style = JYFormModelCellStyle_InputTextField;
    model4.inputMaxLength = 5;
    [self.dataArray addObject:model4];

    JYFormModel *model7 = [[JYFormModel alloc] init];
    model7.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model7];

    JYFormModel *model5 = [[JYFormModel alloc] init];
    model5.title = @"表现如何";
    model5.requestKey = @"";
    model5.style = JYFormModelCellStyle_ShowOnly;
    model5.contentDisplay = @"JackYoung is a good boy!!!\n  JackYoung is a good boy!!!\n JackYoung is a good boy!!!你好，我是杨杰";
    [self.dataArray addObject:model5];
    
    JYFormModel *model9 = [[JYFormModel alloc] init];
    model9.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model9];
    
    JYFormModel *model8 = [[JYFormModel alloc] init];
    model8.title = @"描述";
    model8.requestKey = @"";
    model8.style = JYFormModelCellStyle_CommentTextViewInput;
    model8.inputMaxLength = 5;
    [self.dataArray addObject:model8];
    
    [self createUI];
}

- (void)onCreateButtonTouched {
    
}

- (void)createUI {
    UIView *navBarView = [[UIView alloc] init];
    navBarView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:navBarView];
    [navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kStatusBarHeight);
        make.left.right.offset(0);
        make.height.offset(kNavBarHeight);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[JYFormCell_MultiSelect class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_MultiSelect class])];
    [self.tableView registerClass:[JYFormCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell class])];
    [self.tableView registerClass:[JYFormCell_GrayBar class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_GrayBar class])];
    [self.tableView registerClass:[JYFormCell_SectionHeaderTitleLabel class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SectionHeaderTitleLabel class])];
    [self.tableView registerClass:[JYFormCell_CommentTextViewInput class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_CommentTextViewInput class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kStatusBarHeight + kNavBarHeight);
        make.left.right.offset(0);
        make.bottom.offset(-65 - kBottomInset);
    }];
    
//    UIView *bottomBgView = [[UIView alloc] init];
//    [self.view addSubview:bottomBgView];
//    [bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.height.offset(65 + kBottomInset);
//        make.bottom.offset(0);
//    }];
    
//    UIButton *submitButton = [[UIButton alloc] init];
//    submitButton.backgroundColor = [UIColor colorWithHexString:@"#328CFF"];
//    submitButton.layer.cornerRadius = 5;
//    submitButton.clipsToBounds = true;
//    [submitButton setTitle:@"生成报表" forState:UIControlStateNormal];
//    [submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
//    [submitButton addTarget:self action:@selector(onSubmitButtonTouched) forControlEvents:UIControlEventTouchUpInside];
//    [bottomBgView addSubview:submitButton];
//    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(16);
//        make.right.offset(-16);
//        make.top.offset(10);
//        make.height.offset(45);
//    }];
}

- (void)onSubmitButtonTouched {
    
}

#pragma mark -------------- UITableViewDelegate & dataSource --------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYFormModel *model = self.dataArray[indexPath.row];
    if (model.style == JYFormModelCellStyle_GrayBar) {
        JYFormCell_GrayBar *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_GrayBar class])];
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
        return cell;
    } else {
        if ([model.title isEqualToString:@"可以输入"]) {
            JYFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell class])];
            cell.model = self.dataArray[indexPath.row];
            weakSelf(self)
            cell.inputReturnBlock = ^(NSString * _Nonnull resultText) {
                JYFormModel *model = [JYFormModel getModelWithTitle:@"可以输入" inArray:weakSelf.dataArray];
                model.contentString = resultText;
            };
            return cell;
        } else {
            JYFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell class])];
            cell.model = self.dataArray[indexPath.row];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JYFormModel *model = self.dataArray[indexPath.row];
    if ([model.title isEqualToString:@"学生范围"]) {
        [BRStringPickerView showPickerWithTitle:@"select" dataSourceArr:@[@"我的",@"你的"] selectIndex:1 resultBlock:^(BRResultModel * _Nullable resultModel) {
            JYFormModel *tempModel = [JYFormModel getModelWithTitle:@"学生范围" inArray:self.dataArray];
            NSLog(@"选择了%@",resultModel);
            tempModel.contentDisplay = resultModel.value;
            tempModel.contentString = [NSString stringWithFormat:@"%d",resultModel.index];
            [self.tableView reloadData];
        }];
    } else if ([model.title isEqualToString:@"毕业时间"]) {
        [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"选择时间" selectValue:@"2020-10-10" resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            JYFormModel *tempModel = [JYFormModel getModelWithTitle:@"毕业时间" inArray:self.dataArray];
            NSLog(@"选择了%@",selectValue);
            tempModel.contentDisplay = selectValue;
            [self.tableView reloadData];
        }];
    }
}

@end
