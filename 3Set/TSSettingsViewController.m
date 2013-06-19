//
//  TSSettingsViewController.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSSettingsViewController.h"
#import "TSSettingManager.h"

@interface TSSettingsViewController ()

@end

@implementation TSSettingsViewController

@synthesize numberOfCardsSelector, backgroundColorLabel, hideFrameSwitch;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TSSettingManager* sm = [TSSettingManager getSettingManagerInstance];
    
    int numberOfCards = [sm numberOfCards];
    switch (numberOfCards) {
        case 9:
            [numberOfCardsSelector setSelectedSegmentIndex:0];
            break;
        case 12:
            [numberOfCardsSelector setSelectedSegmentIndex:1];
            break;
        case 15:
            [numberOfCardsSelector setSelectedSegmentIndex:2];
            break;
        default:
            NSLog(@"WARNING: Corrupted setting");
    }
    
    bool hideFrame = [sm hideFrameDuringPlay];
    [hideFrameSwitch setOn:hideFrame];
}

- (IBAction)numberOfCardsValueChanged:(id)sender {
    int index = [numberOfCardsSelector selectedSegmentIndex];
    int numberOfCards;
    
    switch (index) {
        case 0:
            numberOfCards = 9;
            break;
        case 1:
            numberOfCards = 12;
            break;
        case 2:
            numberOfCards = 15;
            break;
    }
    
    [[TSSettingManager getSettingManagerInstance] updateNumberOfCards:numberOfCards];
}

- (IBAction)hideFrameValueChanged:(id)sender {
    BOOL hideFrame = [hideFrameSwitch isOn];
    [[TSSettingManager getSettingManagerInstance] updateHideFrameDuringPlay:hideFrame];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
