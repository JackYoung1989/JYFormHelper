//
//  JYFormCell_SelectImageInnerCell.h
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYFormCell_SelectImageInnerCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *pictureView;

@property (nonatomic,strong) UILabel *pictureLabel;

@property (nonatomic, assign) BOOL isCompen;//判断是否是从薪酬过来

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIImageView *addView;

@property (nonatomic,strong) NSString *headerImagePath;

@property (nonatomic,strong) UIButton *deleteButton;

@property (nonatomic,strong) UIButton *deleteBgButton;

@property (nonatomic,assign) BOOL bAdd;

@property (nonatomic,assign) BOOL isCustomApproval;//判断是否是从自定义审批过来

@property (nonatomic,copy) void(^DeleteBlock)(void);

//王亮添加   显示“更多”按钮
@property (nonatomic, assign) BOOL haveMore;
@property (nonatomic, assign) BOOL noDelete;
@property (nonatomic, strong) UILabel *countLbl;
@property (nonatomic, strong) UILabel *departNameLbl;

@end

NS_ASSUME_NONNULL_END
