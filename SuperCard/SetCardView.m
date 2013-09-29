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

- (void)drawDiamondinRect:(CGRect)drawRect
                withColor:(ColorType)color
              withShading:(ShadeType)shading
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, drawRect.origin.x, drawRect.origin.y);
    CGContextMoveToPoint(context, 0.0, drawRect.size.height/2);
    CGContextAddLineToPoint(context, drawRect.size.width/2, 0.0);
    CGContextAddLineToPoint(context, drawRect.size.width, drawRect.size.height/2);
    CGContextAddLineToPoint(context, drawRect.size.width/2, drawRect.size.height);
    CGContextClosePath(context);
    
    int alphaValue = 0.0;
    if (shading == kStriped) {
        alphaValue = 0.3;
    } else if (shading == kSolid) {
        alphaValue = 1.0;
    }
    
    if (color == kGreen) {
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, alphaValue);
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    } else if (color == kRed) {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, alphaValue);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    } else { // (color == kPurple)
        CGContextSetRGBFillColor(context, 1.0, 0.0, 1.0, alphaValue);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 1.0, 1.0);
    }

    CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath(context);
    CGContextFillPath(context);
    
    [self popContext];
    NSLog(@"Drawing diamond");
}

- (void)drawOvalinRect:(CGRect)drawRect
             withColor:(ColorType)color
           withShading:(ShadeType)shading
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, drawRect);
    
    int alphaValue = 0.0;
    if (shading == kStriped) {
        alphaValue = 0.3;
    } else if (shading == kSolid) {
        alphaValue = 1.0;
    }
    
    if (color == kGreen) {
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, alphaValue);
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    } else if (color == kRed) {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, alphaValue);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    } else { // (color == kPurple)
        CGContextSetRGBFillColor(context, 1.0, 0.0, 1.0, alphaValue);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 1.0, 1.0);
    }
    
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath(context);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextFillPath(context);

    [self popContext];
    NSLog(@"Drawing oval");
}

#define SQUIGGLE_START_OFFSET (0.15)
#define SQUIGGLE_END_OFFSET (0.75)
#define SQUIGGLE_END_YOFFSET (0.25)

- (void)drawSquiggleinRect:(CGRect)drawRect
                 withColor:(ColorType)color
               withShading:(ShadeType)shading
{
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

    int alphaValue = 0.0;
    if (shading == kStriped) {
        alphaValue = 0.3;
    } else if (shading == kSolid) {
        alphaValue = 1.0;
    }
    
    if (color == kGreen) {
        [[UIColor greenColor] setStroke];
        [[[UIColor greenColor] colorWithAlphaComponent:alphaValue] setFill];
    } else if (color == kRed) {
        [[UIColor redColor] setStroke];
        [[[UIColor redColor] colorWithAlphaComponent:alphaValue] setFill];
    } else { // (color == kPurple)
        [[UIColor purpleColor] setStroke];
        [[[UIColor purpleColor] colorWithAlphaComponent:alphaValue] setFill];
    }
    
    [path stroke];
    [path fill];
#endif
    NSLog(@"Drawing squiggle");
}

#define RECT_HEIGHT (0.2)
#define RECT_WIDTH (0.8)

- (NSArray *)deriveDrawRectsFromNumber:(NumberType)number
{
    NSMutableArray *rects = [[NSMutableArray alloc] init];
    if (rects) {
        CGRect templateRect;
        templateRect.origin.y = 0;
        templateRect.origin.x = self.bounds.size.width * (1.0 - RECT_WIDTH)/2;
        templateRect.size.height = self.bounds.size.height * RECT_HEIGHT;
        templateRect.size.width = self.bounds.size.width * RECT_WIDTH;
        if (number == kOne) {
            CGRect drawRect = templateRect;
            //drawRect.origin.y = self.bounds.size.height/2 - self.bounds.size.height * RECT_HEIGHT/2;
            drawRect.origin.y = self.bounds.size.height * RECT_HEIGHT * 2.0;
            [rects addObject:[NSValue valueWithCGRect:drawRect]];

        } else if (number == kTwo) {
            CGRect drawRect = templateRect;
            drawRect.origin.y = self.bounds.size.height * RECT_HEIGHT;
            [rects addObject:[NSValue valueWithCGRect:drawRect]];
            
            CGRect drawRect2 = templateRect;
            drawRect2.origin.y = self.bounds.size.height * RECT_HEIGHT * 3.0;
            [rects addObject:[NSValue valueWithCGRect:drawRect2]];

        } else { // (number == kThree)
            CGRect drawRect = templateRect;
            drawRect.origin.y = self.bounds.size.height * RECT_HEIGHT * 0.5;
            [rects addObject:[NSValue valueWithCGRect:drawRect]];
            
            CGRect drawRect2 = templateRect;
            drawRect2.origin.y = self.bounds.size.height * RECT_HEIGHT * 2.0;
            [rects addObject:[NSValue valueWithCGRect:drawRect2]];
            
            CGRect drawRect3 = templateRect;
            drawRect3.origin.y = self.bounds.size.height * RECT_HEIGHT * 3.5;
            [rects addObject:[NSValue valueWithCGRect:drawRect3]];
        }
    }
    return rects;
}

- (void) drawSymbol:(SymbolType)symbol
         withNumber:(NumberType)number
          withColor:(ColorType)color
        withShading:(ShadeType)shading
{
    NSArray *drawRects = [self deriveDrawRectsFromNumber:number];
    for (NSValue *rect in drawRects) {
        switch (self.symbol) {
            case kDiamond:
                [self drawDiamondinRect:[rect CGRectValue] withColor:color withShading:shading];
                break;
            case kSquiggle:
                [self drawSquiggleinRect:[rect CGRectValue] withColor:color withShading:shading];
                break;
            case kOval:
                [self drawOvalinRect:[rect CGRectValue] withColor:color withShading:shading];
                break;
        }
    }
}

#define CORNER_RADIUS (12.0)

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [self drawSymbol:self.symbol withNumber:self.number withColor:self.color withShading:self.shading];
    
}


@end
