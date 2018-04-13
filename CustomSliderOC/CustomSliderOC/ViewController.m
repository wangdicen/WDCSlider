//
//  ViewController.m
//  CustomSliderOC
//
//  Created by travelsky on 2018/4/13.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

#import "ViewController.h"
#import "CustomSlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CustomSlider *slider = [CustomSlider slider];
    [self.view addSubview:slider];
    slider.center = self.view.center;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
