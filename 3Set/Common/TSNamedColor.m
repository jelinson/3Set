//
//  TSNamedColor.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSNamedColor.h"

@implementation TSNamedColor

@synthesize name, color;

+(id) colorWithRed:(double)red Green:(double)green Blue:(double)blue Named:(NSString*) name
{
    TSNamedColor* toCreate = [[TSNamedColor alloc] init];
    toCreate.color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    toCreate.name = name;
    
    return toCreate;
}

@end
