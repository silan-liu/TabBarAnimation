//
//  AnimationFactory.h
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationType.h"

@class TabBarItemAnimation;

@interface AnimationFactory : NSObject

+ (TabBarItemAnimation *)animationWithType:(AnimationType)type;

@end
