//
//  LBHomeNewWithFavouriteVC.h
//  MyKeeng
//
//  Created by Le Van Binh on 7/12/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBSong.h"
#import "LBVideo.h"
#import "LBHomePhotoOperations.h"
#import "LBHomeModuleInterface.h"
#import "LBHomeMenuView.h"

@protocol LBPhotoDownloaderDelegate;
@protocol LBPhotoFiltrationDelegate;


@interface LBHomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, LBHomeViewInterface, UINavigationControllerDelegate> {

    LBHomeMenuView *menuPopupView;
}

@property (nonatomic) UITableView *tableview;
@property (nonatomic) NSMutableArray <LBSong *> *songs;
@property (nonatomic) NSMutableArray <LBVideo *> *videos;
@property (nonatomic) NSMutableArray <LBMedia *> *favourites;
@property (nonatomic) LBHomePhotoOperations *photoOperations;

@property (nonatomic, weak) id<LBHomeModuleInterface> presenterDelegate;

#pragma mark - Image downloader and image filtration
-(void)loadImagesForOnScreenCells;
-(void)startOperationsAtIndexPath:(LBPhoto *)iPhoto fromIndexPath:(NSIndexPath*)iIndexPath;
-(void)startImageDownloadingAtIndexPath:(LBPhoto *)iPhoto indexPath:(NSIndexPath*)iIndexPath;
-(void)startImageFiltrationAtIndexPath:(LBPhoto *)iPhoto indexPath:(NSIndexPath*)iIndexPath;
-(void)suspendAllOperations;
-(void)resumeAllOperations;
-(void)cancellAllOperations;

#pragma mark - Popup message
-(void)showMessageInPopup:(NSString*)message withTitle:(NSString*)title;

@end
