//
//  LBMenuView.h
//  MyKeeng
//
//  Created by Le Van Binh on 9/13/16.
//  Copyright © 2016 LB. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LBHomeMenuItem : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) BOOL enabled;
@property (nonatomic) id target;
@property (nonatomic) SEL action;

-(instancetype)initMenuItem:(NSString*)title target:(id)target action:(SEL)action;
-(void)performAction;
@end


typedef enum {
    
    KxMenuViewArrowDirectionNone,
    KxMenuViewArrowDirectionUp,
    KxMenuViewArrowDirectionDown,
    KxMenuViewArrowDirectionLeft,
    KxMenuViewArrowDirectionRight,
    
} KxMenuViewArrowDirection;


@interface LBHomeOverlayView : UIView

@end


@interface LBHomeMenuView : UIView

@property (nonatomic) NSMutableArray<LBHomeMenuItem*> *menuItems;

-(instancetype)initWithMenuItems:(NSMutableArray<LBHomeMenuItem*>*)menuItems;
-(void)showMenuInView:(UIView*)view fromOwnerRect:(CGRect)fromOwnerRect;
-(void)dismissMenuView;

@end
