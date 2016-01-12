//
//  AppDelegate.m
//  DrivingBar
//
//  Created by admin on 15/12/1.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "RegistViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize serialQueue;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    serialQueue = dispatch_queue_create("com.guangzhou.jiaba", DISPATCH_QUEUE_SERIAL);
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RegistViewController *nextVC =[[RegistViewController alloc] init];
    
    //光标颜色
     [[UITextField appearance] setTintColor:[UIColor blackColor]];
    UINavigationController *naviViewController = [[UINavigationController alloc]initWithRootViewController:nextVC];
   // [self presentViewController:naviViewController animated:YES completion:nil];
    
   // RegistViewController *regVC = [[RegistViewController alloc] init];
    self.window.rootViewController=naviViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//orientation
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}
@end
