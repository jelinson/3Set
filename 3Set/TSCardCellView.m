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
@synthesize card = _card;
@synthesize imgSrc, imgPath, imgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)assignCard:(TSCardModel *)card
{
    _card = card;
    [cardLabel setHidden:YES];
    //[cardLabel setText:[self.card toString]];

    imgPath = @"green_diamond_por.png";
    imgSrc = [UIImage imageNamed:imgPath];
    [imgView setImage:imgSrc];

    
    //[imgView setFrame: [self frame]];
    //imgView.contentMode = UIViewContentModeScaleToFill;
}

@end
