//
//  TSSetModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSSetModel.h"

@implementation TSSetModel

@synthesize isValid;

-(void)addCard:(TSCardModel *)card
{
    if (![self isFull]) {
        cards[count] = card;
        ++count;
        
        if ([self isFull]) {
            [self validate];
        }
    } else {
        NSLog(@"WARNING: Adding to a full set");
    }
}

-(bool)isFull
{
    return count == TSSET_SIZE;
}

-(void)validate
{
    for (int i = 0; i < TSN_ATTRIBUTE_TYPES; ++i) {
        int same = ~0;
        int diff = 0;
        for (int j = 0; j <TSSET_SIZE; ++j) {
            same &= [cards[j] getValueOfAttribute:i];
            diff |= [cards[j] getValueOfAttribute:i];
        }
        
        if (diff != TSALL_DIFFERENT_MASK && !same) {
            isValid = false;
            return;
        }
    }
    isValid = true;
}

@end
