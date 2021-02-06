//
//  JYFormCell_PersonSelect.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/2/6.
//

#import "JYFormCell_PersonSelect.h"

@implementation JYFormCell_PersonSelect

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
}

@end
