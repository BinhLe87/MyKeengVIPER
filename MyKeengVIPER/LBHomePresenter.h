//
//  LBHomePresenter.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/4/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBHomeModuleInterface.h"

@interface LBHomePresenter : NSObject <LBHomeInteractorDelegate, LBHomeModuleInterface>

@property (nonatomic) id<LBHomePresenterDelegate> selfDelegate;
@property (nonatomic) UIViewController<LBHomeViewInterface> *homeVC;

@end
