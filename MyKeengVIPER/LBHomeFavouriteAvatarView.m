//
//  LBHomeFavouriteAvatarView.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/7/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBHomeFavouriteAvatarView.h"
#import "UIImage+Default.h"

@implementation LBHomeFavouriteAvatarView

-(instancetype)init {
    
    if (!(self = [super init])) return nil;
    
    [self setup];
    
    return self;
}

-(void)setImage:(UIImage *)image {
    
    _image = image;
    
    [self setNeedsDisplay];
}

-(UIColor *)bolderColor {
    
    if (_bolderColor) return _bolderColor;
    
    return [UIColor colorWithWhite:.8f alpha:.8f];
}

-(void)setup {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

-(void)drawRect:(CGRect)rect {
    
    if (_image) {
        
        CGFloat kLineWidth = 1.f;
        UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [ovalPath fill];
        [ovalPath addClip];
        [_image drawInRect:self.bounds];
        [self.bolderColor setStroke];
        ovalPath.lineWidth = kLineWidth;
        [ovalPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.f];
    } else {
        
        [self drawDefaultFavouriteView];
    }
    
    
}

-(void)drawDefaultFavouriteView {
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.71 green: 0.923 blue: 0.445 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 0.369 green: 0.601 blue: 0.89 alpha: 1];
    
    //// Group
    {
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 66.5, 66.5)];
        [color2 setStroke];
        ovalPath.lineWidth = 1;
        [ovalPath stroke];
        
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(17, 21, 10, 12)];
        [color setStroke];
        oval2Path.lineWidth = 1;
        [oval2Path stroke];
        
        
        //// Oval 3 Drawing
        UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(45, 21, 10, 12)];
        [color setStroke];
        oval3Path.lineWidth = 1;
        [oval3Path stroke];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(45.17, 49.75)];
        [bezierPath addCurveToPoint: CGPointMake(34.49, 56.86) controlPoint1: CGPointMake(43.74, 53.87) controlPoint2: CGPointMake(39.5, 56.86)];
        [bezierPath addCurveToPoint: CGPointMake(23.82, 49.75) controlPoint1: CGPointMake(29.48, 56.86) controlPoint2: CGPointMake(25.24, 53.87)];
        [bezierPath addLineToPoint: CGPointMake(45.17, 49.75)];
        [bezierPath closePath];
        [color setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
    }
    
}

@end
