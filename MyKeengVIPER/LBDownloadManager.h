//
//  DownloadManager.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/7/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBDownloadManager : NSObject

@property(nonatomic)NSMutableDictionary *downloadImageInProgress;
@property(nonatomic)NSOperationQueue *downloadImageQueue;

+(instancetype)sharedInstance;

@end
