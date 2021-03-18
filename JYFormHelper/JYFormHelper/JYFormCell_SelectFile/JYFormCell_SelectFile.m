//
//  JYFormCell_SelectFile.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/7.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectFile.h"
#import "JYFormCell_SelectFileCell.h"
#import "JYFormCell_SelectFileAddCell.h"
#import "JYFileModel.h"

@interface JYFormCell_SelectFile()<UITableViewDelegate,UITableViewDataSource,UIDocumentPickerDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign) BOOL isSetDraftFileOrImage; //是否设置过草稿中的附加或者图片

@end

@implementation JYFormCell_SelectFile

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    self.fileArray = [NSMutableArray array];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-22);
    }];
    [self updateTableViewFrameAndData];
}

- (void)setModel:(JYFormModel *)model {
    [super setModel:model];
    if (self.model.fileOrImageArray.count > 0 && !self.isSetDraftFileOrImage) {
        self.isSetDraftFileOrImage = true;
        self.fileArray = self.model.fileOrImageArray.mutableCopy;
        
        //将默认的数据转成childArray，用于以后编辑
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.fileArray.count; i ++) {
            JYFileModel *fileModel = self.fileArray[i];
            //保存model的json字符串，提交数据的时候，直接提交json字符串。
            JYKeyValueModel *tempModel = [[JYKeyValueModel alloc] init];
            tempModel.itemId = [NSString jsonStringWithDictionary:[fileModel modelToJSONObject]];
            [tempArray addObject:tempModel];
        }
        self.model.childArray = tempArray;
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
            make.left.offset(16);
            make.right.offset(-16);
            make.bottom.offset(-22);
        }];
        
        [self.tableView reloadData];
        
        CGFloat tableViewHeight = self.fileArray.count * (56 + 15) + 60;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(tableViewHeight);
        }];
    }
}

- (void)updateTableViewFrameAndData {
    [self.tableView reloadData];
    
    CGFloat tableViewHeight = self.fileArray.count * (56 + 15) + 60;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(tableViewHeight);
    }];
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

#pragma mark --------- UITabelViewDelegate & DataSource ------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fileArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.fileArray.count) {
        JYFormCell_SelectFileAddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SelectFileAddCell class])];
        return cell;
    } else {
        JYFormCell_SelectFileCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYFormCell_SelectFileCell class])];
        cell.fileModel = self.fileArray[indexPath.row];
        weakSelf(self)
        cell.deleteItemWithIndexBlock = ^(NSInteger index) {
            if (weakSelf.fileArray.count > index) {
                [weakSelf.fileArray removeObjectAtIndex:index];
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.model.childArray];
                [tempArray removeObjectAtIndex:index];
                weakSelf.model.childArray = tempArray;
                [weakSelf updateTableViewFrameAndData];
            }
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.fileArray.count) {
        NSLog(@"点击了添加");
        if (self.fileArray.count == 20) {
            [SVProgressHUD showInfoWithStatus:@"附件最多添加20个"];
            return;
        }
        NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
        
        UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
        documentPickerViewController.delegate = self;
        [self.viewController presentViewController:documentPickerViewController animated:YES completion:nil];
    } else {
        NSLog(@"点击了cell%ld",indexPath.row);
    }
}

#pragma mark ---------- UIDocumentPickerDelegate ---------------------
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    //获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            //读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSString *filePath = [newURL absoluteString];
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            if (error) {
                //读取出错
                [urls.firstObject stopAccessingSecurityScopedResource];
            }
            else {
                if (fileData.length > 1000 * 1000 * 10) {
                    [SVProgressHUD showInfoWithStatus:@"文件大小不能超过10M"];
                    return;
                }
                
                [self uploadImageWithNewUrl:[NSString stringWithFormat:@"%@", newURL]];
            }
        }];
    }
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    //获取授权
    BOOL fileUrlAuthozied = [url startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error = nil;
        
        weakSelf(Self)
        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
            //读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            if (fileData.length > 1000*1000*10) {
                [SVProgressHUD showInfoWithStatus:@"文件大小不能超过10M"];
                return;
            }
        }];
        [url stopAccessingSecurityScopedResource];
    } else {
        //授权失败
    }
}

- (void)uploadImageWithNewUrl:(NSString *)myNewUrl {
    if (myNewUrl && ![myNewUrl isEqualToString:@""]) {
        [self uploadFilesRequestWithFileURLs:[NSArray arrayWithObject:myNewUrl] isSave:NO WithCompletion:^(id response) {
            
            NSArray *fileArray = [NSArray modelArrayWithClass:[JYFileModel class] json:response];
            [self.fileArray addObjectsFromArray:fileArray];
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.fileArray.count; i ++) {
                JYFileModel *fileModel = self.fileArray[i];
                //保存model的json字符串，提交数据的时候，直接提交json字符串。
                JYKeyValueModel *tempModel = [[JYKeyValueModel alloc] init];
                tempModel.itemId = [NSString jsonStringWithDictionary:[fileModel modelToJSONObject]];
                [tempArray addObject:tempModel];
            }
            [SVProgressHUD dismiss];
            self.model.childArray = tempArray;
            [self updateTableViewFrameAndData];
        }];
    }
}

/**上传附件*/
- (void)uploadFilesRequestWithFileURLs:(NSArray *)newURLs isSave:(BOOL)isSave WithCompletion:(void (^)(id response))completion {
    [SVProgressHUD showWithStatus:@"上传中"];
    
//    NSData* data = [NSData data];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"type"] = @"0";
//    [NetworkHelper uploadFileDocumentsWithURL:[NSString stringWithFormat:@"%@%@",Document_Base_URL,upLoadAllAndroid_URL] parameters:param data:data name:@"file" fileNames:newURLs mimeType:@"tmp" progress:^(NSProgress * _Nonnull progress) {
//        NSLog(@"%@", progress);
//    } success:^(id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//        if (completion) {
//            completion(responseObject);
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//    }];
    //JackYoung演示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString *responseObject = @"[  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/01d3bce62be649c1b5444804d1ee152e.PNG\",    \"fileSize\" : 227737,    \"fileType\" : \"PNG\",    \"newFileName\" : null,    \"originalFileName\" : \"simulator_screenshot_EFC1D825-05A6-4C0A-B7C6-97870510EB58.PNG\"  }]";
        if (completion) {
            completion(responseObject);
        }
    });
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JYFormCell_SelectFileCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SelectFileCell class])];
        [_tableView registerClass:[JYFormCell_SelectFileAddCell class] forCellReuseIdentifier:NSStringFromClass([JYFormCell_SelectFileAddCell class])];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.clipsToBounds = true;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

@end
