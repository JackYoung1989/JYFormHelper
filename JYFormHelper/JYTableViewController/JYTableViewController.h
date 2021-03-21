//
//  JYTableViewController.h
//  JackYoung
//
//  Created by JackYoung on 2021/2/13.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

/**
 是不是有下拉刷新
 */
@property (nonatomic, assign)BOOL isHasHeaderRefresh;

/**
 tableView上面是不是有搜索框？
 */
@property (nonatomic, assign)BOOL isHasSearchBarUpTableView;

/**
 是不是有上拉刷新
 */
@property (nonatomic, assign)BOOL isHasFooterRefresh;
@property (nonatomic, strong) UITableView *tableView;

/**
 搜索框
 */
@property (nonatomic, strong) UITextField *searchTextField;

/**
 请求的时候的页码。
 */
@property (nonatomic, assign) NSInteger pageNum;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 如果在刷新数据之前想要对dataSource数据源进行处理，可以重写该方法。
 */
- (void)reloadData;

/**
 发送网络请求,取出对应的model的数组即可，通过success(NSArray *)返回内容数组，在父类中处理。
 */
- (void)sendRequest:(void (^)(NSArray * _Nonnull))success failureBlock:(void (^)(NSString * _Nonnull))failure;

/**
 加载数据，isRefresh如果是true：刷新，false：上拉加载更多
 */
- (void)loadDataRefresh:(BOOL)isRefresh;

@end

NS_ASSUME_NONNULL_END
