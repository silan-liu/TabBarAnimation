//
//  AnimatedTabBarController.m
//  TabBarAnimation
//
//  Created by liusilan on 15/2/3.
//  Copyright (c) 2015年 YY, Inc. All rights reserved.
//

#import "AnimatedTabBarController.h"
#import "AnimatedTabBarItem.h"

typedef enum
{
    ImageViewTag = 100,
    LabelTag,
}AnimatedTabBarControllerTag;

@interface AnimatedTabBarController ()
{
    NSDictionary *_containers;
}
@end

@implementation AnimatedTabBarController

- (id)init
{
    if (self = [super init])
    {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _containers = [self createViewContainers];
    
    [self createCustomIcons:_containers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCustomIcons:(NSDictionary *)containers
{
    [self.tabBar.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        AnimatedTabBarItem *tabBarItem = obj;
        NSString *key = [NSString stringWithFormat:@"container%ld", idx];
        
        UIView *container = containers[key];
        
        container.tag = idx;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:tabBarItem.image];
        
        imageView.tag = ImageViewTag;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [container addSubview:imageView];
        
        [self createConstraints:imageView container:container size:tabBarItem.image.size yOffset:-5];

        UILabel *label = [[UILabel alloc] init];
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = LabelTag;
        label.text = tabBarItem.title;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        [container addSubview:label];
        
        CGFloat width = self.tabBar.frame.size.width / self.tabBar.items.count;
        
        [self createConstraints:label container:container size:CGSizeMake(width, 10) yOffset:16];
        
        if (idx == 0)
        {
            [tabBarItem selectedState:imageView textLabel:label];
        }
        
        // 去除原有设置
        tabBarItem.title = @"";
        tabBarItem.image = nil;
    }];
}

- (NSDictionary *)createViewContainers
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger count = self.tabBar.items.count;
    
    for (NSInteger i = 0; i < count; i++)
    {
        UIView *viewContainer = [self createViewContainer];
        
        NSString *key = [NSString stringWithFormat:@"container%ld", i];
        
        [dict setObject:viewContainer forKey:key];
    }
    
    NSMutableString *formatString = [NSMutableString stringWithString: @"H:|-(0)-[container0]"];
    
    for (NSInteger i = 1; i < count; i++)
    {
        [formatString appendFormat:@"-(0)-[container%ld(==container0)]", i];
    }
    
    [formatString appendString:@"-(0)-|"];
    
    NSArray *constranints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:NSLayoutFormatDirectionRightToLeft metrics:nil views:dict];
    
    [self.view addConstraints:constranints];
    
    return dict;
}

- (UIView *)createViewContainer
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [view addGestureRecognizer:tapGesture];
    
    NSLayoutConstraint *constY = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.view addConstraint:constY];
    
    NSLayoutConstraint *constH = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.tabBar.frame.size.height];
    
    [self.view addConstraint:constH];
    
    return view;
}

- (void)createConstraints:(UIView *)view container:(UIView *)container size:(CGSize)size yOffset:(CGFloat)yOffset
{
    NSLayoutConstraint *constraintX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [container addConstraint:constraintX];
    
    NSLayoutConstraint *constraintY = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterY multiplier:1 constant:yOffset];
    
    [container addConstraint:constraintY];
    
    NSLayoutConstraint *constraintW = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.width];
    
    [view addConstraint:constraintW];
    
    NSLayoutConstraint *constraintH = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.height];
    
    [view addConstraint:constraintH];
}

- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    NSInteger currentIndex = gesture.view.tag;
    if (self.selectedIndex != currentIndex)
    {
        // 现在选中
        AnimatedTabBarItem *item = self.tabBar.items[currentIndex];
        
        NSString *key = [NSString stringWithFormat:@"container%ld", currentIndex];
        
        UIView *container = _containers[key];
        
        UIImageView *imageView = (UIImageView *)[container viewWithTag:ImageViewTag];;
        
        UILabel *label = (UILabel *)[container viewWithTag:LabelTag];
        
        [item playAnimation:imageView textLabel:label];
        
        // 之前选中
        item = self.tabBar.items[self.selectedIndex];
        
        key = [NSString stringWithFormat:@"container%ld", self.selectedIndex];
        
        container = _containers[key];
        
        imageView = (UIImageView *)[container viewWithTag:ImageViewTag];;
        
        label = (UILabel *)[container viewWithTag:LabelTag];
        
        [item deselectAnimation:imageView textLabel:label];
        
        self.selectedIndex = currentIndex;
    }
}
@end
