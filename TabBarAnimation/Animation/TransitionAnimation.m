//
//  TransitionAnimation.m
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "TransitionAnimation.h"

@implementation TransitionAnimation

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    [self playTransitionAnimation:icon];
    
    textLabel.textColor = self.textSelectedColor;
    
    UIImage *renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    
    icon.tintColor = self.iconSelectedColor;
}

- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    textLabel.textColor = self.defaultTextColor;
    
    UIImage *renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    
    icon.tintColor = self.defaultTextColor;
}

- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    textLabel.textColor = self.textSelectedColor;
    
    UIImage *renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    
    icon.tintColor = self.iconSelectedColor;
}

- (void)playTransitionAnimation:(UIImageView *)icon
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    animation.values = @[@(0), @(M_PI_2), @(M_PI), @(M_PI * 2)];
    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    
    [icon.layer addAnimation:animation forKey:@"playTransitionAnimation"];
    
    return;
    
    [UIView transitionWithView:icon duration:self.duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        NSLog(@"12");
    } completion:^(BOOL finished) {
        
    }];
}

@end
