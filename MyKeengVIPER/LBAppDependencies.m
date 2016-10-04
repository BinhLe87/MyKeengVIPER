//
//  LBAppDependencies.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/4/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBAppDependencies.h"
#import "LBMyKeengRootViewController.h"

//'Home' module
#import "LBHomeMediaInteractor.h"
#import "LBHomePresenter.h"
#import "LBHomeViewController.h"
#import "LBHomeRouter.h"
#import "LBHomeModuleInterface.h"

@interface LBAppDependencies()

@property(nonatomic) LBHomeRouter *homeRouter;

@end


@implementation LBAppDependencies


-(instancetype)init {
    
    if (!(self = [super init])) return nil;
    
    [self configureDependencies];
    
    return self;
}

- (void)configureDependencies {
    
    //TODO: RootViewController
    LBMyKeengRootViewController *rootViewController = [[LBMyKeengRootViewController alloc] init];
    
    //TODO: 'Home' module
    LBHomePresenter *homePresenter = [[LBHomePresenter alloc] init];
    _homeRouter = [[LBHomeRouter alloc] init];
    LBHomeMediaInteractor *homeInteractor = [[LBHomeMediaInteractor alloc] init];
    
    homeInteractor.selfDelegate = homePresenter;
    
    homePresenter.selfDelegate = homeInteractor;
    
    _homeRouter.homePresenter = homePresenter;
    _homeRouter.rootViewController = rootViewController;
    
    
}

-(void)presentHomeVCAsRootVCInWindow {
    
    [self.homeRouter presentHomeVCAsRootVC];
}



@end
