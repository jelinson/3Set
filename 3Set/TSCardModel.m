//
//  TSCardModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSCardModel.h"

const int TSN_ATTRIBUTE_VALUES = 3;
const int TSN_ATTRIBUTE_TYPES = 3;
const int TSALL_DIFFERENT_MASK = 0b111;

@implementation TSCardModel

@synthesize attributes = _attributes;

-(id)initWithValues:(NSArray *)values
{
    self = [super init];
    if (self) {
        int count = [values count];
        assert(count == TSN_ATTRIBUTE_TYPES);
        _attributes = [NSMutableArray arrayWithCapacity:TSN_ATTRIBUTE_TYPES];
        for (int i = 0; i < count; ++i) {
            _attributes[i] = [values objectAtIndex:i];
        }
    } else {
        NSLog(@"ERROR: Could not initialize CardModel");
    }
    return self;
}

-(TSAttributeValue)getValueOfAttribute:(TSAttributeType)type
{
    return [_attributes[type] intValue];
}

+(NSArray*) possibleValues
{
    NSMutableArray* values = [NSMutableArray arrayWithCapacity:TSN_ATTRIBUTE_VALUES];
    [values addObject:[NSNumber  numberWithInt:TSFirstAttributeValue]];
    [values addObject:[NSNumber  numberWithInt:TSSecondAttributeValue]];
    [values addObject:[NSNumber  numberWithInt:TSThirdAttributeValue]];
    
    return values;
}

@end
