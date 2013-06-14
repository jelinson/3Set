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
            _attributes[i] = [[values objectAtIndex:i] intValue];
        }
    } else {
        NSLog(@"ERROR: Could not initialize CardModel");
    }
    return self;
}

-(TSAttributeValue)getValueOfAttribute:(TSAttributeType)type
{
    return _attributes[type];
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
