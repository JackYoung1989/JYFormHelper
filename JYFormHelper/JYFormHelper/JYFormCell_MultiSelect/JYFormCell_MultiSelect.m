//
//  JYFormCell_MultiSelect.m
//  iOS
//
//  Created by JackYoung on 2021/1/26.
//  Copyright © 2021 JackYoung. All rights reserved.
//

#import "JYFormCell_MultiSelect.h"
#import "JYSingWordCollectionCell.h"
#import "JYFormModel.h"

@interface JYFormCell_MultiSelect()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) JYButton *selectAllButton;
@property (nonatomic, strong)NSArray *dataArray;//放元素的数组

@end

@implementation JYFormCell_MultiSelect

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _dataArray = [[NSArray alloc] init];
    UIView *grayBar = [[UIView alloc] init];
    grayBar.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    [self.contentView addSubview:grayBar];
    [grayBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(10);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"客户管理";
    [_titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_titleLabel setTextColor:[UIColor colorWithHexString:@"#303133"]];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(25);
        make.width.offset(100);
        make.height.offset(20);
    }];
    
    _selectAllButton = [[JYButton alloc] init];
    _selectAllButton.spaceBetweenTitleAndImage = 5;
    _selectAllButton.imageAlignment = JYButtonImageAlignmentLeft;
    [_selectAllButton setImage:[UIImage imageNamed:@"grayRadioUnselsect"] forState:UIControlStateNormal];
    [_selectAllButton setImage:[UIImage imageNamed:@"blueRadioSelsect"] forState:UIControlStateSelected];
    [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [_selectAllButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_selectAllButton setTitleColor:[UIColor colorWithHexString:@"#606266"] forState:UIControlStateNormal];
    [_selectAllButton addTarget:self action:@selector(onSelectAllButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectAllButton];
    [_selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.centerY.equalTo(self.titleLabel);
        make.width.offset(52);
        make.height.offset(20);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106, 36);
    layout.minimumLineSpacing = 15;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView registerClass:[JYSingWordCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([JYSingWordCollectionCell class])];
    [self.contentView addSubview:self.collectionView];
}

- (void)onSelectAllButtonTouched:(UIButton *)button {
    button.selected = !button.isSelected;
    for (int i = 0; i < self.dataArray.count; i ++) {
        JYKeyValueModel *model = self.dataArray[i];
        model.isSelected = button.isSelected;
    }
    [self.collectionView reloadData];
}

#pragma mark ----------------- UICollectionView Delegate & dataSource -----------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYSingWordCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYSingWordCollectionCell class]) forIndexPath:indexPath];
    JYKeyValueModel *model = self.dataArray[indexPath.row];
    cell.titleString = model.name;
    cell.indexPath = indexPath;
    cell.isSelected = model.isSelected;
    weakSelf(self)
    cell.block = ^(NSIndexPath * _Nonnull indexPath, BOOL isSelected) {
        NSLog(@"点击了%ld，%ld， isSelected = %d",indexPath.section,indexPath.row,isSelected);
        JYKeyValueModel *model = weakSelf.dataArray[indexPath.row];
        model.isSelected = isSelected;
        if (weakSelf.selectAllButton.isSelected && !isSelected) {//全选按钮是选中，item未选中 --->全选不选中，item不选中
            weakSelf.selectAllButton.selected = false;
        } else if (!weakSelf.selectAllButton.isSelected && isSelected) {//全选是未选中，item是选中--->遍历，如果所有的item都是选中，则全选按钮是选中状态
            BOOL hasUnSelected = false;
            for (int i = 0; i < weakSelf.dataArray.count; i ++) {
                JYKeyValueModel *model = weakSelf.dataArray[i];
                if (model.isSelected == false) {
                    hasUnSelected = true;
                    break;
                }
            }
            if (hasUnSelected == false) {
                weakSelf.selectAllButton.selected = true;
            }
        }
    };
    cell.layer.cornerRadius = 3;
    cell.clipsToBounds = true;
    return cell;
}

- (void)setModel:(JYFormModel *)model {
    _model = model;
    self.dataArray = model.childArray;
    self.titleLabel.text = model.title != nil ? model.title : @"  ";
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(60);
        make.bottom.offset(3);
        make.height.offset((dataArray.count / 3) * 51 + ((dataArray.count % 3 > 0) ? 51 : 0));
    }];
}

@end
