//
//  ViewController.m
//  CountDownBar
//
//  Created by jpz on 2019/4/20.
//  Copyright © 2019 jpz. All rights reserved.
//

#import "ViewController.h"
#import "CountDownBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CountDownBar * bar = [[CountDownBar alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    bar.time = 5.f;
    [self.view addSubview:bar];
    [bar startAnimation];
    
    bar.touchBlock = ^(){
        NSLog(@"点击了按钮");
    };
}


@end
