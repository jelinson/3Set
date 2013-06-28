//
//  TSUtil.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.18..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSUtil.h"

const char* TSIMG_FILE_EXT = ".png";

@implementation TSUtil

+(NSString*) formatTimeFromSeconds:(int)totalSeconds
{
    if (totalSeconds == INFINITY)
        return @"N/A";
    
    int minutes = totalSeconds / 60;
    int seconds = totalSeconds % 60;
    return [NSString stringWithFormat:@"%i:%02d", minutes, seconds];
}

@end
