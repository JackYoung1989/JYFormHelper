//
//  JYFormCell_SelectFileCell.m
//  JackYoung
//
//  Created by JackYoung on 2021/2/7.
//  Copyright © 2021 JackYoung's. All rights reserved.
//

#import "JYFormCell_SelectFileCell.h"
#import "JYFileModel.h"

#define EdgeDistance 16

@interface JYFormCell_SelectFileCell()

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UIButton *deleteButton;

@end

@implementation JYFormCell_SelectFileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        UIView *backGroundView = [[UIView alloc] init];
        backGroundView.layer.cornerRadius = 3;
        backGroundView.layer.masksToBounds = YES;
        backGroundView.backgroundColor = [UIColor colorWithHexString:@"#F2F8FF"];
        [self.contentView addSubview:backGroundView];
        [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.height.offset(56);
            make.bottom.offset(-15);
            make.right.offset(0);
        }];
        
        self.iconImageView = [[UIImageView alloc]init];
        [self.iconImageView setImage:[UIImage imageNamed:@"doc_unknown"]];
        self.iconImageView.layer.cornerRadius = 3;
        self.iconImageView.clipsToBounds = true;
        [backGroundView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8);
            make.left.offset(13);
            make.bottom.mas_equalTo(-8);
            make.width.equalTo(self.iconImageView.mas_height);
        }];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"icon_delete_button"] forState:UIControlStateNormal];
        self.deleteButton.contentEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.iconImageView.mas_right).offset(20);
            make.top.equalTo(self.iconImageView.mas_top).offset(-20);
            make.width.height.mas_equalTo(40);
        }];
        [self.deleteButton addTarget:self action:@selector(onDeleteDocumentTouched) forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLabel = [[UILabel alloc]init];
        [backGroundView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView).offset(2);
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
            make.height.offset(14);
            make.right.offset(-16);
        }];
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#202224"];
        
        self.detailLabel = [[UILabel alloc]init];
        [backGroundView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.iconImageView).offset(-2);
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
            make.height.offset(13);
            make.right.offset(-16);
        }];
        self.detailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        self.detailLabel.textColor = [UIColor colorWithHexString:@"#BFC2CC"];
    }
    return self;
}

- (void)onDeleteDocumentTouched{
    if (self.deleteItemWithIndexBlock) {
        self.deleteItemWithIndexBlock(self.indexPath.row);
    }
}

- (void)setFileModel:(JYFileModel *)fileModel {
    _fileModel = fileModel;
    self.titleLabel.text = fileModel.originalFileName;
    self.detailLabel.text = [self showFileSizewith:fileModel.fileSize.integerValue];
    if ([fileModel.fileType.lowercaseString isEqualToString:@"jpg"] || [fileModel.fileType.lowercaseString isEqualToString:@"png"] || [fileModel.fileType.lowercaseString isEqualToString:@"heic"]) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:fileModel.absolutePath] placeholderImage:AvatorPlaceHolderImge];
    } else {
        //根据类型显示不同的图片内容。
        if ([@[@"xls", @"xlsx"] containsObject:fileModel.fileType.lowercaseString]) {
            [self.iconImageView setImage:[UIImage imageNamed:@"Report_wj_xls"]];
        } else if ([@[@"doc", @"docx"] containsObject:fileModel.fileType.lowercaseString]) {
            [self.iconImageView setImage:[UIImage imageNamed:@"Report_wj_doc"]];
        } else if ([@[@"ppt", @"pptx"] containsObject:fileModel.fileType.lowercaseString]) {
            [self.iconImageView setImage:[UIImage imageNamed:@"Report_wj_ppt"]];
        } else if ([@[@"txt", @"rtf"] containsObject:fileModel.fileType.lowercaseString]) {
            [self.iconImageView setImage:[UIImage imageNamed:@"Report_wj_txt"]];
        } else if ([@[@"pdf"] containsObject:fileModel.fileType.lowercaseString]) {
            [self.iconImageView setImage:[UIImage imageNamed:@"Report_wj_pdf"]];
        }
//        else if ([@[@"jpg", @"png"] containsObject:fileModel.fileType]) {
//            [self.iconImageView setImage:[UIImage imageNamed:@"Report_wj_tupian"]];
//        }
        else {
            [self.iconImageView setImage:[UIImage imageNamed:@"Report_wj_rar"]];
        }
    }
}

///文件大小
- (NSString*)showFileSizewith:(NSInteger)fileSize{
    NSInteger totleSize = fileSize;
    NSString *totleStr = nil;
    if (totleSize > 1024 * 1024){
        totleStr = [NSString stringWithFormat:@"%.2f M",totleSize / 1024.00f /1024.00f];
    }else if (totleSize > 1024){
        totleStr = [NSString stringWithFormat:@"%.2f KB",totleSize / 1024.00f ];
    }else{
        totleStr = [NSString stringWithFormat:@"%.2f B",totleSize / 1.00f];
    }
    return totleStr;
}

@end
