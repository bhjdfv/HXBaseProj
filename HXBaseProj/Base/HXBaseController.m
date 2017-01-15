//
//  HXBaseController.m
//  HXBaseProj
//
//  Created by 黄鑫 on 17/1/8.
//  Copyright © 2017年 Aizen. All rights reserved.
//

#import "HXBaseController.h"

@interface HXBaseController ()

@end

@implementation HXBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - 屏幕方向改变
- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
