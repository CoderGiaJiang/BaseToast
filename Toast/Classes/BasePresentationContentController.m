//
//  BasePresentationContentController.m
//  Test
//
//  Created by GiaJiang on 2017/8/11.
//  Copyright © 2017年 Gia. All rights reserved.
//

#import "BasePresentationContentController.h"
#import "BasePresentationController.h"

@interface BasePresentationContentController ()
<
    UIViewControllerTransitioningDelegate,
    UIViewControllerAnimatedTransitioning
>

/** 过渡时间 */
@property (nonatomic, assign) NSTimeInterval transitionDuration;

/** 黑色背景透明度 */
@property (nonatomic, assign) CGFloat visualBgAlpha;

/** 弹窗内容视图 */
@property (nonatomic, strong) UIView *alertCustomView;

// 是否点击空白区域隐藏, 默认YES
@property (nonatomic, assign) BOOL isTapDismiss;

@property (nonatomic, assign) PresentationStyle style; // 默认 Action Sheet

@end

@implementation BasePresentationContentController

- (instancetype)init {
    if ([super init]) {
        [self configInit];
    }
    return self;
}

- (void)configInit {
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self; // UIViewControllerTransitioningDelegate
    self.isTapDismiss = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    BasePresentationController *ctrl = [[BasePresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    ctrl.isTapDismiss = self.isTapDismiss;
    
    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
    CGFloat windowW = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = self.alertCustomView.frame.size.width;
    CGFloat height = self.alertCustomView.frame.size.height;
    
    ctrl.visualBgAlpha = self.visualBgAlpha;
    
    // 设置弹窗内容视图显示的位置
    switch (self.style) {
        case PresentationStyleAlert:
        {
            ctrl.frameOfPresentedView = CGRectMake((windowW - width) / 2, (windowH - height) / 2, width, height);
        }
            break;
        case PresentationStyleActionSheet:
        {
//            self.alertCustomView.width = windowH;
            ctrl.frameOfPresentedView = CGRectMake(0, windowH - height, windowW, height);
        }
            break;
        default:
            break;
    }
    return ctrl;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresenting = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _isPresenting ? [self animatePresentationTransition:transitionContext] : [self animateDismissTransition:transitionContext];
}

#pragma mark - 重写方法实现
// 出现动画 淡入
- (void)animatePresentationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.style) {
        case PresentationStyleAlert:
        {
            [self alertAnimatePresentationTransition:transitionContext];
        }
            break;
        case PresentationStyleActionSheet:
        {
            [self actionSheetAnimatePresentationTransition:transitionContext];
        }
            break;
        default:
            break;
    }
}

// 消失动画 淡出
- (void)animateDismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.style) {
        case PresentationStyleAlert:
        {
            [self alertAnimateDismissTransition:transitionContext];
        }
            break;
        case PresentationStyleActionSheet:
        {
            [self actionSheetAnimateDismissTransition:transitionContext];
        }
            break;
        default:
            break;
    }
}

//// override system method
//- (UINavigationController *)navigationController {
//
//    if (self.referenceNavi) {
//        return self.referenceNavi;
//    }
//
//    UINavigationController *navi = [super navigationController];
//    if (navi) {
//        return navi;
//    }
//
//    UIViewController *presentingVC = self.presentingViewController;
//    if ([presentingVC isKindOfClass:[UINavigationController class]]) {
//        return (UINavigationController *)presentingVC;
//    }
//
//    if ([presentingVC isKindOfClass:[UITabBarController class]]) {
//
//        UITabBarController *tabbarVC = (UITabBarController *)[UIViewController getCurrentRootViewController];
//        UIViewController *selectedVC = tabbarVC.selectedViewController;
//
//        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
//            return (UINavigationController *)selectedVC;
//        }
//    }
//
//    return nil;
//}

#pragma mark - 多种弹出动画
- (void)alertAnimatePresentationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIViewController *presentedVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *presentedView   =   presentedVC.view;
//    UIView *containerView   =   [transitionContext containerView];
//    [containerView addSubview:presentedView];
//    containerView.userInteractionEnabled = YES;
//    CGRect frame    =   [transitionContext finalFrameForViewController:presentedVC];
//    presentedView.frame = frame;
//    CGFloat duration = [self transitionDuration:transitionContext];
//
//    presentedView.alpha = 0;
//    presentedView.transform = CGAffineTransformMakeScale(.8, .8);
//
//    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
//        presentedView.alpha = 1;
//        presentedView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
    
    UIViewController *presentedVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * presentedView        = presentedVC.view;
    //    presentedView.alpha = 0; // 起始为透明，淡入
    
    UIView *containerView = [transitionContext containerView];
    containerView.userInteractionEnabled = YES;
    
    CGRect frame = [transitionContext finalFrameForViewController:presentedVC];
    // 中心对齐
    frame.origin.y = (CGRectGetHeight(containerView.frame) - CGRectGetHeight(frame))/2;
    presentedView.frame = frame;
    //
    presentedView.transform = CGAffineTransformMakeScale(.8, .8);
    
    [containerView addSubview:presentedView];
    
    CGFloat duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        //        presentedView.alpha = 1;
    }];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:25.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        presentedView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (void)actionSheetAnimatePresentationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *presentedVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *presentedView   =   presentedVC.view;
    UIView *containerView   =   [transitionContext containerView];
    [containerView addSubview:presentedView];
    containerView.userInteractionEnabled = YES;
    
    CGRect frame    =   [transitionContext finalFrameForViewController:presentedVC];
    CGFloat duration = [self transitionDuration:transitionContext];
    
    CGFloat height = presentedView.frame.size.height;
//    CGFloat width = presentedView.frame.size.width;
    presentedView.frame = CGRectMake(0, CGRectGetMaxY(frame) + height, [UIScreen mainScreen].bounds.size.width, height);
    
    [UIView animateWithDuration:duration animations:^{
        presentedView.frame = frame;
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

#pragma mark - 多种弹出动画
- (void)alertAnimateDismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIViewController * presentedVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIView *presentedView  = presentedVC.view;
//    CGFloat duration = [self transitionDuration:transitionContext];
//    
//    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
//        presentedView.alpha = 0;
//        presentedView.transform = CGAffineTransformMakeScale(.8, .8);
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:finished];
//    }];
    
    UIViewController * presentedVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * presentedView         = presentedVC.view;
    
    UIView *containerView = [transitionContext containerView];
    
    CGRect frame = presentedView.frame;
    frame.origin.y = CGRectGetHeight(containerView.frame);
    
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        presentedView.alpha = 0;
        presentedView.transform = CGAffineTransformMakeScale(.8, .8);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (void)actionSheetAnimateDismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * presentedVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *presentedView  = presentedVC.view;
    CGRect frame    =   [transitionContext finalFrameForViewController:presentedVC];
    
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        CGFloat height = presentedView.frame.size.height;
        CGFloat width = presentedView.frame.size.width;
        presentedView.frame = CGRectMake(0, CGRectGetMaxY(frame) + height, [UIScreen mainScreen].bounds.size.width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

#pragma mark - AlertPresentationContentControllerProtocol
- (UIView *)alertPresentationContentControllerContentView {
    return [UIView new];
}

#pragma mark - 重写方法
- (UIView *)alertCustomView {
    if (!_alertCustomView) {
        if ([self respondsToSelector:@selector(alertPresentationContentControllerContentView)]) {
            _alertCustomView = [self alertPresentationContentControllerContentView];
        }
        [self.view addSubview:_alertCustomView];
        CGSize size = [_alertCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        switch (self.style) {
            case PresentationStyleAlert:
            {
                _alertCustomView.frame = CGRectMake(0, 0, size.width, size.height);
            }
                break;
            case PresentationStyleActionSheet:
            {
                _alertCustomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size.height);
            }
                break;
        }
        _alertCustomView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _alertCustomView;
}

- (BOOL)isTapDismiss {
    if ([self respondsToSelector:@selector(alertPresentationContentControllerHasTapDismiss)]) {
        _isTapDismiss = [self alertPresentationContentControllerHasTapDismiss];
    }
    return _isTapDismiss;
}

- (PresentationStyle)style {
    if ([self respondsToSelector:@selector(alertPresentationContentControllerStyle)]) {
        _style = [self alertPresentationContentControllerStyle];
    }
    return _style;
}

- (CGFloat)visualBgAlpha {
    if ([self respondsToSelector:@selector(alertPresentationContentControllerVisualBgAlpha)]) {
        _visualBgAlpha = [self alertPresentationContentControllerVisualBgAlpha];
    }
    return _visualBgAlpha;
}

- (NSTimeInterval)transitionDuration {
    if ([self respondsToSelector:@selector(alertPresentationContentControllerVisualBgAlpha)]) {
        _transitionDuration = [self alertPresentationContentControllerVisualBgAlpha];
    }
    return _transitionDuration;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
