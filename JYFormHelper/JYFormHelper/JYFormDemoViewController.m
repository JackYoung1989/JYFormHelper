//
//  JYFormDemoViewController.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/8.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormDemoViewController.h"
#import "JYFormModel.h"
#import "JYKeyValueModel.h"
#import "BRDatePickerView.h"

@interface JYFormDemoViewController ()

@end

@implementation JYFormDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建";
    [self configFormView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (void)configFormView {
    JYFormModel *model0 = [[JYFormModel alloc] init];
    model0.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model0];
    
    JYFormModel *model1 = [[JYFormModel alloc] init];
    model1.style = JYFormModelCellStyle_RadioSelect;
    model1.title = @"RadioSelect";
    model1.requestKey = model1.title;
    model1.isMust = true;
    //添加选择项
    NSMutableArray *optionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i ++) {
        JYKeyValueModel *model = [[JYKeyValueModel alloc] init];
        model.name = @"JackYoung";
        model.itemId = [NSString stringWithFormat:@"%d",i];
        if (i == 1) {
            model.isSelected = true;
        }
        [optionArray addObject:model];
    }
    model1.optionArray = optionArray;
    [self.dataArray addObject:model1];
    
    JYFormModel *model2 = [[JYFormModel alloc] init];
    model2.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model2];
    
    JYFormModel *model3 = [[JYFormModel alloc] init];
    model3.title = @"是否推送消息";
    model3.requestKey = model3.title;
    model3.isMust = true;
    model3.style = JYFormModelCellStyle_LabelSwitch;
    
    NSMutableArray *switchDataArray = [[NSMutableArray alloc] init];
    JYKeyValueModel *keyValueModel = [[JYKeyValueModel alloc] init];
    keyValueModel.name = @"on";
    keyValueModel.itemId = @"1";
    keyValueModel.isSelected = true;
    [switchDataArray addObject:keyValueModel];
    JYKeyValueModel *keyValueModel1 = [[JYKeyValueModel alloc] init];
    keyValueModel1.name = @"off";
    keyValueModel1.itemId = @"0";
    [switchDataArray addObject:keyValueModel1];
    model3.optionArray = switchDataArray;
    
    [self.dataArray addObject:model3];
    
    JYFormModel *model4 = [[JYFormModel alloc] init];
    model4.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model4];
    
    JYFormModel *model5 = [[JYFormModel alloc] init];
    model5.title = @"这是个section";
    model5.style = JYFormModelCellStyle_SectionHeaderTitleLabel;
    [self.dataArray addObject:model5];
    
    JYFormModel *model6 = [[JYFormModel alloc] init];
    model6.title = @"起止时间";
    model6.requestKey = @"";
    model6.style = JYFormModelCellStyle_SectionHeaderLightGrayTitle;
    [self.dataArray addObject:model6];
    
    JYFormModel *model7 = [[JYFormModel alloc] init];
    model7.title = @"itemSelect";
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i ++) {
        JYKeyValueModel *model = [[JYKeyValueModel alloc] init];
        if (i % 2 == 0) {
            model.itemId = @"0";
            model.name = @"item0";
        } else {
            model.itemId = @"1";
            model.name = @"item1";
            model.isSelected = true;
        }
        [tempArray addObject:model];
    }
    model7.optionArray = tempArray;
    
    model7.requestKey = @"";
    model7.style = JYFormModelCellStyle_SelectShow;
    [self.dataArray addObject:model7];
    
    JYFormModel *model91 = [[JYFormModel alloc] init];
    model91.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model91];
    
    JYFormModel *model71 = [[JYFormModel alloc] init];
    model71.title = @"开始时间";
    model71.requestKey = @"";
    model71.style = JYFormModelCellStyle_SelectShow;
    [self.dataArray addObject:model71];
    
    JYFormModel *model8 = [[JYFormModel alloc] init];
    model8.title = @"可以输入";
    model8.requestKey = @"";
    model8.placeHolder = @"Jack is a good boy";
    model8.style = JYFormModelCellStyle_InputTextField;
    model8.inputMaxLength = 5;
    [self.dataArray addObject:model8];

    JYFormModel *model9 = [[JYFormModel alloc] init];
    model9.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model9];

    JYFormModel *model10 = [[JYFormModel alloc] init];
    model10.title = @"表现如何";
    model10.requestKey = @"";
    model10.style = JYFormModelCellStyle_ShowOnly;
    model10.contentDisplay = @"JackYoung is a good boy!!!\n  JackYoung is a good boy!!!\n JackYoung is a good boy!!!你好，我是杨杰";
    [self.dataArray addObject:model10];
    
    JYFormModel *model11 = [[JYFormModel alloc] init];
    model11.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model11];
    
    JYFormModel *model12 = [[JYFormModel alloc] init];
    model12.title = @"描述";
    model12.placeHolder = @"JackYoung请输入描述";
    model12.requestKey = @"";
    model12.style = JYFormModelCellStyle_CommentTextViewInput;
    model12.inputMaxLength = 5;
    [self.dataArray addObject:model12];
    
    JYFormModel *model13 = [[JYFormModel alloc] init];
    model13.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model13];
    
    JYFormModel *model14 = [[JYFormModel alloc] init];
    model14.title = @"执行人";
    model14.isMust = true;
    model14.requestKey = @"";
    model14.style = JYFormModelCellStyle_PersonSelect;
    [self.dataArray addObject:model14];
    
    JYFormModel *model15 = [[JYFormModel alloc] init];
    model15.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model15];
    
    JYFormModel *model16 = [[JYFormModel alloc] init];
    model16.title = @"图片选择6";
    model16.requestKey = @"";
    model16.style = JYFormModelCellStyle_ImageSelect;
    [self.dataArray addObject:model16];
    
    JYFormModel *model17 = [[JYFormModel alloc] init];
    model17.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model17];
    
    JYFormModel *model18 = [[JYFormModel alloc] init];
    model18.title = @"文件选择";
    model18.isMust = true;
    model18.requestKey = @"";
    model18.style = JYFormModelCellStyle_FileSelect;
    model18.inputMaxLength = 5;
    [self.dataArray addObject:model18];
    
    JYFormModel *model19 = [[JYFormModel alloc] init];
    model19.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model19];
}

//重写点击之后选择，因为涉及的情况比较多，在这里进行处理。
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JYFormModel *model = self.dataArray[indexPath.row];
    if (model.style == JYFormModelCellStyle_SelectShow) {
        if ([model.title containsString:@"时间"]) {
            [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"选择时间" selectValue:@"2020-10-10" resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                NSLog(@"选择了%@",selectValue);
                model.contentString = selectValue;
                [self.tableView reloadData];
            }];
        }
    }
}

@end
