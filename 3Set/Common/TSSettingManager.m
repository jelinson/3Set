//
//  TSSettingManager.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSSettingManager.h"

@implementation TSSettingManager

const int TSSettingManager_N_CARDS_DEFAULT = 12;
const BOOL TSSettingManager_HIDE_FRAME_DEFAULT = YES;
const double TSSettingManager_BGR_R_DEFAULT = 1.0;
const double TSSettingManager_BGR_G_DEFAULT = 0.996;
const double TSSettingManager_BGR_B_DEFAULT = 0.941;

@synthesize numberOfCards;
@synthesize hideFrameDuringPlay;
@synthesize backgroundColor;
@synthesize colorName;

-(id) init
{
    self = [super init];
    if (self) {
        [self loadSettings];
    } else {
        NSLog(@"ERROR: Could not initialize Setting Manager");
    }
    return self;
}

-(void) loadSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    numberOfCards = [defaults integerForKey:@"NumberOfCards"];
    hideFrameDuringPlay = [defaults boolForKey:@"HideFrameDuringPlay"];
    double backgroundR = [defaults doubleForKey:@"BackgroundRed"];
    double backgroundG = [defaults doubleForKey:@"BackgroundGreen"];
    double backgroundB = [defaults doubleForKey:@"BackgroundBlue"];
    colorName = [defaults stringForKey:@"ColorName"];
    backgroundColor = [UIColor colorWithRed:backgroundR green:backgroundG blue:backgroundB alpha:1.0];

}

-(void) updateNumberOfCards:(int) newPreference
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    numberOfCards = newPreference;
    NSNumber* preferenceWrapper = [NSNumber numberWithInt:newPreference];
    [defaults setValue:preferenceWrapper forKey:@"NumberOfCards"];
    
}
-(void) updateHideFrameDuringPlay:(BOOL) newPreference
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    hideFrameDuringPlay = newPreference;
    NSNumber* preferenceWrapper = [NSNumber numberWithBool:newPreference];
    [defaults setValue:preferenceWrapper forKey:@"HideFrameDuringPlay"];
}

-(void) updateBackgroundColor:(TSNamedColor *)newPreference
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    backgroundColor = [newPreference color];
    colorName = [newPreference name];
    
    CGFloat backgroundR, backgroundB, backgroundG, alpha;
    [[newPreference color] getRed:&backgroundR green:&backgroundG blue:&backgroundB alpha:&alpha];
    
    [defaults setValue:[NSNumber numberWithDouble:backgroundR] forKey:@"BackgroundRed"];
    [defaults setValue:[NSNumber numberWithDouble:backgroundG] forKey:@"BackgroundGreen"];
    [defaults setValue:[NSNumber numberWithDouble:backgroundB] forKey:@"BackgroundBlue"];
    [defaults setValue:colorName forKey:@"ColorName"];
}

+(id) getSettingManagerInstance
{
    static TSSettingManager* instance = nil;
    if (instance == nil) {
        instance = [[TSSettingManager alloc] init];
    }
    
    return instance;
}

+(void) registerAppDefaults
{
    NSMutableDictionary *appDefaults = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithBool:TSSettingManager_HIDE_FRAME_DEFAULT] forKey:@"HideFrameDuringPlay"];
    [appDefaults setObject:[NSNumber numberWithInt:TSSettingManager_N_CARDS_DEFAULT] forKey:@"NumberOfCards"];
    [appDefaults setObject:[NSNumber numberWithDouble:TSSettingManager_BGR_R_DEFAULT] forKey:@"BackgroundRed"];
    [appDefaults setObject:[NSNumber numberWithDouble:TSSettingManager_BGR_G_DEFAULT] forKey:@"BackgroundGreen"];
    [appDefaults setObject:[NSNumber numberWithDouble:TSSettingManager_BGR_B_DEFAULT] forKey:@"BackgroundBlue"];
    [appDefaults setObject:@"Biege" forKey:@"ColorName"];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
}

@end
