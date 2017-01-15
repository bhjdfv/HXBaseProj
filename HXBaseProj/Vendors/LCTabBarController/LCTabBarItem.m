//
//  LCTabBarItem.m
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/2.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "LCTabBarItem.h"
#import "LCTabBarBadge.h"

@interface LCTabBarItem ()

@property (nonatomic, strong) LCTabBarBadge *tabBarBadge;

@property (nonatomic, strong) CAShapeLayer *tapCircle;

@property (nonatomic, assign) CGPoint touchPoint;
@end

@implementation LCTabBarItem

- (void)dealloc {
    
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabBarItem removeObserver:self forKeyPath:@"title"];
    [self.tabBarItem removeObserver:self forKeyPath:@"image"];
    [self.tabBarItem removeObserver:self forKeyPath:@"selectedImage"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.tabBarBadge = [[LCTabBarBadge alloc] init];
        [self addSubview:self.tabBarBadge];
        [self.tabBarBadge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.imageView).centerOffset(CGPointMake(16, -6));
        }];
    }
    return self;
}

- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio {
    
    if (self = [super init]) {
        
        self.itemImageRatio = itemImageRatio;
    }
    return self;
}

#pragma mark -

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    
    _itemTitleFont = itemTitleFont;
    
    self.titleLabel.font = itemTitleFont;
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    
    _itemTitleColor = itemTitleColor;
    
    [self setTitleColor:itemTitleColor forState:UIControlStateNormal];
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor {
    
    _selectedItemTitleColor = selectedItemTitleColor;
    
    [self setTitleColor:selectedItemTitleColor forState:UIControlStateSelected];
}

- (void)setBadgeTitleFont:(UIFont *)badgeTitleFont {
    
    _badgeTitleFont = badgeTitleFont;
    
    self.tabBarBadge.badgeTitleFont = badgeTitleFont;
}

#pragma mark -

- (void)setTabBarItemCount:(NSInteger)tabBarItemCount {
    
    _tabBarItemCount = tabBarItemCount;
    
    self.tabBarBadge.tabBarItemCount = self.tabBarItemCount;
}


- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    
    _tabBarItem = tabBarItem;
    
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"title" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"image" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
    
    self.tabBarBadge.badgeValue = self.tabBarItem.badgeValue;
}

#pragma mark - Reset TabBarItem

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageX = 0.f;
    CGFloat imageY = 0.f;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * self.itemImageRatio;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleX = 0.f;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height * self.itemImageRatio + (self.itemImageRatio == 1.0f ? 100.0f : -5.0f);
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted {
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    if (self.backgroundColor != [UIColor clearColor]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    if (self.animationColor) {
        if (selected) {
            if (!_tapCircle) {
                CGFloat tapCircleDiameterStartValue = 4.f;
                CGFloat touchUpAnimationDuration = 0.5f;
                CGPoint origin = self.touchPoint;
                UIColor *fillColor = self.animationColor;
                CGFloat tapCircleFinalDiameter = MAX(self.frame.size.width, self.frame.size.height) * 4;
                
                UIBezierPath *startingCirclePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(origin.x - (tapCircleDiameterStartValue / 2.f),
                                                                                                      origin.y - (tapCircleDiameterStartValue / 2.f),
                                                                                                      tapCircleDiameterStartValue,
                                                                                                      tapCircleDiameterStartValue) cornerRadius:tapCircleDiameterStartValue / 2.f];
                
                
                UIBezierPath *endingCirclePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(origin.x - (tapCircleFinalDiameter / 2.f),
                                                                                                    origin.y - (tapCircleFinalDiameter / 2.f),
                                                                                                    tapCircleFinalDiameter,
                                                                                                    tapCircleFinalDiameter)
                                                                            cornerRadius:tapCircleFinalDiameter / 2.f];
                
                // Get the next tap circle to expand:
                _tapCircle = [CAShapeLayer layer];
                _tapCircle.fillColor = fillColor.CGColor;
                _tapCircle.strokeColor = [UIColor clearColor].CGColor;
                _tapCircle.borderColor = [UIColor clearColor].CGColor;
                _tapCircle.borderWidth = 0;
                _tapCircle.path = endingCirclePath.CGPath;
                
                CAShapeLayer *mask = [CAShapeLayer layer];
                mask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0].CGPath;
                mask.fillColor = [UIColor blackColor].CGColor;
                mask.strokeColor = [UIColor clearColor].CGColor;
                mask.borderColor = [UIColor clearColor].CGColor;
                mask.borderWidth = 0;
                
                // Set tap circle layer's mask to the mask:
                _tapCircle.mask = mask;
                
                [self.layer insertSublayer:_tapCircle atIndex:0];
                
                CABasicAnimation *tapCircleGrowthAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
                tapCircleGrowthAnimation.duration = touchUpAnimationDuration;
                tapCircleGrowthAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                tapCircleGrowthAnimation.fromValue = (__bridge id)startingCirclePath.CGPath;
                tapCircleGrowthAnimation.toValue = (__bridge id)endingCirclePath.CGPath;
                tapCircleGrowthAnimation.fillMode = kCAFillModeForwards;
                tapCircleGrowthAnimation.removedOnCompletion = YES;
                tapCircleGrowthAnimation.delegate = self;
                [_tapCircle addAnimation:tapCircleGrowthAnimation forKey:@"animatePath"];
            }
        } else {
            if (_tapCircle) {
                [_tapCircle removeFromSuperlayer];
                _tapCircle = nil;
            }
        }
        
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        if (_tapCircle) {
            [_tapCircle removeFromSuperlayer];
        }
        
        self.backgroundColor = self.animationColor;
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
    
}

@end
