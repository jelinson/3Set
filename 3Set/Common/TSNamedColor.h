//
//  TSNamedColor.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSNamedColor : NSObject

@property (strong, readwrite) NSString* name;
@property (strong, readwrite) UIColor* color;

+(id) colorWithRed:(double)red Green:(double)green Blue:(double)blue Named:(NSString*) name;

@end
