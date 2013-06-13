//
//  TSSolvedSetDescriptor.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TSSolvedSetNoDifferent = 0,
    TSSolvedSetOneDifferent = 1,
    TSSolvedSetTwoDifferent = 2,
    TSSolvedSetAllDifferent = 3
} TSSolvedSetDescription;

@interface TSSolvedSetDescriptor : NSObject

+(NSString*)generateSolvedSetDescription:(TSSolvedSetDescription) description;

@end
