//
//  TSCardCellView.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import "TSCardCellView.h"
#import "TSUtil.h"

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
    [self setAlpha:0.0];

    imgPath = [NSMutableString stringWithString: [card toString]];
    [imgPath appendString:[NSString stringWithUTF8String:TSIMG_FILE_EXT]];
    imgSrc = [UIImage imageNamed:imgPath];
    [imgView setOpaque:FALSE];
    [imgView setImage:imgSrc];
}

@end
