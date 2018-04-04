//
//  AlertViewController.m
//  Test
//
//  Created by GiaJiang on 2017/8/10.
//  Copyright © 2017年 Gia. All rights reserved.
//

#import "BaseAlertController.h"

@interface BaseAlertController ()

@end

@implementation BaseAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - AlertPresentationContentControllerProtocol
- (PresentationStyle)alertPresentationContentControllerStyle {
    return PresentationStyleAlert;
}

- (NSTimeInterval)alertPresentationContentControllerTransitionDuration {
    return 0.5;
}

- (CGFloat)alertPresentationContentControllerVisualBgAlpha {
    return 0.6;
}

- (UIView *)alertPresentationContentControllerContentView {
    return [[[NSBundle mainBundle]loadNibNamed:@"CustomView" owner:self options:nil]lastObject];
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
