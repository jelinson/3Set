//
//  TSPlayerStatsViewController.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSPlayerStatsViewController.h"

@interface TSPlayerStatsViewController ()

@end

@implementation TSPlayerStatsViewController

@synthesize setsFoundDetailLabel, falseAlarmsDetailLabel, scoreDetailLabel;
@synthesize allDifferentDetailLabel, threeDifferentDetailLabel, twoDifferentDetailLabel, oneDifferentDetailLabel, noDifferentDetailLabel;

@synthesize avgTimeDetailLabel, fastestDetailLabel, slowestDetailLabel;// typeLabelsArray;
@synthesize playerStats;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"PlayerStats viewDidLoad");
//    typeLabelsArray = [[NSMutableArray alloc] init];
//    [typeLabelsArray addObject:noDifferentSetCountDetailLabel];
//    [typeLabelsArray addObject:oneDifferentSetCountDetailLabel];
//    [typeLabelsArray addObject:twoDifferentSetCountDetailLabel];
//    [typeLabelsArray addObject:threeDiferentSetCountDetailLabel];
//    [typeLabelsArray addObject:allDifferentSetCountDetailLabel];
//    
//    NSLog([NSString stringWithFormat:@"Size of typeLabelsArray after creation %d", [typeLabelsArray count]]);
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadStats];
    [self fillInStats];
}

-(void)loadStats
{
    playerStats = [[[TSGameModel getGameInstanceForPlayers:1 andClear:NO] gameStats] playerStats][0]; //TODO hardcoded
}

-(void)fillInStats
{
    [self fillInLabel:setsFoundDetailLabel withInt:[playerStats setsFound]];
    [self fillInLabel:falseAlarmsDetailLabel withInt:[playerStats falseAlarms]];
    [self fillInLabel:scoreDetailLabel withInt:[playerStats computeScore]];
    [self fillInLabel:avgTimeDetailLabel withDoubleTime:[playerStats computeTime]];
    [self fillInLabel:fastestDetailLabel withDoubleTime:[playerStats fastestTime]];
    [self fillInLabel:slowestDetailLabel withDoubleTime:[playerStats slowestTime]];
    
//    for (TSSolvedSetDescription type = TSSolvedSetNoDifferent;
//         type <= TSSolvedSetAllDifferent; ++type) {
//        NSLog([NSString stringWithFormat:@"Size of typeLabelsArray when using %d", [typeLabelsArray count]]);
//        [self fillInLabel:[typeLabelsArray objectAtIndex:(int)type] withTime:[playerStats countForType:type]];
//    }
    
    [self fillInLabel:noDifferentDetailLabel withInt:[playerStats countForType:TSSolvedSetNoDifferent]];
    [self fillInLabel:oneDifferentDetailLabel withInt:[playerStats countForType:TSSolvedSetOneDifferent]];
    [self fillInLabel:twoDifferentDetailLabel withInt:[playerStats countForType:TSSolvedSetTwoDifferent]];
    [self fillInLabel:threeDifferentDetailLabel withInt:[playerStats countForType:TSSolvedSetThreeDifferent]];
    [self fillInLabel:allDifferentDetailLabel withInt:[playerStats countForType:TSSolvedSetAllDifferent]];
}

-(void) fillInLabel:(UILabel*)label withInt:(int)value
{
    [label setText:[NSString stringWithFormat:@"%d", value]];
}

-(void) fillInLabel:(UILabel*)label withTime:(int)seconds
{
    [label setText:[TSUtil formatTimeFromSeconds:seconds]];
}

-(void) fillInLabel:(UILabel*)label withDoubleTime:(double) seconds
{
    if (isnan(seconds) || seconds == INFINITY || seconds == 0) {
        [label setText:@"N/A"];
    } else {
        [self fillInLabel:label withTime: (int) seconds];
    }
}

- (IBAction)onDoneClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
