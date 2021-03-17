//
//  JYFormCell_SelectImageCell.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import "JYFormCell_SelectImageCell.h"
#import "JYFormCell_SelectImageInnerCell.h"
#import "JYFileModel.h"
#import "JYFormViewController.h"

@interface JYFormCell_SelectImageCell () <UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bgView;

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(0);
    }];
    
    self.imageArray = @[].mutableCopy;
}

- (void)setModel:(JYFormModel *)model {
    [super setModel:model];
    if (self.model.fileOrImageArray.count > 0 && !self.model.isSetDraftFileOrImage) {
        self.model.isSetDraftFileOrImage = true;
        self.imageArray = self.model.fileOrImageArray.mutableCopy;
    }
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
    }];
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArray.count >= 9) {
        return 9;
    } else {
        return self.imageArray.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYFormCell_SelectImageInnerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYFormCell_SelectImageInnerCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    if (self.imageArray.count >= 9) {
        cell.type = JYFormCell_SelectImageInnerCellTypeShowImage;
    } else {
        if (indexPath.row == self.imageArray.count) {
            cell.type = JYFormCell_SelectImageInnerCellTypeAdd;
        } else {
            cell.type = JYFormCell_SelectImageInnerCellTypeShowImage;
        }
    }
    if (self.imageArray.count > indexPath.row) {
        cell.model = self.imageArray[indexPath.row];
    }
    weakSelf(self)
    cell.DeleteBlock = ^(NSInteger itemIndex) {
        if (weakSelf.imageArray.count > itemIndex) {
            [weakSelf.imageArray removeObjectAtIndex:itemIndex];
            weakSelf.imageArray = weakSelf.imageArray;//为了刷新数据
        } else {
            return;
        }
        
        CGFloat collectionViewHeight = (self.imageArray.count / 5) * (66 + 10) + (66 + 10) + 10;
        [weakSelf.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(collectionViewHeight);
        }];
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.imageArray.count == indexPath.row && self.imageArray.count < 9) {
        TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:9-self.imageArray.count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        
        imagePickerVC.naviTitleColor = [UIColor colorWithHexString:@"#1E72FF"];
        imagePickerVC.barItemTextColor = [UIColor colorWithHexString:@"#1E72FF"];
        imagePickerVC.naviBgColor = [UIColor colorWithHexString:@"#FFFFFF"];
        imagePickerVC.statusBarStyle = UIStatusBarStyleDefault;
        imagePickerVC.navigationBar.translucent = true;
        imagePickerVC.navLeftBarButtonSettingBlock = ^(UIButton *leftButton) {
//            UIImage *backImage = [UIImage imageNamed:@"nav_return1"];
//            [leftButton setImage:backImage forState:UIControlStateNormal];
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
        
    } else {
        //点击了图片
        NSLog(@"点击了图片%ld",indexPath.row);
    }
}

- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageArray.count; i ++) {
        JYFileModel *model = imageArray[i];
        //保存model的json字符串，提交数据的时候，直接提交json字符串。
        JYKeyValueModel *tempModel = [[JYKeyValueModel alloc] init];
        tempModel.itemId = [NSString jsonStringWithDictionary:[model modelToJSONObject]];
        [tempArray addObject:tempModel];
    }
    self.model.childArray = tempArray;
    
    CGFloat collectionViewHeight = (imageArray.count / 5) * (66 + 10) + (66 + 10) + 10;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(collectionViewHeight);
    }];
    
    [self.collectionView reloadData];
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.itemSize = CGSizeMake(66, 66);
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
    //在这里，刷新collecitonView
    [self uploadPicturesRequest:photos isSave:false WithCompletion:^(id response) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.imageArray];
        [tempArray addObjectsFromArray:[NSArray modelArrayWithClass:[JYFileModel class] json:response]];
        self.imageArray = tempArray;
    }];
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
//        [SVProgressHUD dismiss];
//        if (completion) {
//            completion(responseObject);
//        }
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//    }];
    
    //JackYoung演示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSString *responseObject = @"[  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/3bfa15b582b9485fa9cd0ca06ad38260.jpg\",    \"fileSize\" : 231154,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  },  {    \"relativePath\" : null,    \"absolutePath\" : \"http:\\/\\/www.weifang.gov.cn\\/wqt-oss\\/ccreate-approve-b\\/32b5dddb673c421fa52fb10cda08e49a.jpg\",    \"fileSize\" : 382108,    \"fileType\" : \"jpg\",    \"newFileName\" : null,    \"originalFileName\" : \"(null).jpg\"  }]";
        if (completion) {
            completion(responseObject);
        }
    });
}


@end
