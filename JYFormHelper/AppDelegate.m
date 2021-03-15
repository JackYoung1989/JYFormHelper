//
//  AppDelegate.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/1/31.
//

#import "AppDelegate.h"
#import "JYFormDemoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.redColor;

    JYFormDemoViewController *formViewController = [[JYFormDemoViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:formViewController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
