//
//  HXMainController.m
//  HXBaseProj
//
//  Created by 黄鑫 on 17/1/8.
//  Copyright © 2017年 Aizen. All rights reserved.
//

#import "HXMainController.h"
#import "NSObject+HX.h"
#import "HXTabController.h"
#import "HXMeController.h"
#import "HXFindController.h"
#import "HXLikeController.h"
#import "HXHomeController.h"
#import "HXNaviController.h"
#import "HXTabController.h"

@interface HXMainController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) HXTabController *tabController;

@end

@implementation HXMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildVc];
}

- (void)addChildVc {
    // 游戏
    HXHomeController *homeController = [[HXHomeController alloc] init];
    HXNaviController *nav1 = [[HXNaviController alloc] initWithRootViewController:homeController];
    nav1.title = @"游戏";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_sel"];
    
    // 娱乐
    HXLikeController *roomController = [[HXLikeController alloc] init];
    HXNaviController *nav2 = [[HXNaviController alloc] initWithRootViewController:roomController];
    nav2.title = @"娱乐";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabbar_entertain"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_entertain_sel"];
    
    // 订阅
    HXFindController *subscribeController = [[HXFindController alloc] init];
    HXNaviController *nav3 = [[HXNaviController alloc] initWithRootViewController:subscribeController];
    nav3.title = @"订阅";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabbar_subscribe"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_subscribe_sel"];
    
    // 我的
    HXMeController *meController = [[HXMeController alloc] init];
    HXNaviController *nav4 = [[HXNaviController alloc] initWithRootViewController:meController];
    nav4.title = @"我的";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabbar_me"];
    nav4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_me_sel"];
        // tabbarController

    HXTabController *zqTabBarController = [[HXTabController alloc] init];
    zqTabBarController.viewControllers = @[nav1, nav2, nav3, nav4];
    zqTabBarController.delegate = self;
    [self addChildViewController:zqTabBarController];
    [self.view addSubview:zqTabBarController.view];
    self.tabController = zqTabBarController;
}



@end
