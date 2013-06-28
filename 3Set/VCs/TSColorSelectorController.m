//
//  TSColorSelectorController.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSColorSelectorController.h"
#import "TSNamedColor.h"
#import "TSSettingManager.h"

@interface TSColorSelectorController ()

@end

@implementation TSColorSelectorController

@synthesize selectedRow;
@synthesize colorSelection;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self buildColorSelection];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self buildColorSelection];
    }
    return self;
}

-(void)buildColorSelection
{
    colorSelection = [NSMutableArray arrayWithCapacity:3];
    [colorSelection addObject:[TSNamedColor colorWithRed:1.0 Green:1.0 Blue:1.0 Named:@"White"]];
    [colorSelection addObject:[TSNamedColor colorWithRed:1.0 Green:0.996 Blue:0.94 Named:@"Biege"]];
    [colorSelection addObject:[TSNamedColor colorWithRed:0.0 Green:0.0 Blue:0.0 Named:@"Black"]];
}

-(void) viewWillAppear:(BOOL)animated
{
    NSString* colorName = [[TSSettingManager getSettingManagerInstance] colorName];
    for (int i = 0; i < [colorSelection count]; ++i) {
        if ([[[colorSelection objectAtIndex:i] name] isEqualToString:colorName])
            selectedRow = i;
    }
    
    [super viewWillAppear:animated];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = [indexPath row];
    
    TSNamedColor* newPreference = [colorSelection objectAtIndex:selectedRow];
    [[TSSettingManager getSettingManagerInstance] updateBackgroundColor:newPreference];
    
    [tableView reloadData];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([indexPath row] == selectedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

@end
