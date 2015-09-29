//
//  CFSegment.h
//  CFSegmentedController
//
//  Created by crw on 15/9/28.
//  Copyright © 2015年 crw. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CF_color_from_rgb(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define CF_screen_width [[UIScreen mainScreen] bounds].size.width

@protocol CFSegmentDelegate <NSObject>

@required
- (void)cf_segmentChangeIndex:(NSInteger)index;
@end

@interface CFSegment : UIView

- (instancetype)initWithTitleArray:(NSArray *)titleArray segmentHeight:(CGFloat)height;

@property (nonatomic,weak) id <CFSegmentDelegate> delegate;

@property (nonatomic,copy,readwrite) UIColor *titleColor;

@property (nonatomic,copy,readwrite) UIColor *selectLineColor;
@end
