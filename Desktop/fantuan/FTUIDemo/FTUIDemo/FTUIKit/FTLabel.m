//
//  FTLabel.m
//  FTUIDemo
//
//  Created by 王霞 on 2021/5/31.
//

#import "FTLabel.h"
#import "FTUICommonDefines.h"

@interface FTLabel ()

@end

@implementation FTLabel

#pragma mark - Life cycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets), size.height - UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets))];
    size.width += UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets);
    size.height += UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets);
    return size;
}

#pragma mark - Public method


#pragma mark - Setup Subviews

- (void)setupSubviews {
        
    // 创建 subView
}

#pragma mark - Setup Constraints

- (void)setupConstraints {
    
    // 布局代码
}

#pragma mark - Response events



#pragma mark - Private method



#pragma mark - Getter & Setter

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    [self setNeedsDisplay];
    
}

@end
