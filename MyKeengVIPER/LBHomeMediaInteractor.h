//
//  LBHomeMediaInteractor.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/3/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBHomeModuleInterface.h"


@interface LBHomeMediaInteractor : NSObject <LBHomePresenterDelegate>

@property(nonatomic , weak) id<LBHomeInteractorDelegate> selfDelegate;

@end
