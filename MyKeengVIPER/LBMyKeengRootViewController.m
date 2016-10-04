//
//  LBMyKeengRootView.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/4/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBMyKeengRootViewController.h"

@implementation LBMyKeengRootViewController

-(UIWindow *)window {
    
    if (!_window) {
        
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [_window makeKeyAndVisible];
    }
    
    return _window;
}

-(UINavigationController *)navigationController {
    
    if (!_navigationController) {
        
        _navigationController = [[UINavigationController alloc] init];
        
        self.window.rootViewController = _navigationController;
    }
    
    return _navigationController;
}

-(void)setViewControllersIntoNavController:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    
    [self.navigationController setViewControllers:viewControllers animated:animated];
}

-(void)initNavControllerWithRootViewController:(UIViewController *)rootViewController {
    
    [self.navigationController setViewControllers:@[rootViewController] animated:NO];
}


@end
