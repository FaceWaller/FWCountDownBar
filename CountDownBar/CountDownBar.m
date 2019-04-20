//
//  CountDownBar.m
//  CountDownBar
//
//  Created by jpz on 2019/4/20.
//  Copyright © 2019 jpz. All rights reserved.
//

#import "CountDownBar.h"

static CGFloat timeIntervalI= 0.1f;
static CGFloat layerWidth = 6.f;

@interface CountDownBar()
@property(nonatomic,weak)UIButton *btn;
@property(nonatomic,assign)CGFloat startAngle;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)CGFloat currentTime;

@end

@implementation CountDownBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
        [self initParams];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalI target:self selector:@selector(action) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    return self;
}

- (void)setupSubviews{
    UIButton *btn = [[UIButton alloc]init];
    self.btn = btn;
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    CGRect newFrame = self.frame;
    newFrame.size.width -= (layerWidth * 2);
    newFrame.size.height -= (layerWidth * 2);
    btn.frame = newFrame;
    btn.layer.cornerRadius = newFrame.size.width/2;
    [btn.layer masksToBounds];
    btn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

+ (Class)layerClass{
    return [CAShapeLayer class];
}

- (void)initParams{
    self.currentTime = 0.f;
    self.startAngle = -0.5 * M_PI;
}

/**
 开启、刷新动画
 */
- (void)startAnimation{
    [self initParams];
    [self.timer setFireDate:[NSDate date]];
}

- (void)action{
    if (self.currentTime >= self.time) {
        [self dismiss];
        return;
    }
    
    self.currentTime+=timeIntervalI;
    self.startAngle = 2 * M_PI * self.currentTime / self.time - 0.5 * M_PI;
    [self setNeedsDisplay];
}

- (void)dismiss{
    [self.timer invalidate];
    self.timer = nil;
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                      radius:rect.size.width/2 - layerWidth/2
                  startAngle:self.startAngle
                    endAngle:1.5 * M_PI
                   clockwise:YES];
    circle.lineWidth = layerWidth;
    [[UIColor orangeColor] setStroke];
    [circle stroke];
}

- (void)clickBtn{
    if (self.touchBlock) {
        self.touchBlock();
    }
}
@end
