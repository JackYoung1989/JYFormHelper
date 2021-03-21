//
//  JYFormCell_SelectPerson.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/7.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectPerson.h"
#import "JYFormCell_SelectPersonInnerCell.h"
#import "JYTableViewControllerDemo.h"

#define kMaxCountShow  5  //一行中最多显示的人员cell个数

@interface JYFormCell_SelectPerson()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *personsArray;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation JYFormCell_SelectPerson

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.personsArray = [[NSMutableArray alloc] init];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.descLabel];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(22);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(17);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(65);
        make.bottom.offset(-15);
    }];
}

- (void)setModel:(JYFormModel *)model {
    if (!self.model) {//只赋值一次
        [super setModel:model];
        //如果默认一个已经被选择了，那么需要在这里添加上数据。
        self.descLabel.text = model.descString;
        if (model.childArray.count > 0) {
            self.personsArray = [NSMutableArray arrayWithArray:model.childArray];
        }
        
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(17);
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(65);
            make.bottom.offset(-15);
        }];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - 71) / 6, 65);
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.personsArray.count > kMaxCountShow) {
        return kMaxCountShow + 1;
    } else {
        return self.personsArray.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYFormCell_SelectPersonInnerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYFormCell_SelectPersonInnerCell" forIndexPath:indexPath];
    if (self.personsArray.count > kMaxCountShow) {
        if (indexPath.row == kMaxCountShow) {
            cell.cellType = JYFormCell_SelectPersonInnerCellTypeMore;
        } else {
            cell.cellType = JYFormCell_SelectPersonInnerCellTypeShowPerson;
        }
    } else {
        if (indexPath.row == self.personsArray.count) {
            cell.cellType = JYFormCell_SelectPersonInnerCellTypeAdd;
        } else {
            cell.cellType = JYFormCell_SelectPersonInnerCellTypeShowPerson;
        }
    }
    if (self.personsArray.count > indexPath.row) {
        cell.personModel = self.personsArray[indexPath.row];
    }
    cell.itemIndex = indexPath.row;
    cell.totalCount = self.personsArray.count;
    weakSelf(self)
    cell.deleteItemWithIndexBlock = ^(NSInteger index) {
        [weakSelf.personsArray removeObjectAtIndex:index];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:weakSelf.model.childArray];
        [tempArray removeObjectAtIndex:index];
        weakSelf.model.childArray = tempArray;
        
        [weakSelf.collectionView reloadData];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.row == self.personsArray.count && self.personsArray.count < kMaxCountShow) || (indexPath.row == kMaxCountShow && self.personsArray.count >= kMaxCountShow)) {
        //点击了+号
        if (self.model.selectPersonStyle == JYFormModelCellSelectPersonStyle_MultiTeamMultiSelect) {
            JYTableViewControllerDemo *selectPerson = [[JYTableViewControllerDemo alloc] init];
            selectPerson.selectedArray = self.personsArray;
            weakSelf(self)
            selectPerson.selectedItemsArrayBlock = ^(NSArray<JYKeyValueModel *> * _Nonnull keyValueArray) {
                [weakSelf.personsArray removeAllObjects];
                [weakSelf.personsArray addObjectsFromArray:keyValueArray];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (JYKeyValueModel *model in self.personsArray) {
                    if (self.model.ifReturnAllPropertyOfSelectedModel) {
                        //这个地方需要进行处理，如果需要返回所有数据的时候，在这里处理。
                        model.tempString = model.modelToJSONString;
                    }
                    [tempArray addObject:model];
                }
                weakSelf.model.childArray = tempArray;
                [weakSelf.collectionView reloadData];
            };
            [self.viewController.navigationController pushViewController:selectPerson animated:true];
        } else if (self.model.selectPersonStyle == JYFormModelCellSelectPersonStyle_SpecifiedSingleTeamMultiSelect) {
        } else {
        }
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 11, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 5.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JYFormCell_SelectPersonInnerCell class] forCellWithReuseIdentifier:@"JYFormCell_SelectPersonInnerCell"];
    }
    return _collectionView;
}

- (UILabel *)descLabel
{
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _descLabel;
}

@end
