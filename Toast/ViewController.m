//
//  ViewController.m
//  Toast
//
//  Created by GiaJiang on 2017/10/17.
//  Copyright © 2017年 Langu. All rights reserved.
//

#import "ViewController.h"
#import "BaseAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)presentButtonClickAction:(UIButton *)sender {
    BaseAlertController *ctrl = [[BaseAlertController alloc]init];
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
