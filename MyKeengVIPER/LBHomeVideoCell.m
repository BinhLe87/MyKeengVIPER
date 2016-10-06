//
//  LBVideoCell.m
//  MyKeeng
//
//  Created by Le Van Binh on 7/14/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import "LBHomeVideoCell.h"
#import "LBVideo.h"

@implementation LBHomeVideoCell


- (void)awakeFromNib {
    
    // Initialization code
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //NSLog(@"Layout of VideoCell: %@", self.contentView.constraints);
}

-(void)layoutSubviews {
    
    //TODO:gradient layer for infoView
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.colors = @ [(id)[[UIColor clearColor] CGColor],(id)[[UIColor colorWithWhite:0.3 alpha:0.1] CGColor],
                         (id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithWhite:0.3 alpha:0.1] CGColor], (id)[[UIColor clearColor] CGColor]];
    gradient.locations = @ [@0.1,@0.3,@0.5,@0.7,@0.9];
    gradient.startPoint = CGPointMake(0.0, 0.0);
    gradient.endPoint = CGPointMake(0.5, 1.0);
    
    
    
    [self.infoView.layer insertSublayer:gradient atIndex:0];
    
    //TODO: custom constraints
    
}



+(NSString *)reusableCellWithIdentifier {
    
    return @"VideoCellID";
}

+(CGFloat)heightForVideoCell {
    
    return 200;
}

#pragma mark - Observing value change of properties
-(void)setVideoInfo:(LBVideo *)videoInfo {
 
    _videoInfo = videoInfo;
}




#pragma mark - Interal methods

-(void)setupUI {
  
    self.VideoNameLbl.text = _videoInfo.name;
    self.SingerLbl.text = _videoInfo.singer;
    self.NumListenLbl.text = [NSString stringWithFormat:@"%d", [_videoInfo.listen_no intValue]];
    self.NumLikeLbl.text = @"New Video";
    self.NumCommentLbl.text = [NSString stringWithFormat:@"Giá %d", [_videoInfo.price intValue]];
}












@end
