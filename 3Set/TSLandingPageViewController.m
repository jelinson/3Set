//
//  TSViewController.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSLandingPageViewController.h"
#import "TSSettingManager.h"

@interface TSLandingPageViewController ()

@end

@implementation TSLandingPageViewController


- (id) init
{
    self = [super init];
    if (self) {
        [self configureViewController];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureViewController];
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configureViewController];
    }
    return self;
}

- (void) configureViewController
{
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
//    barButton.title = @"Menu";
//    
//    self.navigationItem.backBarButtonItem = barButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController setToolbarHidden:YES animated:animated];
    self.view.backgroundColor = [[TSSettingManager getSettingManagerInstance] backgroundColor];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController setToolbarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
