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

- (instancetype)init {
    if ([super init]) {
        self.style = PresentationStyleAlert;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 重写方法
- (NSTimeInterval)transitionDuration {
    return 0.5;
}

- (CGFloat)visualBgAlpha {
    return 0.6;
}

- (UIView *)contentAlertView {
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
