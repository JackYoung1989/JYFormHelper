//
//  JYTableViewController.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/13.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYTableViewController.h"

@interface JYTableViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIImageView *noDataImageView;
@property (nonatomic, strong)UILabel *noDataTitleLabel;
@property (nonatomic, strong)UIView *hasNoDataBgView;

@end

@implementation JYTableViewController

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    
    weakSelf(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataRefresh:true];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataRefresh:false];
    }];
    [self.view addSubview:self.tableView];
    
    self.hasNoDataBgView = [[UIView alloc] init];
    self.hasNoDataBgView.hidden = true;
    [self.tableView addSubview:self.hasNoDataBgView];
    [self.hasNoDataBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.offset(100);
        make.height.offset(100);
    }];
    
    [self.hasNoDataBgView addSubview:self.noDataImageView];
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(10);
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    [self.hasNoDataBgView addSubview:self.noDataTitleLabel];
    [self.noDataTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(0);
        make.width.offset(250);
        make.height.offset(50);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setIsHasHeaderRefresh:(BOOL)isHasHeaderRefresh {
    _isHasFooterRefresh = isHasHeaderRefresh;
    weakSelf(self)
    if (isHasHeaderRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadDataRefresh:true];
        }];
    } else {
        self.tableView.mj_header = nil;
    }
}

- (void)setIsHasFooterRefresh:(BOOL)isHasFooterRefresh {
    _isHasFooterRefresh = isHasFooterRefresh;
    weakSelf(self)
    if (isHasFooterRefresh) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadDataRefresh:false];
        }];
    } else {
        self.tableView.mj_footer = nil;
    }
}

- (void)setIsHasSearchBarUpTableView:(BOOL)isHasSearchBarUpTableView {
    if (isHasSearchBarUpTableView) {
        /*******      搜索      *******/
        UIView *bgView = [[UIView alloc] init];
        [self.view addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.right.offset(0);
            make.height.offset(52);
        }];
        
        [bgView addSubview:self.searchTextField];
        [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(11);
            make.left.offset(8);
            make.right.offset(-8);
            make.height.offset(36);
        }];
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(bgView.mas_bottom).offset(0);
            make.bottom.offset(-kBottomInset);
        }];
    } else {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(0);
            make.bottom.offset(-kBottomInset);
        }];
    }
}


#pragma mark ------------- UITextFieldDelegate -------------------
- (void)textFieldDidChanged:(UITextField *)textField {
    [self loadDataRefresh:true];
    //在sendRequest里面将textField.text传进去
    NSLog(@"textFieldDidEndEditing______%@",textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:true];
    return true;
}

/**
 发送网络请求
 */
- (void)sendRequest:(void (^)(NSArray * _Nonnull))success failureBlock:(void (^)(NSString * _Nonnull))failure {
//    NSString * url = [NSString stringWithFormat:@"%@%@", Base_URL, @"/api-hrm-employ/v1/hrm/employOfferTemplate/list"];
//    [NetworkHelper GET:url parameters:@{} success:^(id  _Nullable responseObject) {
//        NSArray * resultArr = [NSArray modelArrayWithClass:NSObject.class json:responseObject];
//        success(resultArr);
//    } failure:^(NSError * _Nonnull error) {
//        failure(error.localizedDescription);
//    }];
}

- (void)loadDataRefresh:(BOOL)isRefresh {
    if (isRefresh) {
        self.pageNum = 1;
    } else {
        self.pageNum = self.pageNum + 1;
    }
    [self sendRequest:^(NSArray * _Nonnull resultArray) {
        //如果没有数据，显示暂无数据。
        if (resultArray.count == 0) {
            self.hasNoDataBgView.hidden = false;
        } else {
            self.hasNoDataBgView.hidden = true;
        }
        
        if (self.pageNum == 1) {
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:resultArray];
        [self reloadData];
        [self.tableView.mj_header endRefreshing];
        if (resultArray.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    } failureBlock:^(NSString * _Nonnull failure) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showInfoWithStatus:failure];
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark ------------- UITableViewDelegate & DataSource ---------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark ------------- LazyLoading ----------------
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView registerClass:[CCKeyValueListCell class] forCellReuseIdentifier:NSStringFromClass([CCKeyValueListCell class])];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        
        UIView *imageBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18+9+9, 18)];
        imageBgView.backgroundColor = UIColor.clearColor;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, 18+8+8, 18)];
        imageView.image = [UIImage imageNamed:@"common_ic_search"];
        imageView.contentMode = UIViewContentModeCenter;
        [imageBgView addSubview:imageView];
        _searchTextField.leftView = imageBgView;
        _searchTextField.placeholder = @"搜索企业名称";
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.enablesReturnKeyAutomatically = YES;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.font = [UIFont systemFontOfSize:14];
        _searchTextField.layer.cornerRadius = 9.0;
        _searchTextField.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] init];
        _noDataImageView.image = [UIImage imageNamed:@"WorkModule_Empty"];
    }
    return _noDataImageView;
}

- (UILabel *)noDataTitleLabel {
    if (!_noDataTitleLabel) {
        _noDataTitleLabel = [[UILabel alloc] init];
        _noDataTitleLabel.text = @"暂无数据";
        _noDataTitleLabel.textAlignment = NSTextAlignmentCenter;
        _noDataTitleLabel.textColor = [UIColor darkGrayColor];
        _noDataTitleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _noDataTitleLabel;
}

@end
