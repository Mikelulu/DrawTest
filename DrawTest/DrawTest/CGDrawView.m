//
//  CGDrawView.m
//  DrawTest
//
//  Created by Mike on 2017/1/3.
//  Copyright © 2017年 LK. All rights reserved.
//

#import "CGDrawView.h"

@implementation CGDrawView
{
    CGFloat progress;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //1.获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //绘制文字
//    [self drawTextWith:contextRef];
    
    //绘制图片
//    [self drawImageWith:contextRef];
    
    //绘制三条线
//    [[self bezierPathWithPoint:CGPointMake(10, 10) endPoint:CGPointMake(10, 180) lineColor:[UIColor purpleColor] lineWidth:6] stroke];
//    [[self bezierPathWithPoint:CGPointMake(50, 10) endPoint:CGPointMake(50, 180) lineColor:[UIColor greenColor] lineWidth:6] stroke];
//    [[self bezierPathWithPoint:CGPointMake(90, 10) endPoint:CGPointMake(90, 180) lineColor:[UIColor orangeColor] lineWidth:6] stroke];
    
    //绘制下载进度
    [self drawDownloadView];
}

- (void)drawTextWith:(CGContextRef)contextRef
{
    NSString *textStr = @"iOS开发";
    
    //字体阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    //阴影偏移量
    shadow.shadowOffset = CGSizeMake(2, 2);
    //阴影颜色
    shadow.shadowColor = [UIColor greenColor];
    //高斯模糊
    shadow.shadowBlurRadius = 5.0;
    
    NSDictionary *diction = @{
                              NSForegroundColorAttributeName : [UIColor blueColor],
                              NSFontAttributeName : [UIFont systemFontOfSize:20.f],
                              NSBackgroundColorAttributeName : [UIColor redColor],
                              NSShadowAttributeName : shadow,
                              NSKernAttributeName : @10
                              };
    
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:textStr attributes:diction];
    
    [attributedStr drawInRect:CGRectMake(10, 10, 100, 20)];
    //添加到上下文
    CGContextStrokePath(contextRef);
}

- (void)drawImageWith:(CGContextRef)contextRef
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"back.jpg" ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:file];
    
    //    //绘制的大小位置
    //    [image drawInRect:self.bounds];
    
    
    //    //从某个点开始绘制
    //    [image drawAtPoint:CGPointMake(0, 0)];
    
    
    //绘制一个多大的图片，并且设置他的混合模式以及透明度
    //Rect：大小位置
    //blendModel：混合模式
    //alpha：透明度
    [image drawInRect:self.bounds blendMode:kCGBlendModeNormal alpha:1];
    
    //从某一点开始绘制图片，并设置混合模式以及透明度
    //point:开始位置
    //blendModel：混合模式
    //alpha：透明度
    //    [image drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeNormal alpha:1];

    CGContextStrokePath(contextRef);
}
- (UIBezierPath *)bezierPathWithPoint:(CGPoint)startPoint endPoint:(CGPoint) endPoint lineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [lineColor setStroke];
    path.lineWidth = lineWidth;
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    return path;
}

- (instancetype)initWithFrame:(CGRect)frame
{
   self =  [super initWithFrame:frame];
   
    if (self) {
        
//        __block NSInteger count = 0;
        
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            
            progress = progress + 0.05;
//            count ++;
            if (progress >= 1.0) {
                if (progress > 1) {
                    progress = 1.0;
                }
                dispatch_cancel(timer);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self setNeedsDisplay];
            });
        });
        dispatch_resume(timer);
    }
    return self;
}
- (void)drawDownloadView
{
    NSString *string = [NSString stringWithFormat:@"%.2f%%",progress * 100];
    NSDictionary *dict = @{
                           NSFontAttributeName : [UIFont systemFontOfSize:15.0f],
                           NSForegroundColorAttributeName : [UIColor colorWithRed:progress green:0 blue:0 alpha:1]
                            };
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:string attributes:dict];

    [attribute drawAtPoint:CGPointMake(self.bounds.size.width * 0.5 - attribute.size.width * 0.5, self.bounds.size.height * 0.5 - attribute.size.height * 0.5)];
    
    CGFloat startA = - M_PI_2;
    CGFloat endA = M_PI * 2 * progress - M_PI_2 ;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:self.bounds.size.width*0.5-10 startAngle:startA endAngle:endA clockwise:YES];
   
    [[UIColor colorWithRed:progress green:(1-progress) blue:0 alpha:1]setStroke];
    
    path.lineCapStyle = kCGLineCapRound;//线条拐角
    path.lineJoinStyle = kCGLineJoinRound;//线条终点
    
    path.lineWidth = 5;
    [path stroke];
}


@end
