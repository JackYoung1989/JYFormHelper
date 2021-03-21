//
//  JYFormDemoViewController.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/8.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormDemoViewController.h"
#import "JYFormModel.h"
#import "BRDatePickerView.h"
#import "JYFormCell_LabelSwitch.h"
#import "JYTestModel.h"

@interface JYFormDemoViewController ()

@property (nonatomic, strong)JYTestModel *netModel;

@end

@implementation JYFormDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建";
    
    self.netModel = [[JYTestModel alloc] init];
    self.netModel.startDefaultTime = @"2020-10-10";
    self.netModel.inputDefaultText = @"JackYoung";
    self.netModel.showOnlyText = @"JackYoung is a good boy!!!\n  JackYoung is a good boy!!!\n JackYoung is a good boy!!!你好，我是杨杰";
    self.netModel.describeString = @"描述内容123";
    self.netModel.defaultPersonArray = @[];
    self.netModel.defaultImageArray = [NSArray modelArrayWithClass:[JYFileModel class] json:@"[  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/32b5dddb673c421fa52fb10cda08e49a.jpg\",    \"fileSize\" : 382108,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  }]"];
    self.netModel.defaultFileArray = [NSArray modelArrayWithClass:[JYFileModel class] json:@"[  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },   {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  }]"];;
    
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
    keyValueModel.isSelected = false;
    [switchDataArray addObject:keyValueModel];
    JYKeyValueModel *keyValueModel1 = [[JYKeyValueModel alloc] init];
    keyValueModel1.name = @"off";
    keyValueModel1.itemId = @"0";
    keyValueModel1.isSelected = true;
    [switchDataArray addObject:keyValueModel1];
    model3.optionArray = switchDataArray;
    
    [self.dataArray addObject:model3];
    
    JYFormModel *model4 = [[JYFormModel alloc] init];
    model4.style = JYFormModelCellStyle_GrayBar;
    model4.title = @"grayBar_push_nextOne";
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
    if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.startDefaultTime]) {
        model71.contentString = self.netModel.startDefaultTime;
    }
    model71.requestKey = @"";
    model71.style = JYFormModelCellStyle_SelectShow;
    [self.dataArray addObject:model71];
    
    JYFormModel *model8 = [[JYFormModel alloc] init];
    model8.title = @"可以输入";
    model8.requestKey = @"";
    model8.placeHolder = @"Jack is a good boy";
    if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.inputDefaultText]) {
        model8.contentString = self.netModel.inputDefaultText;
    }
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
    if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.showOnlyText]) {
        model10.contentDisplay = self.netModel.showOnlyText;
    }
    [self.dataArray addObject:model10];
    
    JYFormModel *model11 = [[JYFormModel alloc] init];
    model11.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model11];
    
    JYFormModel *model12 = [[JYFormModel alloc] init];
    model12.title = @"描述";
    model12.placeHolder = @"JackYoung请输入描述";
    model12.requestKey = @"";
    if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.describeString]) {
        model12.contentDisplay = self.netModel.describeString;
    }
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
    NSMutableArray *records = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < 3; i ++) {
        JYKeyValueModel *keyValuemodel = [[JYKeyValueModel alloc] init];
        keyValuemodel.name = @"杨杰";
        keyValuemodel.itemId = @"33333";
        if (i == 0 || i == 2) {
            keyValuemodel.itemId = @"3";
        }
        keyValuemodel.imageUrl = @"";
        [records addObject:keyValuemodel];
    }
    if (records.count > 0) {
        model14.childArray = [records copy];
    }
    
    model14.style = JYFormModelCellStyle_PersonSelect;
    [self.dataArray addObject:model14];
    
    JYFormModel *model15 = [[JYFormModel alloc] init];
    model15.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model15];
    
    JYFormModel *model16 = [[JYFormModel alloc] init];
    model16.title = @"图片选择6";
    model16.requestKey = @"";
    if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.defaultImageArray]) {
        model16.fileOrImageArray = self.netModel.defaultImageArray;
    }
    
    model16.style = JYFormModelCellStyle_ImageSelect;
    [self.dataArray addObject:model16];
    
    JYFormModel *model17 = [[JYFormModel alloc] init];
    model17.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model17];
    
    JYFormModel *model18 = [[JYFormModel alloc] init];
    model18.title = @"文件选择";
    model18.isMust = true;
    model18.requestKey = @"";
    if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.defaultFileArray]) {
        model18.fileOrImageArray = self.netModel.defaultFileArray;
    }
    model18.style = JYFormModelCellStyle_FileSelect;
    model18.inputMaxLength = 5;
    [self.dataArray addObject:model18];
    
    JYFormModel *model19 = [[JYFormModel alloc] init];
    model19.style = JYFormModelCellStyle_GrayBar;
    [self.dataArray addObject:model19];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYFormModel *model = self.dataArray[indexPath.row];
    if (model.style == JYFormModelCellStyle_LabelSwitch) {
        JYFormCell_LabelSwitch *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_LabelSwitch class])];
        cell.model = self.dataArray[indexPath.row];
        cell.isSwitchOnBlock = ^(BOOL isOn, UISwitch * _Nonnull mySwitch) {
            if (isOn) {//switch选中了
                JYFormModel *model89 = [[JYFormModel alloc] init];
                model89.title = @"消息内容";
                model89.isMust = true;
                model89.requestKey = @"msg";
                if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.describeString]) {
                    model89.contentString = self.netModel.describeString;
                    model89.contentDisplay = self.netModel.describeString;
                }
                model89.placeHolder = @"请输入消息内容2323";
                model89.style = JYFormModelCellStyle_CommentTextViewInput;
                [JYFormModel insertModel:model89 afterTitle:@"grayBar_push_nextOne" inArray:self.dataArray];
                [self.tableView reloadData];
            } else {
                [JYFormModel deleteModelWithTitle:@"消息内容" inArray:self.dataArray];
                [self.tableView reloadData];
            }
        };
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
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
