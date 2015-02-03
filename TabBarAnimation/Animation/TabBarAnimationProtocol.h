//
//  TabBarAnimationProtocol.h
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TabBarAnimationProtocol <NSObject>

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel;

- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel;

- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel;

@end
