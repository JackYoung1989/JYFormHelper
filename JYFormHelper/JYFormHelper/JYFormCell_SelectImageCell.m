//
//  JYFormCell_SelectImageCell.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import "JYFormCell_SelectImageCell.h"
#import "JYFormCell_SelectImageInnerCell.h"
#import "JYFileModel.h"

@interface JYFormCell_SelectImageCell () <UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat heightED;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation JYFormCell_SelectImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor redColor];
    self.imageArray = [NSMutableArray array];
    
    self.bgView = [[UIView alloc] init];
    [self.contentView addSubview:self.bgView];
    self.bgView.frame = CGRectMake(16 - 1, 0, kScreenWidth - (16 - 1)*2, self.contentView.height);
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.recipientArray.count > 0) {
        if (self.recipientArray.count == 1) {
            
            if ([[self.recipientArray firstObject] isKindOfClass:[NSString class]]) {
                return CGSizeMake(44, 44);
            }else {
                return CGSizeMake(44, 44);
            }
        }else {
            
            return CGSizeMake(44, 44);
        }
    }else {
        return CGSizeMake(44, 44);
    }
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.recipientArray.count == 0) {
        return 1;
    } else {
        if (self.recipientArray.count == 9) {
            return 9;
        }
        if (_hiddenAdd) {
            return self.recipientArray.count;
        }
        return self.recipientArray.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYFormCell_SelectImageInnerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYFormCell_SelectImageInnerCell" forIndexPath:indexPath];
    
    if (self.recipientArray.count == 0) {
        cell.bAdd = YES;
        cell.nameLabel.text = @"";
    }
    else {
        if (indexPath.row < self.recipientArray.count) {
            cell.bAdd = NO;
            cell.nameLabel.text = @"";
            for (int i = 0; i < self.recipientArray.count; i++) {
                JYFileModel *model = self.recipientArray[indexPath.row];
                if ([model isKindOfClass:[UIImage class]]) {
                    cell.pictureView.image = self.recipientArray[indexPath.row];
                }
                else if ([model isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = self.recipientArray[indexPath.row];
                    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:dict[@"absolutePath"]]];
                }
                else if ([model isKindOfClass:[NSString class]]) {
                    
                }
                else {
                    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:model.fileUrl]];
                }
            }
        }
        else if (indexPath.row == 9) {
            cell.bAdd = NO;
            cell.nameLabel.text = @"";
        }
        else {
            cell.bAdd = YES;
            cell.nameLabel.text = @"";
        }
    }
    
    weakSelf(self)
    cell.DeleteBlock = ^{
        if (weakSelf.deleteImageBlock) {
            weakSelf.deleteImageBlock(indexPath.row);
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:9-self.imageArray.count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVC.naviTitleColor = [UIColor colorWithHexString:@"#1E72FF"];
    imagePickerVC.barItemTextColor = [UIColor colorWithHexString:@"#1E72FF"];
    imagePickerVC.naviBgColor = [UIColor colorWithHexString:@"#FFFFFF"];
    imagePickerVC.statusBarStyle = UIStatusBarStyleDefault;
    imagePickerVC.navigationBar.translucent = NO;
    imagePickerVC.navLeftBarButtonSettingBlock = ^(UIButton *leftButton) {
        UIImage *backImage = [UIImage imageNamed:@"nav_return1"];
        [leftButton setImage:backImage forState:UIControlStateNormal];
    };
    
    imagePickerVC.isSelectOriginalPhoto = NO;
    imagePickerVC.allowTakePicture = YES;
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowPickingImage = YES;
    imagePickerVC.allowPickingOriginalPhoto = NO;
    imagePickerVC.allowPickingGif = NO;
    imagePickerVC.sortAscendingByModificationDate = YES;
    imagePickerVC.showSelectBtn = NO;
    
    imagePickerVC.modalPresentationStyle = 0;
    [self.viewController presentViewController:imagePickerVC animated:YES completion:nil];
    
    // 监听TZImagePickerController导航栏的显示与否
    [imagePickerVC addObserver:self forKeyPath:@"navigationBar.hidden" options:NSKeyValueObservingOptionNew context:nil];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    for (int i = 0; i < self.recipientArray.count; i++) {
        
        JYFormCell_SelectImageInnerCell *cell = (JYFormCell_SelectImageInnerCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        CGPoint tempPoint = [cell.deleteBgButton convertPoint:point fromView:self];
        if ([cell.deleteBgButton pointInside:tempPoint withEvent:event]) {
            return cell.deleteBgButton;
        }
    }
    
    return view;
}

- (void)setRecipientArray:(NSMutableArray *)recipientArray {
    _recipientArray = recipientArray;
    if (recipientArray.count > 1 && self.bgView.layer.borderWidth == 1.0) {
        [self showEmptyContentReminder:NO];
    }
    
    self.heightED = 0;
    
    [self.collectionView reloadData];
}

- (void)showEmptyContentReminder:(BOOL)bShow {
    
    if (bShow) {
        self.bgView.layer.borderWidth = 1.0;
    }else {
        self.bgView.layer.borderWidth = 0.0;
    }
    self.bgView.layer.borderColor = [UIColor redColor].CGColor;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 5.0;
        layout.sectionInset = UIEdgeInsetsMake(10, 16, 10, 16);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[JYFormCell_SelectImageInnerCell class] forCellWithReuseIdentifier:@"JYFormCell_SelectImageInnerCell"];
    }
    return _collectionView;
}

#pragma mark ----------- TZImagePickerControllerDelegate ---------------
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    [picker removeObserver:self forKeyPath:@"navigationBar.hidden" context:nil];
    
    [self.imageArray addObjectsFromArray:photos];
    //在这里，刷新collecitonView
    [_collectionView reloadData];
//    [self.tableView reloadSection:self.modelArray.count + 2 withRowAnimation:UITableViewRowAnimationNone];
    
    return;
}

#pragma mark -- 上传图片
/**上传图片*/
- (void)uploadPicturesRequest:(NSArray *)images isSave:(BOOL)isSave WithCompletion:(void (^)(id response))completion{
    [SVProgressHUD showWithStatus:@"上传中"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"0";
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 0; i < images.count; i++) {
        UIImage *photo = images[i];
        if ([photo isKindOfClass:[UIImage class]]) {
            [imgs addObject:photo];
        } else if ([photo isKindOfClass:[NSString class]]) {
            
        } else {
            JYFileModel *model = images[i];
            if ([model isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = images[i];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"absolutePath"]]]];
                [imgs addObject:image];
            }
            else {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.fileUrl]]];
                [imgs addObject:image];
            }
        }
    }
    //在这里上传选择的所有图片。
//    [NetworkHelper uploadImagesWithURL:[NSString stringWithFormat:@"%@%@",Document_Base_URL,upLoadAllAndroid_URL] parameters:param name:@"file" images:imgs fileNames:@[] imageScale:1.0 imageType:@"jpg" progress:^(NSProgress * _Nonnull progress) {
//
//    } success:^(id  _Nullable responseObject) {
//        if (completion) {
//            completion(responseObject);
//        }
//    } failure:^(NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//    }];
}


@end
