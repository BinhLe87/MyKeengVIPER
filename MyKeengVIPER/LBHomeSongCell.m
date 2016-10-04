//
//  LBHomeNewSongCell.m
//  MyKeeng
//
//  Created by Le Van Binh on 7/12/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import "LBHomeSongCell.h"


@implementation LBHomeSongCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}



+(NSString *)reusableCellWithIdentifier {
    
    return @"SongCellID";
}


+(CGFloat)heightForSongCell {
    
    return 120;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    CGPoint locationInMenuMoreOptImage = [touch locationInView:self.menuMoreImg];
    
    CGRect extendedMenuIconRect = CGRectInset(self.menuMoreImg.bounds, -10, -10);

    if (CGRectContainsPoint(extendedMenuIconRect, locationInMenuMoreOptImage)) {
        
        if ([self.delegate respondsToSelector:@selector(tapOnMenuPopup:)]) {
            
            [self.delegate tapOnMenuPopup:_indexPathInTableView];
        }
    } else {
        
        [super touchesBegan:touches withEvent:event];
    }
}


@end
