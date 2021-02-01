//
//  JYButton.h
//  iOS
//
//  Created by JackYoung on 2020/12/26.
//  Copyright © 2020 JackYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

///按钮中图片的位置
typedef NS_ENUM(NSInteger, JYButtonImageAlignment) {
    ///图片在左，默认
    JYButtonImageAlignmentLeft = 0,
    ///图片在上
    JYButtonImageAlignmentTop = 1,
    ///图片在下
    JYButtonImageAlignmentBottom = 2,
    ///图片在右
    JYButtonImageAlignmentRight = 3,
};


NS_ASSUME_NONNULL_BEGIN

@interface JYButton : UIButton

///按钮中图片的位置 默认是 JYButtonImageAlignmentLeft
@property (nonatomic, assign) JYButtonImageAlignment imageAlignment;

///按钮中图片与文字的间距 默认是0
@property (nonatomic, assign) CGFloat spaceBetweenTitleAndImage;

///是否使用 高亮状态 默认是false
@property (nonatomic, assign) BOOL highlightState;

///点击响应区域
@property (nonatomic, assign) CGSize hitSize;

@end

NS_ASSUME_NONNULL_END
