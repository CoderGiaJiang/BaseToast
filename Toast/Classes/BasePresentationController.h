//
//  BasePresentationController.h
//  Test
//
//  Created by GiaJiang on 2017/8/10.
//  Copyright © 2017年 Gia. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    负责带渐变效果的黑色半透明背景
 */
@interface BasePresentationController : UIPresentationController

// 是否点击空白区域隐藏
@property (nonatomic, assign) BOOL isTapDismiss;

/** 黑色背景透明度  */
@property (nonatomic, assign) CGFloat visualBgAlpha;

/** 内容视图的位置  */
@property (nonatomic, assign) CGRect frameOfPresentedView;

@end
