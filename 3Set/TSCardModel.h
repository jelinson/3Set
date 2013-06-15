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

extern const int TSN_ATTRIBUTE_VALUES;
extern const int TSALL_DIFFERENT_MASK;

typedef enum {
    TSColorAttribute = 0,
    TSShadeAttribute = 1,
    TSNumberAttribute = 2,
    TSShapeAttribute = 3
} TSAttributeType;

extern const int TSN_ATTRIBUTE_TYPES;

@interface TSCardModel : NSObject

@property (atomic, strong, readwrite) NSMutableArray* attributes;
    
-(id)initWithValues:(NSArray*) values;
-(TSAttributeValue)getValueOfAttribute:(TSAttributeType) type;
-(NSString*)toString;

+(NSArray*) possibleValues;

@end
