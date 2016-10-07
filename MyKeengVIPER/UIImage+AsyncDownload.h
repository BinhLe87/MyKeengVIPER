//
//  UIImage+AsyncDownload.h
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/7/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DownloadCompletion)(UIImage *image, id ownerImage);
@interface UIImage (AsyncDownload)

+(void)asyncDownloadWithURL:(NSURL*)imageURL ownerImage:(id)ownerImage completion:(DownloadCompletion)completion;

@end


@interface LBImageDownloader : NSOperation

-(instancetype)initWithURL:(NSURL*)imageURL ownerImage:(id)ownerImage completion:(DownloadCompletion)completion;


@end
