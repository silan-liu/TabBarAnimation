//
//  FrameAnimation.m
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "FrameAnimation.h"

@interface FrameAnimation ()
{
    NSMutableArray *_contents;
    NSMutableArray *_reversContens;
    
    UIImage *_selectedImage;
}
@end

@implementation FrameAnimation

- (void)awakeFromNib
{
    if (!_contents)
    {
        _contents = [NSMutableArray array];
    }
    
    if (!_reversContens)
    {
        _reversContens = [NSMutableArray array];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];

    NSArray *imagesName = dict[@"images"];
    _selectedImage = [UIImage imageNamed:[imagesName lastObject]];
    
    [imagesName enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *imageName = obj;
        UIImage *image = [UIImage imageNamed:imageName];
        if (image)
        {
            [_contents addObject:(__bridge id)image.CGImage];
            [_reversContens insertObject:(__bridge id)image.CGImage atIndex:0];
        }
    }];
}

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    [self playFrameAnimation:icon values:_contents];
    
    textLabel.textColor = self.textSelectedColor;
    icon.tintColor = self.iconSelectedColor;
}

- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    [self playFrameAnimation:icon values:_reversContens];
    icon.tintColor = self.defaultTextColor;
    textLabel.textColor = self.defaultTextColor;
}

- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    textLabel.textColor = self.textSelectedColor;
    
    icon.image = _selectedImage;
    
    icon.tintColor = self.iconSelectedColor;
}

- (void)playFrameAnimation:(UIImageView *)icon values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    animation.values = values;
    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    
    [icon.layer addAnimation:animation forKey:@"playFrameAnimation"];
}

@end
