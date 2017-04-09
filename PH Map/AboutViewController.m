//
//  AboutViewController.m
//  PH Map
//
//  Created by Reggie Cabalo on 4/14/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.graphics.font = [UIFont fontWithName:@"Varela Round" size:20];
    self.nameOfDesigner.font = [UIFont fontWithName:@"Varela Round" size:20];
    self.nameOfDesigner.font = [UIFont boldSystemFontOfSize:20];
    
    self.softwareDesign_programming.font = [UIFont fontWithName:@"Varela Round" size:18];
    self.nameOfSoftwareDesigner.font = [UIFont fontWithName:@"Varela Round" size:20];
    self.nameOfSoftwareDesigner.font = [UIFont boldSystemFontOfSize:20];
    
    self.softwareProgramming.font = [UIFont fontWithName:@"Varela Round" size:20];
    self.nameOfSoftwareProgramer.font = [UIFont fontWithName:@"Varela Round" size:20];
    self.nameOfSoftwareProgramer.font = [UIFont boldSystemFontOfSize:20];

    self.graphics.text = @"Graphic Design";
    self.nameOfDesigner.text = @"Joy Marie Martir";
    
    self.softwareDesign_programming.text = @"Software Design/Programming";
    self.nameOfSoftwareDesigner.text = @"Robin Abello";

    self.softwareProgramming.text = @"Software Programming";
    self.nameOfSoftwareProgramer.text = @"Reggie Manuel Cabalo";
}

-(IBAction)btn_backHomePage_about:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
