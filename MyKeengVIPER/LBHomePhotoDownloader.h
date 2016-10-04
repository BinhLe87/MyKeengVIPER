//
//  LBPhotoDownloader.h
//  MyKeeng
//
//  Created by Le Van Binh on 8/10/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LBHomePhotoDownloaderDelegate;
@class LBPhoto;

@interface LBHomePhotoDownloader : NSOperation {
    
    LBPhoto *_photo;
    NSIndexPath *_indexPathInTableView;
}

@property (nonatomic, readonly) LBPhoto *photo;
@property (nonatomic, readonly) NSIndexPath *indexPathInTableView;
@property (nonatomic) id<LBHomePhotoDownloaderDelegate> delegate;

-(instancetype)initWithPhoto:(LBPhoto *)iPhoto indexPath:(NSIndexPath *)iIndexPath delegate:(id<LBHomePhotoDownloaderDelegate>)iDelegate;
@end


@protocol LBHomePhotoDownloaderDelegate <NSObject>

-(void)photoDownloaderDidFinish:(LBHomePhotoDownloader *)downloader;

@end