//
//  ViewController_Home.m
//  PH Map
//
//  Created by Reggie Cabalo on 3/19/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import "ViewController_Home.h"
#import "OtherAppsViewController.h"
#import "ModeViewController.h"

NSString *str_mode;

int nPlayedIntroMusic = 0;

@interface ViewController_Home ()

@end

@implementation ViewController_Home

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
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    if (nPlayedIntroMusic == 0){
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/PH Map main screen.mp3",[[NSBundle mainBundle] resourcePath]]];
        
        NSError *error;
        background_main = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
        [background_main  setVolume:0.8];
    
        background_main.numberOfLoops = 0;
        [background_main play];
    }
    
    nPlayedIntroMusic = 1;
}

-(IBAction)btn_learn:(id)sender
{
    
    str_mode = @"Learn";
    AudioServicesPlaySystemSound (1022);
    
}

-(IBAction)btn_play:(id)sender
{
    
    str_mode = @"Play";
    AudioServicesPlaySystemSound (1022);
    
}
    
-(IBAction)btn_otherApps:(id)sender
{
    
    [sender setImage:[UIImage imageNamed:@"Learn Ilonggo, TAP TO SEE.png"] forState:UIControlStateHighlighted];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
