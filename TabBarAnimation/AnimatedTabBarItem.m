//
//  AnimatedTabBarItem.m
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "AnimatedTabBarItem.h"
#import "TabBarItemAnimation.h"
#import "AnimationFactory.h"

@interface AnimatedTabBarItem ()
{}
@end

@implementation AnimatedTabBarItem

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    assert(_animation != nil);
    
    [_animation playAnimation:icon textLabel:textLabel];
}

- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    assert(_animation != nil);
    
    [_animation deselectAnimation:icon textLabel:textLabel];
}

- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    assert(_animation != nil);
    
    [_animation selectedState:icon textLabel:textLabel];
}
@end
