//
//  TSUtil.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.18..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const char* TSIMG_FILE_EXT;

@interface TSUtil : NSObject

+(NSString*) formatTimeFromSeconds:(int)totalSeconds;

@end
