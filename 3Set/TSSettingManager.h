//
//  TSSettingManager.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSNamedColor.h"

@interface TSSettingManager : NSObject

@property (assign, readonly) int numberOfCards;
@property (assign, readonly) BOOL hideFrameDuringPlay;
@property (strong, readonly) UIColor* backgroundColor;
@property (strong, readonly) NSString* colorName;

-(id) init;
-(void) updateNumberOfCards:(int) newPerference;
-(void) updateHideFrameDuringPlay:(BOOL) newPerference;
-(void) updateBackgroundColor:(TSNamedColor*) newPerference;

+(id) getSettingManagerInstance;
+(void) registerAppDefaults;

@end
