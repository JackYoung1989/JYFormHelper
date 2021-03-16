//
//  JYFormCell_SelectPersonDetailShowMode.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/23.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectPersonDetailShowMode.h"
#import "JYPersonModel.h"
#import "JYFormCell_SelectPersonDetailShowMode_InnerCell.h"

#define kMaxCountShow   4

@interface JYFormCell_SelectPersonDetailShowMode()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)UILabel *nameLabel;

@end

@implementation JYFormCell_SelectPersonDetailShowMode

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString {
    self.nameLabel.text = titleString;
    CGFloat width = [JYEasyCodeHelper getStringWidth:titleString Font:self.nameLabel.font MaxHeight:MAXFLOAT];
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(width);
    }];
}

- (void)setCurrentArray:(NSArray *)currentArray {
    _currentArray = currentArray;
    [self.collectionView reloadData];
}

- (void)createUI {
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.offset(0);
        make.height.offset(20);
        make.width.offset(50);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth / 7, 100);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[JYFormCell_SelectPersonDetailShowMode_InnerCell class] forCellWithReuseIdentifier:NSStringFromClass(JYFormCell_SelectPersonDetailShowMode_InnerCell.class)];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(2);
        make.right.offset(-10);
        make.top.bottom.offset(0);
        make.height.offset(100);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.currentArray.count > kMaxCountShow) {
        return kMaxCountShow + 1;
    } else {
        return self.currentArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYFormCell_SelectPersonDetailShowMode_InnerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYFormCell_SelectPersonDetailShowMode_InnerCell class]) forIndexPath:indexPath];
    if (self.currentArray.count > kMaxCountShow) {
        if (indexPath.row == kMaxCountShow) {
            cell.cellType = PersonDetailsCellStyle_More;
        } else {
            cell.cellType = PersonDetailsCellStyle_Normal;
        }
    } else {
            cell.cellType = PersonDetailsCellStyle_Normal;
    }
    cell.model = self.currentArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == kMaxCountShow && self.currentArray.count >= kMaxCountShow) {
        NSLog(@"点击了更多按钮3");
        
    }
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"巡访人:";
        _nameLabel.textColor = [UIColor colorWithHexString:@"#909399"];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.backgroundColor = UIColor.whiteColor;
    }
    return _nameLabel;
}

@end
