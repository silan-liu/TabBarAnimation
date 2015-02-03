//
//  FumeAnimation.m
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "FumeAnimation.h"

@implementation FumeAnimation

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    // icon下移，label上飞
    [self playIconAnimation:icon values:@[@(icon.center.y), @(icon.center.y + 5), @(icon.center.y)]];

    [self playLabelAnimation:textLabel];
    
    textLabel.textColor = self.textSelectedColor;
    
    UIImage *renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    icon.tintColor = self.iconSelectedColor;
}

- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    // icon上移，label从下出现
    [self playIconAnimation:icon values:@[@(icon.center.y + 5), @(icon.center.y)]];
    [self playDeselectLabelAnimation:textLabel];
    
    textLabel.textColor = self.defaultTextColor;
    
    UIImage *renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    icon.tintColor = self.defaultTextColor;
}

- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    // 设置初始选中状态
    [self playIconAnimation:icon values:@[@(icon.center.y), @(icon.center.y + 5), @(icon.center.y)]];

    textLabel.textColor = self.textSelectedColor;

    UIImage *renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    icon.tintColor = self.textSelectedColor;
}

- (void)playIconAnimation:(UIImageView *)icon values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [self createAnimation:@"position.y" duration:self.duration values:values];
    
    [icon.layer addAnimation:animation forKey:@"moveIconAnimation"];
}

- (void)playLabelAnimation:(UILabel *)label
{
    CAKeyframeAnimation *postionAnimation = [self createAnimation:@"position.y" duration:self.duration values:@[@(label.center.y), @(label.center.y - 60)]];
    
    CAKeyframeAnimation *scaleAnimation = [self createAnimation:@"transform.scale" duration:self.duration values:@[@(1), @(2)]];
    
    CAKeyframeAnimation *opacityAnimation = [self createAnimation:@"opacity" duration:self.duration values:@[@(1), @(0)]];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[postionAnimation, scaleAnimation, opacityAnimation];
    
    [label.layer addAnimation:animationGroup forKey:@"playLabelAnimation"];
}

- (void)playDeselectLabelAnimation:(UILabel *)label
{
    CAKeyframeAnimation *postionAnimation = [self createAnimation:@"position.y" duration:self.duration values:@[@(label.center.y + 15), @(label.center.y)]];
    
    CAKeyframeAnimation *opacityAnimation = [self createAnimation:@"opacity" duration:self.duration values:@[@(0), @(1)]];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[postionAnimation, opacityAnimation];
    
    [label.layer addAnimation:animationGroup forKey:@"playDeselectLabelAnimation"];
}

- (CAKeyframeAnimation *)createAnimation:(NSString *)keyPath duration:(CGFloat)duration values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    animation.values = values;
    animation.duration = duration;
    animation.calculationMode = kCAAnimationCubic;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    
    return animation;
}
@end
