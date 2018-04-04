//
//  BasePresentationController.m
//  Test
//
//  Created by GiaJiang on 2017/8/10.
//  Copyright © 2017年 Gia. All rights reserved.
//

#import "BasePresentationController.h"

@interface BasePresentationController ()

@property (nonatomic, strong) UIView *visualView;

@end

@implementation BasePresentationController

- (void)onTapBgView:(UITapGestureRecognizer *)tap {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 需要重写下面五个方法
// 是在呈现过渡即将开始的时候被调用， 将半透明黑色背景加入到 containerView 中，并做一个过渡动画
- (void)presentationTransitionWillBegin {
    
    // 黑色半透明背景
    self.visualView = ({
        UIView *view = [UIView new];
        view.frame = self.containerView.bounds;
        view.alpha = 0;
        view.backgroundColor = [UIColor blackColor];
        view.userInteractionEnabled = YES;
        view;
    });
    [self.containerView addSubview:self.visualView];
    
    if (self.isTapDismiss) {
        // 添加点击消失手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapBgView:)];
        [self.visualView addGestureRecognizer:tap];        
    }
    
    // 淡入动画
    id <UIViewControllerTransitionCoordinator>transitionCoordinator = self.presentedViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.visualView.alpha = self.visualBgAlpha;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

/**
  过渡结束被调用

 @param completed 过渡效果是否完成
 */
- (void)presentationTransitionDidEnd:(BOOL)completed {
    // 如果没有完成，移除 背景 View
    if (!completed) {
        [self.visualView removeFromSuperview];
    }
}

// 淡出动画 开始
- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator>transitionCoordinator = self.presentedViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.visualView.alpha = 0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

// 淡出动画结束
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.visualView removeFromSuperview];
    }
}

#pragma mark - 重写方法
// 呈现的 view 最终位置由 UIPresentationViewController 负责定义，重载这个方法来定义最终位置。
- (CGRect)frameOfPresentedViewInContainerView {
    return self.frameOfPresentedView;
}


@end
