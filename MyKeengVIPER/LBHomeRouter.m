//
//  LBHomeRouter.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/4/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBHomeRouter.h"
#import "LBHomeViewController.h"

@interface LBHomeRouter()

@property (nonatomic) LBHomeViewController *homeVC;

@end


@implementation LBHomeRouter


-(void)presentHomeVCAsRootVC {
    
    _homeVC = [[LBHomeViewController alloc] init];
    self.homePresenter.homeVC = _homeVC;
    _homeVC.presenterDelegate = self.homePresenter;
    
    [self.rootViewController initNavControllerWithRootViewController:_homeVC];
}

@end
