//
//  TSCardModel.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TSFirstAttributeValue = 1,
    TSSecondAttributeValue = 2,
    TSThirdAttributeValue = 4
} TSAttributeValue;

const int TSN_ATTRIBUTE_VALUES = 3;
const int TSALL_DIFFERENT_MASK = 0b111;

typedef enum {
    TSColorAttribute = 0,
    TSShadeAttribute = 1,
    TSNumberAttribute = 2
} TSAttributeType;

const int TSN_ATTRIBUTE_TYPES = 3;


@interface TSCardModel : NSObject {
    TSAttributeValue attributes[TSN_ATTRIBUTE_TYPES];
}

-(id) initWithValues:(NSArray*) values;
-(TSAttributeValue) getValueOfAttribute:(TSAttributeType) type;

@end
