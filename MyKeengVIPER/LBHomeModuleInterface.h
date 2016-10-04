//
//  LBHomeModuleInterface.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/3/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBMediaConstants.h"
#import "LBMedia.h"
#import "LBMediaConstants.h"


@protocol LBHomeInteractorDelegate <NSObject>

-(void)gotListMedia:(NSArray<LBMedia*>*)mediaArray willGetdataType:(LBMediaType)dataType error:(NSError*)error;

@end

@protocol LBHomePresenterDelegate <NSObject>

-(void)getListMedia:(int)page size:(int)size willGetDataType:(LBMediaType)dataType;

@end



@protocol LBHomeModuleInterface <NSObject>

-(void)updateView:(LBMediaType)dataType;
@end


@protocol LBHomeViewInterface <NSObject>

-(void)showUpcomingData:(NSArray<LBMedia *>*) medias;

@end