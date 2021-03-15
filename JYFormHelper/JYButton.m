//
//  JYButton.m
//  iOS
//
//  Created by JackYoung on 2020/12/26.
//  Copyright © 2020 JackYoung. All rights reserved.
//

#import "JYButton.h"

@implementation JYButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageAlignment = JYButtonImageAlignmentLeft;
        self.highlightState = false;
        self.spaceBetweenTitleAndImage = 0;
        self.hitSize = CGSizeZero;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

///点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [super pointInside:point withEvent:event];

    CGFloat hit_w = self.hitSize.width;
    CGFloat hit_h = self.hitSize.height;
    CGRect bounds = self.bounds;
    bounds.origin.x += hit_w;
    bounds.origin.y += hit_h;
    bounds.size.width -= hit_w*2;
    bounds.size.height -= hit_h*2;
    return CGRectContainsPoint(bounds, point);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    ///间距
    CGFloat space = self.spaceBetweenTitleAndImage;
    
    ///titleLabel的宽度
    CGFloat titleW = self.titleLabel.bounds.size.width;
    ///titleLabel的高度
    CGFloat titleH = self.titleLabel.bounds.size.height;
    
    ///imageView的宽度
    CGFloat imageW = self.imageView.bounds.size.width;
    ///imageView的高度
    CGFloat imageH = self.imageView.bounds.size.height;
    
    ///按钮中心点X的坐标（以按钮左上角为原点的坐标系）
    CGFloat btnCenterX = self.bounds.size.width/2;
    ///imageView中心点X的坐标（以按钮左上角为原点的坐标系）
    CGFloat imageCenterX = btnCenterX - titleW/2;
    ///titleLabel中心点X的坐标（以按钮左上角为原点的坐标系）
    CGFloat titleCenterX = btnCenterX + imageW/2;
    
    
    ///文本大小
    UIFont * font = self.titleLabel.font;
    if (font == nil) {
        font = [UIFont systemFontOfSize:13];
    }
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:font}];
    ///frameSize
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if ((titleW+0.5) < frameSize.width) {
        titleW = frameSize.width;
    }
    
    ///根据类型进行设置图标 和 文字位置
    switch (self.imageAlignment) {
    case JYButtonImageAlignmentTop:///-(titleCenterX-btnCenterX)  titleCenterX-btnCenterX
        {
            ///使图片和文字水平居中显示
            self.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
            //let totalHeight = imageH+titleH+space
            self.titleEdgeInsets = UIEdgeInsetsMake(imageH+space, -imageW, 0, 0);
            CGFloat bw = self.bounds.size.width;
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleH/2 + space/2), (bw-imageW)/2.0, titleH/2 + space/2, (bw-imageW)/2.0);
        }
            break;
    case JYButtonImageAlignmentLeft:
        {
            
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space);
        }
            break;
    case JYButtonImageAlignmentBottom:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageH/2 + space/2), -(titleCenterX-btnCenterX), (imageH/2 + space/2), titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake((titleH/2 + space/2), btnCenterX-imageCenterX, -(titleH/2 + space/2),-(btnCenterX-imageCenterX));
        }
            break;
    case JYButtonImageAlignmentRight:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageW + space/2), 0, imageW + space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2, 0, -(titleW+space/2));
        }
            break;
    }
}

@end
