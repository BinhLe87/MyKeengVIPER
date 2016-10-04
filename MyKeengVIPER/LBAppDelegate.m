//
//  LBAppDelegate.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/3/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBAppDelegate.h"
#import "SDImageCache.h"
#import "LBMyKeengConstants.h"
#import "LBHomeViewController.h"
#import "LBAppDependencies.h"


@interface LBAppDelegate ()

@property(nonatomic) LBAppDependencies *appDependencies;
@end


@implementation LBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //TODO: set cache configuration
    [[SDImageCache sharedImageCache] setMaxMemoryCost:KEENG_MAX_TOTAL_COST_MEM_CACHE];
    [[SDImageCache sharedImageCache] setMaxCacheSize:KEENG_MAX_DISK_CACHE];
    
    _appDependencies = [[LBAppDependencies alloc] init];
    [_appDependencies presentHomeVCAsRootVCInWindow];
    
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



#pragma mark - Processing Notifications
- (void) handleMemoryWarning:(NSNotification *)notification
{
    
    NSLog(@"WARNING: Device Low memory: %@", notification);
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    NSLog(@"WARNING: Device Low memory");
    
}

@end
