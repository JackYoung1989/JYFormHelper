//
//  AppDelegate.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/1/31.
//

#import "AppDelegate.h"
#import "JYFormViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.redColor;

    JYFormViewController *formViewController = [[JYFormViewController alloc] init];
    self.window.rootViewController = formViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
