//
//  SetCardView.h
//  SuperCard
//
//  Created by Derek Taylor on 9/24/13.
//  Copyright (c) 2013 Derek Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SetCardView : UIView

@property (nonatomic) ShadeType shading;
@property (nonatomic) ColorType color;
@property (nonatomic) SymbolType symbol;
@property (nonatomic) NumberType number;

// designated initializer
- (id)initWithNumber:(NumberType) number
              symbol:(SymbolType) symbol
               shade:(ShadeType) shading
               color:(ColorType) color;
@end
