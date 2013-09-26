//
//  SetCardView.m
//  SuperCard
//
//  Created by Derek Taylor on 9/24/13.
//  Copyright (c) 2013 Derek Taylor. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

- (void) setup {
    //initialization here
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)pushContextAndTranslateToDrawRect:(CGRect)drawRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, drawRect.origin.x, drawRect.origin.y);
    //CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    //CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)drawDiamondinRect:(CGRect)drawRect {
    //CGMutablePathRef diamondPath;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, drawRect.origin.x, drawRect.origin.y);
    CGContextMoveToPoint(context, 0.0, drawRect.size.height/2);
    CGContextAddLineToPoint(context, drawRect.size.width/2, 0.0);
    CGContextAddLineToPoint(context, drawRect.size.width, drawRect.size.height/2);
    CGContextAddLineToPoint(context, drawRect.size.width/2, drawRect.size.height);
    CGContextClosePath(context);
    //CGContextSetLineWidth(context, 2.0);
    //CGContextStrokePath(context);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextFillPath(context);
    //CGContextDrawPath(context, kCGPathFill);
    [self popContext];
    NSLog(@"Drawing diamond");
    //UIBezierPath *diamond = [UIBezierPath bezierPathWithCGPath:diamondPath];
}

- (void)drawOvalinRect:(CGRect)drawRect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSaveGState(context);
    //CGContextTranslateCTM(context, drawRect.origin.x, drawRect.origin.y);
    CGContextAddEllipseInRect(context, drawRect);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextFillPath(context);
    NSLog(@"Drawing oval");
}

#define SQUIGGLE_START_OFFSET (0.15)
#define SQUIGGLE_END_OFFSET (0.75)
#define SQUIGGLE_END_YOFFSET (0.25)

- (void)drawSquiggleinRect:(CGRect)drawRect {
#if 0
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, drawRect.origin.x, drawRect.origin.y);
    CGContextMoveToPoint(context, (drawRect.size.width * SQUIGGLE_START_OFFSET), drawRect.size.height);
    CGContextAddArcToPoint(context, (0.0 - (2*drawRect.size.width*SQUIGGLE_START_OFFSET)), (0.0 - (0.5*drawRect.size.height)), (0.1*drawRect.size.width), (drawRect.size.height*SQUIGGLE_END_YOFFSET), (drawRect.size.height/2));
    //CGContextAddArcToPoint(context, (drawRect.size.width*1.5), (drawRect.size.height*0.5), ((1.0 - SQUIGGLE_START_OFFSET)*drawRect.size.width), drawRect.size.height, drawRect.size.height/2);
    //CGContextAddArcToPoint(context, (drawRect.size.width*1.5), (drawRect.size.height*1.5), ((1.0 - SQUIGGLE_END_OFFSET)*drawRect.size.width), ((1.0 - SQUIGGLE_END_YOFFSET)*drawRect.size.height), drawRect.size.height/2);
    //CGContextAddArcToPoint(context, (0.0 - (2*drawRect.size.width*SQUIGGLE_START_OFFSET)), (0.5*drawRect.size.height), (drawRect.size.width * SQUIGGLE_START_OFFSET), drawRect.size.height, drawRect.size.height/2);
    //CGContextClosePath(context);
    
    //CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    //CGContextFillPath(context);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokePath(context);
#else
    UIBezierPath * path= [[UIBezierPath alloc] init];
    CGPoint bottomLeft, topRight, control1, control2, control3, control4;
    bottomLeft.x = drawRect.origin.x;
    bottomLeft.y = drawRect.origin.y + drawRect.size.height;
    topRight.x = drawRect.origin.x + drawRect.size.width;
    topRight.y = drawRect.origin.y;
    control1.x = drawRect.origin.x + drawRect.size.width * 0.25;
    control1.y = drawRect.origin.y - drawRect.size.height * 0.5;
    control2.x = drawRect.origin.x + drawRect.size.width * 0.75;
    control2.y = drawRect.origin.y + drawRect.size.height * 0.5;
    control3.x = drawRect.origin.x + drawRect.size.width * 0.75;
    control3.y = drawRect.origin.y + drawRect.size.height * 1.5;
    control4.x = drawRect.origin.x + drawRect.size.width * 0.25;
    control4.y = drawRect.origin.y + drawRect.size.height * 0.5;
    [path moveToPoint:bottomLeft];
    [path addCurveToPoint:topRight controlPoint1:control1 controlPoint2:control2];
    [path addCurveToPoint:bottomLeft controlPoint1:control3 controlPoint2:control4];
    [path stroke];
    [path fill];
#endif
    NSLog(@"Drawing squiggle");
}

#define CORNER_RADIUS (12.0)
#define RECT_HEIGHT (0.2)
#define RECT_WIDTH (0.8)

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    CGRect drawRect;
    drawRect.origin.y = self.bounds.size.height/2 - self.bounds.size.height * RECT_HEIGHT/2;
    drawRect.origin.x = self.bounds.size.width * (1.0 - RECT_WIDTH)/2;
    drawRect.size.height = self.bounds.size.height * RECT_HEIGHT;
    drawRect.size.width = self.bounds.size.width * RECT_WIDTH;
    
    //NSLog(@"drawing rect with symbol: %@", self.symbol == kDiamond ? @"diamond" : self.symbol == kSquiggle ? @"squiggle" : @"oval");
    switch (self.symbol) {
        case kDiamond:
            [self drawDiamondinRect:drawRect];
            break;
        case kOval:
            [self drawOvalinRect:drawRect];
            break;
        case kSquiggle:
            [self drawSquiggleinRect:drawRect];
            break;
    }
}


@end
