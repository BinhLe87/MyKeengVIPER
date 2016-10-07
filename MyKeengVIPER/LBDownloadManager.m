//
//  DownloadManager.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/7/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBDownloadManager.h"

@implementation LBDownloadManager

-(NSMutableDictionary *)downloadImageInProgress {
    
    if (!_downloadImageInProgress) {
        
        _downloadImageInProgress = [[NSMutableDictionary alloc] init];
    }
    
    return _downloadImageInProgress;
}

-(NSOperationQueue *)downloadImageQueue {
    
    if (!_downloadImageQueue) {
        
        _downloadImageQueue = [[NSOperationQueue alloc] init];
        _downloadImageQueue.name = @"Download Image Queue";
    }
    
    return _downloadImageQueue;
}


+(instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static LBDownloadManager *downloadManager = nil;
    
    dispatch_once(&onceToken, ^{
        
        downloadManager = [[LBDownloadManager alloc] init];
    });
    
    return downloadManager;
}

@end
