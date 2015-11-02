# CFSegment
![enter image description here](https://github.com/CorzFree/CFSegment/blob/master/demo.gif)


使用
--

    CFSegment *segment = [[CFSegment alloc] initWithTitleArray:@[@"全部",@"未付款",@"未发货",@"待收货",@"待评价"] segmentHeight:44];
    segment.frame      = CGRectMake(0, 64,CF_screen_width , 44);
    segment.delegate   = self;
    segment.titleColor = CF_color_from_rgb(0xd56193);
    segment.selectLineColor = CF_color_from_rgb(0xd56193);
    [self.view addSubview:segment];

回调
--

    -(void)cf_segmentChangeIndex:(NSInteger)index{
    NSLog(@"index -- > %ld",(long)index);
    self.descLabel.text = [NSString stringWithFormat:@"当前选中:%ld",index];
}
