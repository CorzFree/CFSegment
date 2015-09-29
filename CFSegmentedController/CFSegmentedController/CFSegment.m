//
//  CFSegment.m
//  CFSegmentedController
//
//  Created by crw on 15/9/28.
//  Copyright © 2015年 crw. All rights reserved.
//

#import "CFSegment.h"
#define CF_lineWidth 0.5
#define CF_line_color CF_color_from_rgb(0xcccccc)
#define CF_btn_font [UIFont systemFontOfSize:14]

@interface CFSegment(){
    NSArray *_titleArray;
    NSArray *_btnArray;
    UIView  *_selectLine;
    CGFloat _selectLine_margin_x;
}
@end

@implementation CFSegment

- (instancetype)initWithTitleArray:(NSArray *)titleArray segmentHeight:(CGFloat)height{
    if (self == [super initWithFrame:(CGRect){0,0,CF_screen_width,height}]) {
        if (titleArray && titleArray.count != 0) {
            _titleArray = titleArray;
            [self initSelf];
        }else{
            NSLog(@"titleArray is nil");
            return nil;
        }
    }
    return self;
}

- (void)initSelf{
    NSInteger   count       = _titleArray.count;
    CGFloat     itemWidth   = (CF_screen_width - (count - 1) * CF_lineWidth)/ count;
    
    NSMutableArray *btnArr  = [[NSMutableArray alloc] init];
    for ( int i = 0; i < count ; i ++ ) {
        UIButton *btn       = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame           = ({
            CGFloat x       = itemWidth * i;
            CGFloat lineW   = i == 0 ? 0 : CF_lineWidth;
            CGRectMake(x + lineW, 0, itemWidth, self.frame.size.height);
        });
        btn.titleLabel.font = CF_btn_font;
        btn.tag             = 3000 + i;
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:CF_color_from_rgb(0x909090) forState:UIControlStateNormal];
        [btn setTitleColor:CF_color_from_rgb(0xf9a114) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btnArr addObject:btn];
        
        if (i != count - 1) {
            //btn dividing line
            UIView *dividing   = [[UIView alloc] init];
            dividing.backgroundColor = CF_line_color;
            dividing.frame     = ({
                CGFloat height = self.frame.size.height / 2.0;
                CGFloat y      = (self.frame.size.height - height) / 2.0;
                CGRectMake(CGRectGetMaxX(btn.frame), y, CF_lineWidth, height);
            });
            [self addSubview:dividing];
        }
    }
    _btnArray = btnArr;
    ((UIButton *)_btnArray.firstObject).selected = YES;
    
    //top and bottom line
    CGFloat layerHeight     = 1;
    CALayer *layerTop       = [self getLayer];
    layerTop.frame          = CGRectMake(0, 0, CF_screen_width, layerHeight);
    
    CALayer *layerBottom    = [self getLayer];
    layerBottom.frame       = CGRectMake(0, self.frame.size.height - layerHeight, CF_screen_width, layerHeight);
    [self.layer addSublayer:layerBottom];
    
    //selectLine
    _selectLine             = [[UIView alloc] init];
    _selectLine.backgroundColor= CF_color_from_rgb(0xf9a114);
    _selectLine.frame       = ({
        CGRect  btnF        = ((UIButton *)_btnArray.firstObject).frame;
        CGFloat width       = itemWidth * 2 / 3.0;
        _selectLine_margin_x= (btnF.size.width - width) / 2.0;
        CGRectMake(_selectLine_margin_x, CGRectGetMaxY(btnF) - 2, width, 1);
    });
    [self addSubview:_selectLine];
}

- (CALayer *)getLayer{
    CALayer *layer          = [CALayer layer];
    layer.backgroundColor   = CF_line_color.CGColor;
    [self.layer addSublayer:layer];
    return layer;
}

- (void)setTitleColor:(UIColor *)titleColor{
    for (UIButton *button in _btnArray) {
        [button setTitleColor:titleColor forState:UIControlStateSelected];
    }
}

- (void)setSelectLineColor:(UIColor *)selectLineColor{
    _selectLine.backgroundColor = selectLineColor;
}

- (void)segmentChange:(UIButton *)btn{
    NSInteger tag= btn.tag - 3000;
    [UIView animateWithDuration:0.5 animations:^{
        _selectLine.frame   = ({
            CGRect frame        = _selectLine.frame;
            frame.origin.x      = tag * btn.frame.size.width + _selectLine_margin_x;
            frame;
        });
    } completion:^(BOOL finished) {
        btn.selected = !btn.selected;
        for (UIButton *button in _btnArray) {
            if (button != btn) {
                button.selected = NO;
            }
        }
        if ([_delegate respondsToSelector:@selector(cf_segmentChangeIndex:)]) {
            [_delegate cf_segmentChangeIndex:tag];
        }
    }];
}

@end
