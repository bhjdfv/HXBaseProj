//
//  LCTabBarBadge.m
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/2.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "LCTabBarBadge.h"

@implementation LCTabBarBadge

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        self.hidden = YES;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setBadgeTitleFont:(UIFont *)badgeTitleFont {
    
    _badgeTitleFont = badgeTitleFont;
    
    self.titleLabel.font = badgeTitleFont;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    
    _badgeValue = [badgeValue copy];
    
    self.hidden = !(BOOL)self.badgeValue;
    
    if (self.badgeValue) {
        
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        if (self.badgeValue.length > 0) {
            
            CGSize titleSize = [badgeValue sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.badgeTitleFont, NSFontAttributeName, nil]];
            CGFloat height = 16;
            self.layer.cornerRadius = height * 0.5f;
            CGFloat width = MAX(titleSize.width + 10, height);
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(width, height));
            }];
            
        } else {
            self.layer.cornerRadius = 5;
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(10, 10));
            }];
        }
    }
}

- (UIImage *)resizedImageFromMiddle:(UIImage *)image {
    
    return [self resizedImage:image width:0.5f height:0.5f];
}

- (UIImage *)resizedImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height {
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * width
                                      topCapHeight:image.size.height * height];
}

@end
