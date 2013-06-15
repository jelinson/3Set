//
//  TSCardCellView.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSCardCellView.h"

@implementation TSCardCellView

@synthesize cardLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setCard:(TSCardModel *)card
{
    self.card = card;
    [cardLabel setText:[card toString]];
}

-(TSCardModel*)card
{
    return self.card;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
