//
//  OtherAppsViewController.m
//  PH Map
//
//  Created by Reggie Cabalo on 4/1/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import "OtherAppsViewController.h"

@interface OtherAppsViewController ()

@end

@implementation OtherAppsViewController

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
    
    self.defintionOfOtherApp_1.text = @"Teach your child Ilonggo and Tagalog";
    self.defintionOfOtherApp_2.text = @"with Inting and Butud!";
    self.defintionOfOtherApp_3.text = @"Meet Butud, a young carabao, who gets the saddest news of his life when his best friend, a farm boy named Inting, tells him why they can't spend";
    
    self.defintionOfOtherApp_4.text = @"every day together anymore: Inting is finally \n going to school!";
    
    self.defintionOfOtherApp_5.text = @"Read through the story and practice as the words gradually turn from English to Ilonggo or Tagalog. With its warm illustrations and audio narration, INTING & BUTUD makes learning fun \n for your child with your iPad!";

    
//    [[UIApplication sharedApplication] openURL:esturyaLinkWebsite];
    
    self.defintionOfOtherApp_6.text = @"Visit us on the                       for more info!";
    

    
    
    
}

-(IBAction)btn_linkEsturyaWebsite:(id)sender
{
    NSString *esturyaWebsite = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/artist/esturya-for-kids/id778439480"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:esturyaWebsite]];
}
    
-(IBAction)btn_link:(id)sender
{
    
    NSString *url = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/app/learn-ilonggo-inting-butud/id778439477?mt=8"];
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
}

-(IBAction)btn_linkTagalog:(id)sender
{
    NSString *url = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/app/learn-tagalog-inting-butud/id871663684?mt=8"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}
    
-(IBAction)btn_backHomePage:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
