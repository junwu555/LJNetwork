//
//  FTUICommonDefines.h
//  Pods
//
//  Created by 王霞 on 2021/5/31.
//


#ifndef FTUICommonDefines_h
#define FTUICommonDefines_h

#pragma mark - UIEdgeInsets

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}


#endif /* FTUICommonDefines_h */
