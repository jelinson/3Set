//
//  TSGeneralStatsViewController.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSGeneralStatsViewController.h"

@interface TSGeneralStatsViewController ()

@end

@implementation TSGeneralStatsViewController

@synthesize totalSetsFoundDetailLabel, cardsLeftDetailLabel, possibleSetsLeftDetailLabel, timeDetailLabel, player1ScoreDetailLabel;
@synthesize gameStats;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadStats];
    [self fillInStats];
}

-(void)loadStats
{
    // TODO dynamic number of players
    gameStats = [[TSGameModel getGameInstanceForPlayers:1 andClear:NO] gameStats];
}

-(void) fillInStats
{
    [totalSetsFoundDetailLabel setText:[NSString stringWithFormat:@"%d", [gameStats totalSetsFound]]];
    [cardsLeftDetailLabel setText:[NSString stringWithFormat:@"%d", [gameStats cardsLeft]]];
    [possibleSetsLeftDetailLabel setText:[NSString stringWithFormat:@"%d", ([gameStats cardsLeft] / TSSET_SIZE)]];
    [timeDetailLabel setText:[TSUtil formatTimeFromSeconds:[gameStats time]]];
    [player1ScoreDetailLabel setText:[NSString stringWithFormat:@"%d", [gameStats playerScore:0]]];
}

- (IBAction)onDoneClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//            return 4;
//        case 1:
//            return 1;
//        default:
//            return 0;
//    }
//}

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
