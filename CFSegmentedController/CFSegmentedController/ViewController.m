//
//  ViewController.m
//  CFSegmentedController
//
//  Created by crw on 15/9/28.
//  Copyright © 2015年 crw. All rights reserved.
//

#import "ViewController.h"
#import "CFSegment.h"

@interface ViewController ()<CFSegmentDelegate>
@property (nonatomic,strong) UILabel *descLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CFSegment *segment = [[CFSegment alloc] initWithTitleArray:@[@"全部",@"未付款",@"未发货",@"待收货",@"待评价"] segmentHeight:44];
    segment.frame      = CGRectMake(0, 64,CF_screen_width , 44);
    segment.delegate   = self;
    segment.titleColor = CF_color_from_rgb(0xd56193);
    segment.selectLineColor = CF_color_from_rgb(0xd56193);
    [self.view addSubview:segment];
    self.descLabel.text = @"当前选中:0";
}

-(void)cf_segmentChangeIndex:(NSInteger)index{
    NSLog(@"index -- > %ld",(long)index);
    self.descLabel.text = [NSString stringWithFormat:@"当前选中:%ld",index];
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:(CGRect){0,150,CF_screen_width,50}];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_descLabel];
    }
    return _descLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
