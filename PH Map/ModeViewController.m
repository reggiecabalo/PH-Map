//
//  ModeViewController.m
//  PH Map
//
//  Created by Reggie Cabalo on 5/12/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import "ModeViewController.h"
#import "ViewController_Home.h"
#import "ViewController.h"


NSString *str_placeType;
NSString *final;


@interface ModeViewController ()

@end


static NSString *returned_typePlace = @"";

@implementation ModeViewController

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
    
    if([str_mode isEqualToString:@"Learn"])
    {

        [self Learn];
    }
    else if ([str_mode isEqualToString:@"Play"]){
        
        [self Play];
    }
    
    
    //NSLog(@"%@", str_placeType);
}

-(void)Learn{
    
    
        NSString *str_btn_image1 = [[NSString alloc] initWithFormat:@"KNOW YOUR PROVINCES, Color.png"];
        
        [self.btn1 setImage:[UIImage imageNamed:[NSString stringWithString:str_btn_image1]] forState:UIControlStateNormal];
        
        [self.btn1 setFrame:CGRectMake(144, 89, 305, 284)];
    

        NSString *str_btn_image2 = [[NSString alloc] initWithFormat:@"KNOW YOUR CAPITALS, Color.png"];
        
        [self.btn2 setImage:[UIImage imageNamed:[NSString stringWithString:str_btn_image2]] forState:UIControlStateNormal];
    
        [self.btn2 setFrame:CGRectMake(144, 321, 345, 206)];
    
}

-(void)Play{
    
    NSString *str_btn_image1 = [[NSString alloc] initWithFormat:@"GUESS THE PROVINCES, Color.png"];
    
    [self.btn1 setImage:[UIImage imageNamed:[NSString stringWithString:str_btn_image1]] forState:UIControlStateNormal];
    
    [self.btn1 setFrame:CGRectMake(144, 89, 305, 284)];
    
    
    NSString *str_btn_image2 = [[NSString alloc] initWithFormat:@"GUESS THE CAPITALS, Color.png"];
    
    [self.btn2 setImage:[UIImage imageNamed:[NSString stringWithString:str_btn_image2]] forState:UIControlStateNormal];
    
    [self.btn2 setFrame:CGRectMake(144, 321, 345, 206)];
}

-(IBAction)province:(id)sender
{
    str_placeType = @"Province";
    
}

-(IBAction)capital:(id)sender
{
    str_placeType = @"Capital";
        
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
