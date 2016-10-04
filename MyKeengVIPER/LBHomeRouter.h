//
//  LBHomeRouter.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/4/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBHomeModuleInterface.h"
#import "LBHomePresenter.h"
#import "LBMyKeengRootViewController.h"

@interface LBHomeRouter : NSObject

@property(nonatomic) LBHomePresenter *homePresenter;
@property(nonatomic) LBMyKeengRootViewController *rootViewController;

-(void)presentHomeVCAsRootVC;

@end
