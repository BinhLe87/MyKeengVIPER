//
//  LBMyKeengRootView.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/4/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LBMyKeengRootViewController : NSObject

@property(nonatomic) UINavigationController *navigationController;
@property(nonatomic) UIWindow *window;


-(void)setViewControllersIntoNavController:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

-(void)initNavControllerWithRootViewController:(UIViewController*)rootViewController;
@end
