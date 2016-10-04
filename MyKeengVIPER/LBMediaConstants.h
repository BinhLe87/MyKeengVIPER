//
//  LBMediaConstants.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/3/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, LBMediaType) {
    
    LBMediaTypeVideo = 1 << 0,
    LBMediaTypeSong = 1 << 1,
    LBMediaTypeFavourite = 1 << 2
};

