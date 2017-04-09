//
//  StatusViewController.m
//  PH Map
//
//  Created by Reggie Cabalo on 5/16/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import "StatusViewController.h"
#import "pop-overController.h"
#import "ViewController.h"

@interface StatusViewController ()

@end

@implementation StatusViewController

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
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CHECK MARK.png"]];
    
    [image setFrame:CGRectMake(100, 0, 100, 80)];
    
    [self.view addSubview:image];
    
    [self performSelector:@selector(dismissPopout) withObject:self afterDelay:2];
    
   // NSLog(@"%@", list_name2);
}

- (void)dismissPopout
{
    [self.statusPopOver dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
