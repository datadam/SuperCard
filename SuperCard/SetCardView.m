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

- (void)drawOval {
    
}

- (void)drawSquiggle {
    
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
            [self drawOval];
            break;
        case kSquiggle:
            [self drawSquiggle];
            break;
    }
}


@end
