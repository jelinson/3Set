//
//  TSAttributeModel.h
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

typedef enum {
    TSColorAttribute = 0,
    TSShadeAttribute = 1,
    TSNumberAttribute = 2
} TSAttributeType;

const int TSN_ATTRIBUTES = 3;

@interface TSAttributeModel : NSObject

@property (atomic, assign) TSAttributeType type;
@property (atomic, assign) TSAttributeValue value;

@end
