//
//  JYFormCell_SelectShowWithImageCell.m
//  JackYoung
//
//  Created by 魏魏 on 2021/3/6.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectShowWithImageCell.h"
#import "JYFileModel.h"

@interface JYFormCell_SelectShowWithImageCell () <TZImagePickerControllerDelegate>

@property (nonatomic, weak) UIImageView *selectImage;
@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation JYFormCell_SelectShowWithImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    [self.contentView addSubview:arrowImageView];

    
    UIImageView *selectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Team_teamLogo"]];
    selectImage.userInteractionEnabled = true;
    [self.contentView addSubview:selectImage];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.equalTo(selectImage);
    }];
    
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImageView.mas_right).offset(-20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.height.mas_equalTo(40);
    }];
    
    self.selectImage = selectImage;
    self.arrowImageView = arrowImageView;
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.left.offset(15);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [selectImage addGestureRecognizer:tapGesture];
}

- (void)tapGesture
{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVC.naviTitleColor = [UIColor colorWithHexString:@"#1E72FF"];
    imagePickerVC.barItemTextColor = [UIColor colorWithHexString:@"#1E72FF"];
    imagePickerVC.naviBgColor = [UIColor colorWithHexString:@"#FFFFFF"];
    imagePickerVC.statusBarStyle = UIStatusBarStyleDefault;
    imagePickerVC.navigationBar.translucent = true;
    imagePickerVC.navLeftBarButtonSettingBlock = ^(UIButton *leftButton) {
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
}

- (void)setModel:(JYFormModel *)model
{
    [super setModel:model];
    self.bottomLine.hidden = model.isBottomLineHidden;
    if ([JYEasyCodeHelper isNotEmpty:model.placeHolderImage]) {
        [self.selectImage sd_setImageWithURL:[NSURL URLWithString:model.placeHolderImage]];
    }
    if (self.model.isHaveSubTitle) {
        [self.subTitleLabelBottomConstraint uninstall];
    }
    else {
        [self.subTitleLabelBottomConstraint uninstall];
    }
}

- (UIView *)bottomLine {
    if(!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    }
    return _bottomLine;
}

#pragma mark ----------- TZImagePickerControllerDelegate ---------------
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    //在这里，刷新collecitonView
    [self uploadPicturesRequest:photos isSave:false WithCompletion:^(id response) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        [tempArray addObjectsFromArray:[NSArray modelArrayWithClass:[JYFileModel class] json:response]];
        JYFileModel *model = tempArray.firstObject;
        self.model.placeHolderImage = model.absolutePath;
        self.model.contentString = model.absolutePath;
        [self.selectImage sd_setImageWithURL:[NSURL URLWithString:model.absolutePath]];
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
