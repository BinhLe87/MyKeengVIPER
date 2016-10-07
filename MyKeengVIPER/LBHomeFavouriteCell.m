//
//  LBFavouriteCell.m
//  MyKeeng
//
//  Created by Le Van Binh on 9/15/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import "LBHomeFavouriteCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "LBHomeFavouriteAvatarView.h"
#import "UIImage+AsyncDownload.h"

static int leftRightPadding = 2;

@implementation LBHomeFavouriteCell

- (instancetype)init
{
    
    if (!(self = [super init])) return nil;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.bounces = NO;
    
    [self.contentView addSubview:_scrollView];
    
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsContraints = @{@"scrollview" : _scrollView};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollview]|" options:0 metrics:nil views:viewsContraints]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollview]|" options:0 metrics:nil views:viewsContraints]];
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return self;
}

-(void)setFavourites:(NSArray<LBMedia*> *)medias {
    
    [medias enumerateObjectsUsingBlock:^(LBMedia * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LBHomeFavouriteAvatarView *favView = [[LBHomeFavouriteAvatarView alloc] init];
        [_scrollView addSubview:favView];
        [favView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        __block UIImage *favImage = [UIImage imageNamed:@"image_placeholder.png"];
        
        [UIImage asyncDownloadWithURL:obj.image.url ownerImage:favView completion:^(UIImage *image, id ownerImage) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                LBHomeFavouriteAvatarView *favView = (LBHomeFavouriteAvatarView *)ownerImage;
                favView.image = image;
                
            });
        }];
        
    
        favView.image = favImage;
        
        [favView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_scrollView.mas_height).offset(-3);
            make.width.mas_equalTo(_scrollView.mas_height).offset(-3);
            make.centerY.equalTo(_scrollView.mas_centerY);
        }];    
    }];
    
    [self updateConstraints];
}

-(void)updateConstraints {
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(idx == 0 ? _scrollView.mas_left : [_scrollView.subviews objectAtIndex:idx-1].mas_right).offset(leftRightPadding);
            make.right.equalTo(idx == [_scrollView.subviews count] -1 ? _scrollView.mas_right : [_scrollView.subviews objectAtIndex:idx+1].mas_left).offset(-leftRightPadding);
        }];
        
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}




+(CGFloat)heightForFavouriteCell {
    
    return 70;
}




@end
