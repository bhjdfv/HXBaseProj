//
//  Define.h
//  HXBaseProj
//
//  Created by 黄鑫 on 17/1/15.
//  Copyright © 2017年 Aizen. All rights reserved.
//

#ifndef Define_h
#define Define_h

// 机型
#define IPHONE4S_LESS    ([[UIScreen mainScreen] bounds].size.height <= 480)
#define IPhone5s_LESS   (kScreenWidth <= 320)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf, weakSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

// 获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRandomColor kColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#endif /* Define_h */
