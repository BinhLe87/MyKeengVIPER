//
//  LBHomeNewWithFavouriteVC.m
//  MyKeeng
//
//  Created by Le Van Binh on 7/12/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import "LBHomeViewController.h"
#import "LBHomeSongCell.h"
#import "LBHomeVideoCell.h"
#import "LBHomeFavouriteCell.h"
#import "LBHomePhotoDownloader.h"
#import "LBHomePhotoFiltration.h"
#import "UIImageView+WebCache.h"
#import "LBMediaConstants.h"



typedef NS_ENUM(NSUInteger, TableSectionType) {
    
    TableSectionTypeVideo = 2,
    TableSectionTypeSong = 0,
    TableSectionTypeFavourite = 1
};



@implementation LBHomeViewController {
    
    int HOMENEW_CELL_WIDTH_NEW;
    LBMediaType mediaType;
}


#pragma mark - Initializers

-(NSMutableArray<LBSong *> *)songs {
    
    if (!_songs) {
        _songs = [NSMutableArray array];
    }
    
    return _songs;
}

-(NSMutableArray<LBVideo *> *)videos {
    
    if (!_videos) {
        _videos = [NSMutableArray array];
    }
    
    return _videos;
}

-(NSMutableArray<LBMedia *> *)favourites {
    
    if (!_favourites) {
        _favourites = [NSMutableArray array];
    }
    
    return _favourites;
}



#pragma mark - Load view

-(LBHomePhotoOperations *)photoOperations {
    
    if (!_photoOperations) {
        
        _photoOperations = [[LBHomePhotoOperations alloc] init];
    }
    
    return _photoOperations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HOMENEW_CELL_WIDTH_NEW = CGRectGetWidth(self.view.bounds);
    mediaType = LBMediaTypeVideo | LBMediaTypeSong | LBMediaTypeFavourite;
    self.navigationController.delegate = self;
    
    //register LBHomeNewSongCell nib file
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
    UINib *songCellNib = [UINib nibWithNibName:@"LBHomeSongCell" bundle:nil];
    [self.tableview registerNib:songCellNib forCellReuseIdentifier:[LBHomeSongCell reusableCellWithIdentifier]];
    
    //register LBVideoCell nib file
    UINib *videoCellNib = [UINib nibWithNibName:@"LBHomeVideoCell" bundle:nil];
    [self.tableview registerNib:videoCellNib forCellReuseIdentifier:[LBHomeVideoCell reusableCellWithIdentifier]];
    
    //set seperator style
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //set status bar
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    
    //clear cache
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    
    //initiate menu popup view
    NSMutableArray<LBHomeMenuItem *> *menuitems = [NSMutableArray array];
    LBHomeMenuItem *menuItemShare = [[LBHomeMenuItem alloc] initMenuItem:@"Chia sẻ" target:self action:@selector(tapMenuShare:)];
    LBHomeMenuItem *menuItemAddFavourite = [[LBHomeMenuItem alloc] initMenuItem:@"Lưu vào danh sách Yêu thích" target:self action:@selector(tapMenuAddFavourite:)];
    
    [menuitems addObjectsFromArray:@[menuItemShare, menuItemAddFavourite]];
    
    menuPopupView = [[LBHomeMenuView alloc] initWithMenuItems:menuitems];
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [_presenterDelegate updateView:mediaType];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    if (self.songs.count > 0) return 3;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    if (section == TableSectionTypeSong) {
        return _songs.count;
    } else if (section == TableSectionTypeVideo) {
        return _videos.count;
    } else if (section == TableSectionTypeFavourite) {
        return 1;
    }
    
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LBMedia *media = indexPath.section == TableSectionTypeSong ? [_songs objectAtIndex:indexPath.row
                                                                  ] : [_videos objectAtIndex:indexPath.row];
    LBPhoto *photo = media.image;
    
    if (indexPath.section == TableSectionTypeSong) {
        
        //TODO: Song - load cell
        LBHomeSongCell *songCell;
        
        songCell = (LBHomeSongCell *)[tableView dequeueReusableCellWithIdentifier:[LBHomeSongCell reusableCellWithIdentifier] forIndexPath:indexPath];
        songCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        SDWebImageOptions songDownloadOptions = SDWebImageProgressiveDownload | SDWebImageContinueInBackground | SDWebImageTransformAnimatedImage;
        
        
        [songCell.SongImg sd_setImageWithURL:photo.url placeholderImage:[UIImage imageNamed:@"image_placeholder.png"] options:songDownloadOptions];
        
        [songCell.SongImg setShowActivityIndicatorView:YES];
        
        
        songCell.SongNameLbl.text = media.name;
        songCell.SingerLbl.text = media.singer;
        songCell.NumListenLbl.text = [NSString stringWithFormat:@"%d", [media.listen_no intValue]];
        songCell.NumLikeLbl.text = @"New Song";
        songCell.NumCommentLbl.text = [NSString stringWithFormat:@"Giá %d", [media.price intValue]];
        songCell.song = (LBSong*)media;
        songCell.indexPathInTableView = indexPath;
        
        //display seperator image at the bottom of cell
        UIImageView *seperatorImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator_cell.png"]];
        seperatorImgView.frame = CGRectMake(0, [LBHomeSongCell heightForSongCell] - 1 , HOMENEW_CELL_WIDTH_NEW, 1);
        
        [songCell.contentView addSubview:seperatorImgView];
        
        
        return songCell;
    } else if (indexPath.section == TableSectionTypeVideo) {
        
        //TODO: Video - load cell
        LBHomeVideoCell *videoCell;
        
        videoCell = (LBHomeVideoCell *)[tableView dequeueReusableCellWithIdentifier:[LBHomeVideoCell reusableCellWithIdentifier] forIndexPath:indexPath];
        
        SDWebImageOptions videoDownloadOptions = SDWebImageProgressiveDownload | SDWebImageContinueInBackground | SDWebImageTransformAnimatedImage;
        
        [videoCell.VideoImg sd_setImageWithURL:photo.url placeholderImage:[UIImage imageNamed:@"image_placeholder.png"] options:videoDownloadOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            //  NSLog(@"%@:%@:%d/%d", media.name, media.image.url, receivedSize, expectedSize);
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [videoCell.VideoImg setShowActivityIndicatorView:YES];
        
        [videoCell setVideoInfo:(LBVideo *)media];
        [videoCell setupUI];
        
        //display seperator image at the bottom of cell
        UIImageView *seperatorImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator_cell.png"]];
        seperatorImgView.frame = CGRectMake(0, [LBHomeVideoCell heightForVideoCell] - 1 , HOMENEW_CELL_WIDTH_NEW, 1);
        
        [videoCell.contentView addSubview:seperatorImgView];
        
        return videoCell;
        
    } else if (indexPath.section == TableSectionTypeFavourite) {
        
        //TODO: Favourite - load cell
        CGRect favouriteCellFrame = CGRectMake(0, 0, self.tableview.bounds.size.width, [LBHomeFavouriteCell heightForFavouriteCell] - [LBHomeFavouriteCell marginY]*2);
        
        CGSize favouriteCellContentSize = CGSizeMake(self.tableview.bounds.size.width * 2, [LBHomeFavouriteCell heightForFavouriteCell] - [LBHomeFavouriteCell marginY]*2);
        
        LBHomeFavouriteCell *favouriteCell = [[LBHomeFavouriteCell alloc] initWithFrameAndContentSize: favouriteCellFrame contentSize:favouriteCellContentSize];
        
        [favouriteCell setFavourites:_favourites];
        
        //display seperator image at the bottom of cell
        UIImageView *seperatorImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator_cell.png"]];
        seperatorImgView.frame = CGRectMake(0, [LBHomeFavouriteCell heightForFavouriteCell] - 1 , HOMENEW_CELL_WIDTH_NEW, 1);
        
        [favouriteCell.contentView addSubview:seperatorImgView];
        
        return favouriteCell;
    }
    
    return nil;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == TableSectionTypeSong) {
        
        return [LBHomeSongCell heightForSongCell];
    } else if (indexPath.section == TableSectionTypeVideo) {
        
        return [LBHomeVideoCell heightForVideoCell];
    } else if (indexPath.section == TableSectionTypeFavourite) {
        
        return [LBHomeFavouriteCell heightForFavouriteCell];
    }
    
    return 0;
}



#pragma mark - Table view Delegates



#pragma mark - LBHomeNewSongCellDelegate
-(void)tapOnMenuPopup:(NSIndexPath *)indexPath {
    
    if (indexPath.section == TableSectionTypeSong) {
        
        LBHomeSongCell *songCell = (LBHomeSongCell*)[self.tableview cellForRowAtIndexPath:indexPath];
        
        if(songCell) {
            
            CGPoint convertedPoint = [songCell.menuMoreImg convertPoint:songCell.menuMoreImg.bounds.origin toView:self.view];
            
            [menuPopupView showMenuInView:self.view fromOwnerRect:(CGRect){convertedPoint, CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)}];
        }
        
    }
}




#pragma mark - Menu popup actions
-(void)tapMenuShare:(id)sender {
    
    NSLog(@"Da tap 'Chia sẻ'");
}

-(void)tapMenuAddFavourite:(id)sender {
    
    NSLog(@"Da tap 'Lưu vào danh sách Yêu thích'");
}

#pragma mark - LBHomeViewInterface implementation
-(void)showUpcomingData:(NSArray<LBMedia *> *)medias {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
        [self.tableview beginUpdates];
        
        int curItemIndex = 0;
        
        
        for (LBMedia *media in medias) {
            
            if ([media isKindOfClass:[LBSong class]]) {
                
                curItemIndex = self.songs.count ? self.songs.count : 0;
                [insertIndexPaths addObject:[NSIndexPath indexPathForRow:self.songs.count inSection:TableSectionTypeSong]];
                [self.songs addObject:(LBSong*) media];
            } else if ([media isKindOfClass:[LBVideo class]]) {
                
                curItemIndex = self.videos.count ? self.videos.count : 0;
                [insertIndexPaths addObject:[NSIndexPath indexPathForRow:self.videos.count inSection:TableSectionTypeVideo]];
                [self.videos addObject:(LBVideo*) media];
            }
            
            [self.favourites addObject:media];
        }
        
        //programmatically insert Favourite section due to have only 1 row
        [insertIndexPaths addObject:[NSIndexPath indexPathForRow:0 inSection:TableSectionTypeFavourite]];
        
        if ([self.tableview numberOfSections] == 0) {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)];
            [self.tableview insertSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
        
        [self.tableview insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self.tableview endUpdates];
        
        [self.tableview reloadData];
    });
    
    
}

#pragma mark - UINavigationControllerDelegate implementation
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES];
}


@end
