//
//  UIImage+AsyncDownload.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/7/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "UIImage+AsyncDownload.h"
#import "LBDownloadManager.h"

@implementation UIImage(AsyncDownload)

+(void)asyncDownloadWithURL:(NSURL *)imageURL ownerImage:(id)ownerImage completion:(DownloadCompletion)completion {
    
    LBImageDownloader *imageDownloader = [[LBImageDownloader alloc] initWithURL:imageURL ownerImage:ownerImage completion:completion];
    
    [[LBDownloadManager sharedInstance].downloadImageQueue addOperation:imageDownloader];
}

@end


@implementation LBImageDownloader {
    
    NSURL *_imageURL;
    DownloadCompletion _downloadCompletion;
    id _ownerImage;
    
}
@synthesize executing = _executing;
@synthesize finished = _finished;


-(instancetype)initWithURL:(NSURL *)imageURL ownerImage:(id)ownerImage completion:(DownloadCompletion)completion {
    
    if (!(self = [super init])) return nil;
    
    _imageURL = imageURL;
    _downloadCompletion = completion;
    _ownerImage = ownerImage;
    
    return self;
}

-(void)start {
    
    @autoreleasepool {
        
        UIImage *downloadedImage;
        self.executing = YES;
        
        if (self.isCancelled) {
            self.executing = NO;
            self.finished = YES;
            return;
        }
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:_imageURL];
        
        if (self.isCancelled) {
            self.executing = NO;
            self.finished = YES;
            imageData = nil;
            return;
        }
        
        if (imageData) {
            
            downloadedImage = [UIImage imageWithData:imageData];
        }
        
        imageData = nil;
        
        if (self.isCancelled) {
            
            self.executing = NO;
            self.finished = YES;
            return;
        }
        
        if (_downloadCompletion) {
            
            _downloadCompletion(downloadedImage, _ownerImage);
        }
        
        self.executing = NO;
        self.finished = YES;
    }
}


- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isConcurrent {
    return YES;
}

@end