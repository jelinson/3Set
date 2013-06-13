//
//  TSCardModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSCardModel.h"

@implementation TSCardModel

-(id)initWithValues:(NSArray *)values
{
    self = [super init];
    if (self) {
        int count = [values count];
        assert(count == TSN_ATTRIBUTE_TYPES);
        for (int i = 0; i < count; ++i) {
            attributes[i] = (TSAttributeValue) [values objectAtIndex:i];
        }
    } else {
        NSLog(@"ERROR: Could not initialize CardModel");
    }
    return self;
}

-(TSAttributeValue)getValueOfAttribute:(TSAttributeType)type
{
    return attributes[type];
}

@end
