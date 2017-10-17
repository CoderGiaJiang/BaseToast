//
//  BasePresentationContentController.h
//  Test
//
//  Created by GiaJiang on 2017/8/11.
//  Copyright © 2017年 Gia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PresentationStyle) {
    PresentationStyleActionSheet = 0,
    PresentationStyleAlert
};

// 弹窗视图内容控制器
@interface BasePresentationContentController : UIViewController

@property (nonatomic, assign, readonly) BOOL isPresenting;

@property (nonatomic, assign) PresentationStyle style; // 默认 Action Sheet

@end
