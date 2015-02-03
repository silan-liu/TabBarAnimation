//
//  AnimatedTabBarItem.h
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarAnimationProtocol.h"

@class TabBarItemAnimation;

@interface AnimatedTabBarItem : UITabBarItem<TabBarAnimationProtocol>

@property (nonatomic, strong) IBOutlet TabBarItemAnimation *animation;

@end
