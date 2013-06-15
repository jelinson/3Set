//
//  TSSolvedSetDescriptor.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSSolvedSetDescriptor.h"

@implementation TSSolvedSetDescriptor

+(NSString*)generateSolvedSetDescription:(TSSolvedSetDescription)description
{
    switch (description) {
        case TSSolvedSetNoDifferent:
            return @"All attributes the same";
        case TSSolvedSetOneDifferent:
            return @"Three attributes the same, one different";
        case TSSolvedSetTwoDifferent:
            return @"Two attributes the same, two different";
        case TSSvoledSetThreeDifferent:
            return @"One attribute the same, three different";
        case TSSolvedSetAllDifferent:
            return @"All attrbiutes different";
    }
}

@end
