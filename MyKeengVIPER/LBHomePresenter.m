//
//  LBHomePresenter.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/4/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBHomePresenter.h"

static const int NUM_ROW_PER_PAGE_NEW = 10;

@implementation LBHomePresenter {
    
    int curPageIdx;
    LBMediaType mediaType;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        curPageIdx = 1;
        mediaType = LBMediaTypeVideo | LBMediaTypeSong | LBMediaTypeFavourite;
    }
    return self;
}


#pragma mark - LBHomeInteractorDelegate implementation
-(void)gotListMedia:(NSArray<LBMedia *> *)mediaArray willGetdataType:(LBMediaType)dataType error:(NSError *)error {
    
    if (!error) {
        
        [_homeVC showUpcomingData:mediaArray];
    }
}

#pragma mark - LBHomeModuleInterface implementation
-(void)updateView {
    
    if (curPageIdx > 1) {
        
        mediaType = LBMediaTypeSong;
    }
    
    [self.selfDelegate getListMedia:curPageIdx size:NUM_ROW_PER_PAGE_NEW willGetDataType:mediaType];
    curPageIdx++;
}



@end
