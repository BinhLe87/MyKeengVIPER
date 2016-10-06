//
//  LBFavouriteCell.h
//  MyKeeng
//
//  Created by Le Van Binh on 9/15/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBMedia.h"

@interface LBHomeFavouriteCell : UITableViewCell

@property (nonnull) UIScrollView *scrollView;


-(void)setFavourites:(NSArray<LBMedia*> *)medias;
+(CGFloat)heightForFavouriteCell;
+(CGFloat)marginY;
@end
