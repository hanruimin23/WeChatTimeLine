//
//  TWTabBarController.m
//  ThoughtWorksHomeWork
//
//  Created by jackie on 2019/1/12.
//  Copyright © 2019 jackie. All rights reserved.
//

#import "TWTabBarController.h"
#import "TWNavigationController.h"
#import "TWMessagesController.h"
#import "TWContactsController.h"
#import "TWDiscoverController.h"
#import "TMMeController.h"
#import "TWMacros.h"

@interface TWTabBarController ()<UITabBarControllerDelegate>

@end

@implementation TWTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setTranslucent:NO];
    [self addChildViewControllers];

    self.delegate = self;
}

- (void)addChildViewControllers
{
    // 1.初始化子控制器
    TWMessagesController *messgesController = [[TWMessagesController alloc] init];
    [self addChildVc:messgesController title:@"微信" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];

    TWContactsController *contactsController = [[TWContactsController alloc] init];
    [self addChildVc:contactsController title:@"通讯录" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];

    TWDiscoverController *discoverController = [[TWDiscoverController alloc] init];
    [self addChildVc:discoverController title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];

    TMMeController *meController = [[TMMeController alloc] init];
    [self addChildVc:meController title:@"我" image:@"tabbar_me" selectedImage:@"tabbar_meHL"];

}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.view.backgroundColor = [UIColor whiteColor];

    childVc.title = title;

    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    NSDictionary *normalAttr = @{NSForegroundColorAttributeName:UIColorFromHex(0x929292),
                                 NSFontAttributeName:AdaptedFontSize(10.0)};
    NSDictionary *selectedAttr = @{NSForegroundColorAttributeName:UIColorFromHex(0x09AA07),
                                   NSFontAttributeName:AdaptedFontSize(10.0)};
    [childVc.tabBarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];

    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

    TWNavigationController *nav = [[TWNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

@end
