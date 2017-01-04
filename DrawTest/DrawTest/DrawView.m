//
//  DrawView.m
//  DrawTest
//
//  Created by Mike on 2016/12/30.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
   
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
    
    CGContextAddPath(contextRef, path.CGPath);
    
    CGContextStrokePath(contextRef);

    //绘制直线
//    [self drawLine];
    
    //绘制矩形
//    [self drawRect];
    
    //绘制圆
//    [self drawCircle];
    
    //绘制椭圆
//    [self drawEllipse];
    
    //绘制多边形
//    [self drawPolygon];
    
    //绘制不规则形状
//    [self drawIrregularShape];
    
    //绘制贝塞尔曲线
//    [self drawCurve];
    
    //一朵花（曲线组合）
    [self drawCurveCombination];
}
- (void)drawLine
{
//    //获取上下文
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    //描述路径
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    //起点
//    [path moveToPoint:CGPointMake(0, 0)];
//    //终点
//    [path addLineToPoint:CGPointMake(100, 100)];
//    //设置颜色
//    [[UIColor redColor] setStroke];
//    //添加路径
//    CGContextAddPath(contextRef, path.CGPath);
//    //显示路径
//    CGContextStrokePath(contextRef);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path setLineWidth:1];
    [[UIColor whiteColor] setStroke];
    [path stroke];
    
}
- (void)drawRect
{
//    [[UIColor whiteColor] setStroke];
//    [[UIColor orangeColor] setFill];
//    UIRectFill(CGRectMake(20, 20, 100, 50));
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 100, 50)];
    //设置画笔颜色
    [[UIColor redColor] setStroke];
    
    [path setLineWidth:2];
    
    [path setLineCapStyle:kCGLineCapRound];//线条拐角
    [path setLineJoinStyle:kCGLineJoinRound];//终点处理
    
    [path stroke];//绘画
}
- (void)drawCircle
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 100, 100)];
    [[UIColor whiteColor] setStroke];
   
    [path setLineCapStyle:kCGLineCapRound];//线条拐角
    [path setLineJoinStyle:kCGLineJoinRound];//终点处理
    
    [path stroke];
}
- (void)drawEllipse
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 100, 50)];
    [[UIColor whiteColor] setStroke];
    
    [path setLineCapStyle:kCGLineCapRound];//线条拐角
    [path setLineJoinStyle:kCGLineJoinRound];//终点处理
    
    [path stroke];
}

/**
 多边形是一些简单的形状,这些形状是由一些直线线条组成，我们可以用moveToPoint: 和 addLineToPoint:方法去构建。moveToPoint:设置我们想要创建形状的起点。从这点开始，我们可以用方法addLineToPoint:去创建一个形状的线段。
 我们可以连续的创建line，每一个line的起点都是先前的终点，终点就是指定的点。
 closePath可以在最后一个点和第一个点之间画一条线段
 */
- (void)drawPolygon
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [[UIColor redColor] setStroke];
    
    //起点
    [path moveToPoint:CGPointMake(100, 0)];
    
    //绘画线条
    [path addLineToPoint:CGPointMake(200, 140)];
    [path addLineToPoint:CGPointMake(160, 140)];
    [path addLineToPoint:CGPointMake(40, 140)];
    [path addLineToPoint:CGPointMake(0, 40)];
    
    //连接第一个和最后一个点
    [path closePath];
    
    [path setLineWidth:5];
    [path setLineCapStyle:kCGLineCapRound];//线条拐角
    [path setLineJoinStyle:kCGLineJoinRound];//终点处理
    
    //根据坐标点连线
    [path stroke];
    
    //设置填充颜色
    [[UIColor orangeColor] setFill];
    [path fill];
}

/**
 想画弧线组成的不规则形状，我们需要使用中心点、弧度和半径，弧度使用顺时针脚底，0弧度指向右边，pi/2指向下方，pi指向左边，-pi/2指向上方。然后使用bezierPathWithArcCenter: radius: startAngle endAngle: clockwise:方法来绘制
 */
- (void)drawIrregularShape
{
    //center:弧线中心点的坐标
    //radius:弧线所在圆的半径
    //startAngle:弧线开始的角度值
    //endAngle:弧线结束的角度值
    //clockwise:是否顺时针画弧线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(80, 80) radius:75 startAngle:0 endAngle:M_PI clockwise:YES];
    
    [path setLineWidth:5];
    [path setLineCapStyle:kCGLineCapRound];//线条拐角
    [path setLineJoinStyle:kCGLineJoinRound];//终点处理

    [path stroke];
}
- (void)drawCurve
{
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    aPath.lineWidth = 5.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    [aPath moveToPoint:CGPointMake(20, 100)];
    
    //画二元曲线，一般和moveToPoint配合使用
    //endPoint:曲线的终点
    //controlPoint:画曲线的基准点
//    [aPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
    
    //以三个点画一段曲线，一般和moveToPoint配合使用
    //endPoint:曲线的终点
    //controlPoint1:画曲线的第一个基准点
    //controlPoint2:画曲线的第二个基准点
    [aPath addCurveToPoint:CGPointMake(155, 80) controlPoint1:CGPointMake(80, 0) controlPoint2:CGPointMake(110, 100)];
    
    [aPath stroke];
}

- (void)drawCurveCombination
{
    CGSize size = self.bounds.size;
    CGFloat margin = 10;
    //rintf：四舍五入函数
    CGFloat radius = rintf(MIN(size.height - margin, size.width - margin) / 4);
    CGFloat xOffset, yOffset;
    
    CGFloat offset = rintf((size.height - size.width) / 2);
    if (offset > 0) {
        xOffset = (CGFloat)rint(margin / 2);
        yOffset = offset;
    } else {
        xOffset = -offset;
        yOffset = rintf(margin / 2);
    }
    
    [[UIColor redColor] setFill];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path addArcWithCenter:CGPointMake(radius * 2 + xOffset, radius + yOffset)
                    radius:radius
                startAngle:(CGFloat)-M_PI
                  endAngle:0
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 3 + xOffset, radius * 2 + yOffset)
                    radius:radius
                startAngle:(CGFloat)-M_PI_2
                  endAngle:(CGFloat)M_PI_2
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 2 + xOffset, radius * 3 + yOffset)
                    radius:radius
                startAngle:0
                  endAngle:(CGFloat)M_PI
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius + xOffset, radius * 2 + yOffset)
                    radius:radius
                startAngle:(CGFloat)M_PI_2
                  endAngle:(CGFloat)-M_PI_2
                 clockwise:YES];
    [path closePath];
    [path fill];
}
@end
