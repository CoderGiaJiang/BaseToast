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

@protocol BasePresentationContentControllerProtocol <NSObject>

- (BOOL)alertPresentationContentControllerHasTapDismiss;
- (PresentationStyle)alertPresentationContentControllerStyle;
- (NSTimeInterval)alertPresentationContentControllerTransitionDuration;
- (CGFloat)alertPresentationContentControllerVisualBgAlpha;


@required
- (UIView *_Nonnull)alertPresentationContentControllerContentView;

@end

// 弹窗视图内容控制器, 自动获取 alertView 的大小，alertView 内部要设置好约束
@interface BasePresentationContentController : UIViewController
<
    BasePresentationContentControllerProtocol
>

@property (nonatomic, assign, readonly) BOOL isPresenting;

// 被presented的viewcontroller是没有navicontroller的；weak reference
@property (nonatomic, weak, nullable) UINavigationController *referenceNavi;



@end
