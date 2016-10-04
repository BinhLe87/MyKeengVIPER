//
//  LBPhotoFiltration.h
//  MyKeeng
//
//  Created by Le Van Binh on 8/10/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LBHomePhotoFiltrationDelegate;
@class LBPhoto;

@interface LBHomePhotoFiltration : NSOperation

@property (nonatomic, readonly) LBPhoto *photo;
@property (nonatomic, readonly) NSIndexPath *indexPathInTableView;
@property (nonatomic) id<LBHomePhotoFiltrationDelegate> delegate;


-(instancetype)initWithPhoto:(LBPhoto *)iPhoto indexPath:(NSIndexPath *)iIndexPath delegate:(id<LBHomePhotoFiltrationDelegate>)iDelegate;

@end

@protocol LBHomePhotoFiltrationDelegate <NSObject>

-(void) LBPhotoFiltrationDidFinish:(LBHomePhotoFiltration *)filtrator;
@end
