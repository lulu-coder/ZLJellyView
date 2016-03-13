//
//  ZLJellyView.m
//  ZLJellyView
//
//  Created by 张璐 on 16/1/20.
//  Copyright © 2016年 张璐. All rights reserved.
//

#import "ZLJellyView.h"
#define minHeight 100

@interface ZLJellyView ()
@property(nonatomic,strong)CAShapeLayer * shapeLayer;
@property(nonatomic,strong)CADisplayLink * displayLink;
@property(nonatomic,assign)CGFloat redViewX;
@property(nonatomic,assign)CGFloat redViewY;
@property(nonatomic,strong)UIView * redView;
@end

@implementation ZLJellyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupShapeLayer];
        [self setupRedView];
        [self setupAction];
        
    }
    return self;
}

//配置shapeLayer
-(void)setupShapeLayer
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [UIColor purpleColor].CGColor;
    [self.layer addSublayer:self.shapeLayer];
}

//配置小红点
-(void)setupRedView
{
    self.redViewX = self.frame.size.width * 0.5;
    self.redViewY = minHeight;
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(self.redViewX, self.redViewY, 3, 3)];
    self.redView.backgroundColor = [UIColor redColor];
    [self addSubview:self.redView];
}

//配置手势，displaylink
-(void)setupAction
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
    
   self.displayLink  = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.displayLink.paused = YES;
    
}

-(void)panAction:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [pan translationInView:self];
        self.redViewX = self.redViewX + point.x;
        CGFloat mheight = point.y * 0.7 + minHeight;
        self.redViewY = mheight > minHeight ? mheight : minHeight;
        self.redView.frame = CGRectMake(self.redViewX, self.redViewY, self.redView.frame.size.width, self.redView.frame.size.height);
        
        [self updateShapeLayerPath];
        
        
    }
    else if (pan.state == UIGestureRecognizerStateCancelled ||pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateFailed)
    {
        self.displayLink.paused = NO;
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.redView.frame = CGRectMake(self.frame.size.width * 0.5, minHeight, 3, 3);
        } completion:^(BOOL finished) {
            self.displayLink.paused = YES;
        }];
    }
}

//计算redview坐标，从而确定shapelayer形状
-(void)calculatePath
{
    CALayer * layer = self.redView.layer.presentationLayer;
    self.redViewX = layer.position.x;
    self.redViewY = layer.position.y;
    [self updateShapeLayerPath];
}

//更新shapelayer形状
-(void)updateShapeLayerPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, minHeight)];
    [path addQuadCurveToPoint:CGPointMake(0, minHeight) controlPoint:CGPointMake(self.redViewX, self.redViewY)];
    [path closePath];
    self.shapeLayer.path = path.CGPath;
    
}

@end
