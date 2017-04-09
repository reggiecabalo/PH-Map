//
//  ViewController.m
//  PH Map
//
//  Created by Reggie Cabalo on 3/11/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import "ModeViewController.h"
#import "ViewController.h"
#import "pop-overController.h"
#import "ViewController_Home.h"
#import "OtherAppsViewController.h"
#import "StatusViewController.h"


NSInteger phMapGlobalCounter;
NSMutableArray *list_name;
NSMutableArray *list_name2;
UIButton *btn;
NSString *str_capital;
unsigned long totalProvinceCapital;
UILabel *label_score;
UILabel *label_slash;
UILabel *label_totalProvinceCapital;
UIImageView *progress;

CGPoint previousTouchPoint;
float phMapGlobalViewScale; //we use this for determining if the pinch-zoom has been activated (so we know to recognize the swipe gestures)

@interface ViewController ()

@end

@implementation ViewController

NSInteger phMapGlobalCounter = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    phMapGlobalViewScale = 1;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(twoFingerPinch:)];
    
    [[self view] addGestureRecognizer:twoFingerPinch];
    
    UISwipeGestureRecognizer *SwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    SwipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [[self view] addGestureRecognizer:SwipeUp];
    
    UISwipeGestureRecognizer *SwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    SwipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[self view] addGestureRecognizer:SwipeDown];
    
    UISwipeGestureRecognizer *SwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    SwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[self view] addGestureRecognizer:SwipeLeft];
    
    UISwipeGestureRecognizer *SwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    SwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[self view] addGestureRecognizer:SwipeRight];
    
    
    list_name = [[NSMutableArray alloc] init];
    
    list_name2 = [[NSMutableArray alloc] init];
    
    btn_object = [[NSMutableArray alloc] init];
    
    self.view.multipleTouchEnabled = YES;
    
    array_totalProvinceCapital = [[NSMutableArray alloc] init];
    
    for(UIButton *bt in self.view.subviews){
        
        if([[bt.class description] isEqualToString:@"OBShapedButton"])
        {
            [array_totalProvinceCapital addObject:bt];
            
            totalProvinceCapital = [array_totalProvinceCapital count];
        }
        
        
    }
    
    
    label_score = [[UILabel alloc] init];
    
    [label_score setFont:[UIFont fontWithName:@"Romeral" size:50]];
    
    [label_score setTextColor:[UIColor colorWithRed:0x65/255.0f green:0x58/255.0f blue:0x42/255.0f alpha:1]];
    
    [self.view addSubview:label_score];
    
    
    
    label_slash = [[UILabel alloc] initWithFrame:CGRectMake(647, 80, 150, 70)];
    
    [label_slash setFont:[UIFont fontWithName:@"Romeral" size:30]];
    
    [label_slash setTextColor:[UIColor colorWithRed:0x65/255.0f green:0x58/255.0f blue:0x42/255.0f alpha:1]];
    
    [self.view addSubview:label_slash];
    
    
    
    label_totalProvinceCapital = [[UILabel alloc] initWithFrame:CGRectMake(660, 85, 150, 70)];
    
    [label_totalProvinceCapital setFont:[UIFont fontWithName:@"Romeral" size:25]];
    
    [self.view addSubview:label_totalProvinceCapital];
    
    [label_totalProvinceCapital setTextColor:[UIColor colorWithRed:0x65/255.0f green:0x58/255.0f blue:0x42/255.0f alpha:1]];
    
    
    progress = [[UIImageView alloc] initWithFrame:CGRectMake(590, 169, 125, 50)];
    
    [self.view addSubview:progress];
    
    
    if([str_mode isEqualToString:@"Learn"])
    {
        self.scoreBoard.hidden = YES;
        self.place_icon.hidden = YES;
        progress.hidden = YES;
        label_score.hidden = YES;
        label_slash.hidden = YES;
        label_totalProvinceCapital.hidden = YES;
        
    }
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
    if([str_placeType isEqualToString:@"Province"]){
        
        label_place = [[UILabel alloc] initWithFrame:CGRectMake(620, 108, 150, 70)];
    }
    else{
        
        label_place = [[UILabel alloc] initWithFrame:CGRectMake(627, 108, 150, 70)];
    }
    
    
    [label_place setFont:[UIFont fontWithName:@"Romeral" size:15]];
    
    [label_place setTextColor:[UIColor colorWithRed:0x65/255.0f green:0x58/255.0f blue:0x42/255.0f alpha:1]];
    
    [label_place setText:[NSString stringWithFormat:@"%@", str_placeType]];
    
    [self.view addSubview:label_place];
    
    
    
    if([str_mode isEqualToString:@"Learn"])
    {
        label_place.hidden = YES;
    }
    
    NSString *str_icon_score = [[NSString alloc] init];
    
    if([str_placeType isEqualToString:@"Province"])
    {
        str_icon_score = @"Score - Province option 2.png";
        
        
    }
    else{
        
        str_icon_score = @"SCORE - Capital option 2.png";
        
    }
    
    [self.place_icon setImage:[UIImage imageNamed:[NSString stringWithString:str_icon_score]]];
    
    
    
}




-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(totalScore) withObject:self];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (phMapGlobalCounter < 0)
        phMapGlobalCounter = 0;
    if (phMapGlobalCounter == 0) {
        // Allow the popover segue
        phMapGlobalCounter++;
        return YES;
    }
    // Cancel the popover segue
    //NSLog(@"cancelling segue Global Counter %d", phMapGlobalCounter);
    phMapGlobalCounter--;
    return NO;
    
    // Allow all other segues
    return YES;
}



-(void)totalScore
{
    
    str_total = [[NSString alloc] initWithFormat:@"%i", accumulatedScore];
    
    if(accumulatedScore < 10){
        [label_score setFrame:CGRectMake(620, 65, 150, 70)];
    }
    else if(accumulatedScore == 11)
    {
        [label_score setFrame:CGRectMake(610, 65, 150, 70)];
    }
    else if ((accumulatedScore == 21) || (accumulatedScore == 31) || (accumulatedScore == 41) || (accumulatedScore == 51) || (accumulatedScore == 61) || (accumulatedScore == 71) || (accumulatedScore == 81))
    {
        [label_score setFrame:CGRectMake(603, 65, 150, 70)];
    }
    else if ((accumulatedScore > 9) && (accumulatedScore < 20))
    {
        [label_score setFrame:CGRectMake(605, 65, 150, 70)];
    }
    else if (accumulatedScore > 19)
    {
        [label_score setFrame:CGRectMake(595, 65, 150, 70)];
    }
    
    
    [label_score setText:[NSString stringWithFormat:@"%@", str_total]];
    
    [label_slash setText:@"/"];
    
    [label_totalProvinceCapital setText:[NSString stringWithFormat:@"%lu", totalProvinceCapital]];
    
    if((accumulatedScore == 0) && (accumulatedScore < 5)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 0.png"]];
        
    }
    else if((accumulatedScore >= 5) && (accumulatedScore < 16)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 1.png"]];
        
    }
    else if((accumulatedScore > 15) && (accumulatedScore < 24)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 2.png"]];
    }
    else if((accumulatedScore > 23) && (accumulatedScore < 32)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 3.png"]];
    }
    else if((accumulatedScore > 31) && (accumulatedScore < 40)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 4.png"]];
    }
    else if((accumulatedScore > 39) && (accumulatedScore < 48)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 5.png"]];
    }
    else if((accumulatedScore > 47) && (accumulatedScore < 56)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 6.png"]];
    }
    else if((accumulatedScore > 55) && (accumulatedScore < 64)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 7.png"]];
    }
    else if((accumulatedScore > 63)){
        
        [progress setImage:[UIImage imageNamed:@"STARS - 4.png"]];
    }
    
    
    
    
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    
    return NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    btn = (UIButton *)sender;
    
    pop_overController *dest = [segue destinationViewController];
    
    name = segue.identifier;
    
    
    
    [btn_object addObject:btn];
    
    [list_name addObject:name];
    
    
    if([str_placeType isEqualToString:@"Province"]){
        
        
        dest.nameOfPlaceCalled = segue.identifier;
        
       
        
       dest.provincePopover = [(UIStoryboardPopoverSegue *)segue popoverController];
        
        
        if([str_mode isEqualToString:@"Learn"]){
            NSString *str_image_title = [[NSString alloc] initWithFormat:@"TOUCHED_%@.png", btn.currentTitle];
            
            if([btn.currentTitle isEqualToString:[[NSString alloc]initWithFormat:@"%@", dest.nameOfPlaceCalled]]){
                
                btn.selected = YES;
                
                
                [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title]] forState:UIControlStateSelected];
                
                
                [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
                
                
            }
        }
    }
    else{
        
        
        str_capital = btn.currentTitle;
        
        dest.nameOfProvinceCalled = btn.currentTitle;
        
        //REGGIE20MAR2014 - sets the labels text of the pop over into the capital names with the province name
        
        if([str_capital isEqualToString:@"Ilocos Norte"])
        {
            dest.nameOfPlaceCalled = @"Laoag City";
            
        }
        else if ([str_capital isEqualToString:@"Ilocos Sur"])
        {
            dest.nameOfPlaceCalled = @"Vigan City";
            
        }
        else if ([str_capital isEqualToString:@"La Union"])
        {
            dest.nameOfPlaceCalled = @"San Fernando City";
            
            
        }
        else if ([str_capital isEqualToString:@"Pangasinan"])
        {
            dest.nameOfPlaceCalled = @"Lingayen";
            
            
        }
        else if ([str_capital isEqualToString:@"Batanes"])
        {
            dest.nameOfPlaceCalled = @"Basco";
            
            
        }
        else if ([str_capital isEqualToString:@"Cagayan"])
        {
            dest.nameOfPlaceCalled = @"Tuguegarao City";
            
            
        }
        else if ([str_capital isEqualToString:@"Isabela"])
        {
            dest.nameOfPlaceCalled = @"Iligan";
            
            
        }
        else if ([str_capital isEqualToString:@"Nueva Vizcaya"])
        {
            dest.nameOfPlaceCalled = @"Bayombong";
            
            
        }
        else if ([str_capital isEqualToString:@"Quirino"])
        {
            dest.nameOfPlaceCalled = @"Cabarroguis";
            
            
        }
        else if ([str_capital isEqualToString:@"Aurora"])
        {
            dest.nameOfPlaceCalled = @"Baler";
            
            
        }
        else if ([str_capital isEqualToString:@"Bataan"])
        {
            dest.nameOfPlaceCalled = @"Balanga City";
            
            
        }
        else if ([str_capital isEqualToString:@"Bulacan"])
        {
            dest.nameOfPlaceCalled = @"Malolos City";
            
            
        }
        else if ([str_capital isEqualToString:@"Pampanga"])
        {
            dest.nameOfPlaceCalled = @"San Fernando City";
            
            
        }
        else if ([str_capital isEqualToString:@"Nueva Ecija"])
        {
            dest.nameOfPlaceCalled = @"Palayan City";
            
            
        }
        else if ([str_capital isEqualToString:@"Tarlac"])
        {
            dest.nameOfPlaceCalled = @"Tarlac City";
            
            
        }
        else if ([str_capital isEqualToString:@"Zambales"])
        {
            dest.nameOfPlaceCalled = @"Iba";
            
            
        }
        else if ([str_capital isEqualToString:@"Batangas"])
        {
            dest.nameOfPlaceCalled = @"Batangas City";
            
            
        }
        else if ([str_capital isEqualToString:@"Cavite"])
        {
            dest.nameOfPlaceCalled = @"Trece Martirez City";
            
            
        }
        else if ([str_capital isEqualToString:@"Laguna"])
        {
            dest.nameOfPlaceCalled = @"Santa Cruz";
            
            
        }
        else if ([str_capital isEqualToString:@"Quezon"])
        {
            dest.nameOfPlaceCalled = @"Lucena City";
            
            
        }
        else if ([str_capital isEqualToString:@"Rizal"])
        {
            dest.nameOfPlaceCalled = @"Antipolo City";
            
            
        }
        else if ([str_capital isEqualToString:@"Marinduque"])
        {
            dest.nameOfPlaceCalled = @"Boac";
            
            
        }
        else if ([str_capital isEqualToString:@"Occidental Mindoro"])
        {
            dest.nameOfPlaceCalled = @"Mamburao";
            
            
        }
        else if ([str_capital isEqualToString:@"Oriental Mindoro"])
        {
            dest.nameOfPlaceCalled = @"Calapan City";
            
            
        }
        else if ([str_capital isEqualToString:@"Palawan"])
        {
            dest.nameOfPlaceCalled = @"Puerto Princesa City";
            
            
        }
        else if ([str_capital isEqualToString:@"Romblon"])
        {
            dest.nameOfPlaceCalled = @"Romblon";
            
            
        }
        else if ([str_capital isEqualToString:@"Albay"])
        {
            dest.nameOfPlaceCalled = @"Legazpi City";
            
            
        }
        else if ([str_capital isEqualToString:@"Camarines Norte"])
        {
            dest.nameOfPlaceCalled = @"Daet";
            
            
        }
        else if ([str_capital isEqualToString:@"Camarines Sur"])
        {
            dest.nameOfPlaceCalled = @"Pilli";
            
            
        }
        else if ([str_capital isEqualToString:@"Catanduanes"])
        {
            dest.nameOfPlaceCalled = @"Virac";
            
            
        }
        else if ([str_capital isEqualToString:@"Masbate"])
        {
            dest.nameOfPlaceCalled = @"Masbate City";
            
            
        }
        else if ([str_capital isEqualToString:@"Sorsogon"])
        {
            dest.nameOfPlaceCalled = @"Sorsogon City";
            
            
        }
        else if ([str_capital isEqualToString:@"Aklan"])
        {
            dest.nameOfPlaceCalled = @"Kalibo";
            
            
        }
        else if ([str_capital isEqualToString:@"Antique"])
        {
            dest.nameOfPlaceCalled = @"San Jose";
            
            
        }
        else if ([str_capital isEqualToString:@"Capiz"])
        {
            dest.nameOfPlaceCalled = @"Roxas City";
            
            
        }
        else if ([str_capital isEqualToString:@"Guimaras"])
        {
            dest.nameOfPlaceCalled = @"Jordan";
            
            
        }
        else if ([str_capital isEqualToString:@"Iloilo"])
        {
            dest.nameOfPlaceCalled = @"Iloilo City";
            
            
        }
        else if ([str_capital isEqualToString:@"Negros Occidental"])
        {
            dest.nameOfPlaceCalled = @"Bacolod City";
            
            
        }
        else if ([str_capital isEqualToString:@"Bohol"])
        {
            dest.nameOfPlaceCalled = @"Tagbilaran City";
            
            
        }
        else if ([str_capital isEqualToString:@"Cebu"])
        {
            dest.nameOfPlaceCalled = @"Cebu City";
            
            
        }
        else if ([str_capital isEqualToString:@"Negros Oriental"])
        {
            dest.nameOfPlaceCalled = @"Dumaguete City";
            
            
        }
        else if ([str_capital isEqualToString:@"Siquijor"])
        {
            dest.nameOfPlaceCalled = @"Siquijor";
            
            
        }
        else if ([str_capital isEqualToString:@"Biliran"])
        {
            dest.nameOfPlaceCalled = @"Naval";
            
            
        }
        else if ([str_capital isEqualToString:@"Eastern Samar"])
        {
            dest.nameOfPlaceCalled = @"Borongan City";
            
            
        }
        else if ([str_capital isEqualToString:@"Leyte"])
        {
            dest.nameOfPlaceCalled = @"Tacloban City";
            
            
        }
        else if ([str_capital isEqualToString:@"Northern Samar"])
        {
            dest.nameOfPlaceCalled = @"Catarman";
            
            
        }
        else if ([str_capital isEqualToString:@"Southern Leyte"])
        {
            dest.nameOfPlaceCalled = @"Maasin City";
            
            
        }
        else if ([str_capital isEqualToString:@"Samar"])
        {
            dest.nameOfPlaceCalled = @"Catbalogan City";
            
            
        }
        else if ([str_capital isEqualToString:@"Zamboanga Del Norte"])
        {
            dest.nameOfPlaceCalled = @"Dipolog City";
            
            
        }
        else if ([str_capital isEqualToString:@"Zamboanga Del Sur"])
        {
            dest.nameOfPlaceCalled = @"Pagadian City";
            
            
        }
        else if ([str_capital isEqualToString:@"Zamboanga Sibugay"])
        {
            dest.nameOfPlaceCalled = @"Ipil";
            
            
        }
        else if ([str_capital isEqualToString:@"Bukidnon"])
        {
            dest.nameOfPlaceCalled = @"Malaybalay City";
            
            
        }
        else if ([str_capital isEqualToString:@"Camiguin"])
        {
            dest.nameOfPlaceCalled = @"Mambajao";
            
            
        }
        else if ([str_capital isEqualToString:@"Lanao Del Norte"])
        {
            dest.nameOfPlaceCalled = @"Tubod";
            
            
        }
        else if ([str_capital isEqualToString:@"Misamis Occidental"])
        {
            dest.nameOfPlaceCalled = @"Oroquite City";
            
            
        }
        else if ([str_capital isEqualToString:@"Misamis Oriental"])
        {
            dest.nameOfPlaceCalled = @"Cagayan de Oro City";
            
            
        }
        else if ([str_capital isEqualToString:@"Compostela Valley"])
        {
            dest.nameOfPlaceCalled = @"Nabunturan";
            
            
        }
        else if ([str_capital isEqualToString:@"Davao Del Norte"])
        {
            dest.nameOfPlaceCalled = @"Tagum City";
            
            
        }
        
        else if ([str_capital isEqualToString:@"Davao Del Norte"])
        {
            dest.nameOfPlaceCalled = @"Tagum City";
            
            
        }
        else if ([str_capital isEqualToString:@"Davao Del Sur"])
        {
            dest.nameOfPlaceCalled = @"Digos City";
            
            
        }
        else if ([str_capital isEqualToString:@"Davao Oriental"])
        {
            dest.nameOfPlaceCalled = @"City of Mati";
            
            
        }
        else if ([str_capital isEqualToString:@"Cotabato"])
        {
            dest.nameOfPlaceCalled = @"Kidapawan City";
            
            
        }
        else if ([str_capital isEqualToString:@"Sarangani"])
        {
            dest.nameOfPlaceCalled = @"Alabel";
            
            
        }
        else if ([str_capital isEqualToString:@"South Cotabato"])
        {
            dest.nameOfPlaceCalled = @"Koronadal City";
            
            
        }
        else if ([str_capital isEqualToString:@"Sultan Kudarat"])
        {
            dest.nameOfPlaceCalled = @"Isulan";
            
            
        }
        else if ([str_capital isEqualToString:@"Agusan Del Norte"])
        {
            dest.nameOfPlaceCalled = @"Cabadbaran City";
            
            
        }
        else if ([str_capital isEqualToString:@"Agusan Del Sur"])
        {
            dest.nameOfPlaceCalled = @"Prosperidad";
            
            
        }
        else if ([str_capital isEqualToString:@"Dinagat Islands"])
        {
            dest.nameOfPlaceCalled = @"San Jose ";
            
            
        }
        else if ([str_capital isEqualToString:@"Surigao Del Norte"])
        {
            dest.nameOfPlaceCalled = @"Surigao City";
            
            
        }
        else if ([str_capital isEqualToString:@"Surigao Del Sur"])
        {
            dest.nameOfPlaceCalled = @"Tandag City";
            
            
        }
        else if ([str_capital isEqualToString:@"Basilan"])
        {
            dest.nameOfPlaceCalled = @"Isabela City";
            
            
        }
        else if ([str_capital isEqualToString:@"Lanao Del Sur"])
        {
            dest.nameOfPlaceCalled = @"Marawi City";
            
            
        }
        else if ([str_capital isEqualToString:@"Maguindanao"])
        {
            dest.nameOfPlaceCalled = @"Shariff Aguak (Maganoy)";
            
            
        }
        else if ([str_capital isEqualToString:@"Sulu"])
        {
            dest.nameOfPlaceCalled = @"Jolo";
            
            
        }
        else if ([str_capital isEqualToString:@"Tawi-tawi"])
        {
            dest.nameOfPlaceCalled = @"Panglima Sugala (Balimbing)";
            
            
        }
        else if ([str_capital isEqualToString:@"Abra"])
        {
            dest.nameOfPlaceCalled = @"Bengued";
            
            
        }
        else if ([str_capital isEqualToString:@"Apayao"])
        {
            dest.nameOfPlaceCalled = @"Kabugao";
            
            
        }
        else if ([str_capital isEqualToString:@"Benguet"])
        {
            dest.nameOfPlaceCalled = @"La Trinidad";
            
            
        }
        else if ([str_capital isEqualToString:@"Ifugao"])
        {
            dest.nameOfPlaceCalled = @"Lagawe";
            
            
        }
        else if ([str_capital isEqualToString:@"Kalinga"])
        {
            dest.nameOfPlaceCalled = @"Tabuk";
            
            
        }
        else if ([str_capital isEqualToString:@"Mt. Province"])
        {
            dest.nameOfPlaceCalled = @"Bontoc";
            
            
        }
        else if ([str_capital isEqualToString:@"National Capital Region"])
        {
            dest.nameOfPlaceCalled = @"Manila";
            
            
        }
        else if ([str_capital isEqualToString:@"Zamboanga City"])
        {
            dest.nameOfPlaceCalled = @"Zamboanga City";
            
        }
        else if ([str_capital isEqualToString:@"Zamboanga City"])
        {
            dest.nameOfPlaceCalled = @"Zamboanga City";
            
        }
        else if ([str_capital isEqualToString:@"Davao Occidental"])
        {
            dest.nameOfPlaceCalled = @"Malita";
            
        }
        
        dest.provincePopover = [(UIStoryboardPopoverSegue *)segue popoverController];
        
        if([str_mode isEqualToString:@"Learn"]){
            NSString *str_image_title = [[NSString alloc] initWithFormat:@"TOUCHED CAPITAL %@.png", str_capital];
            
            if([btn.currentTitle isEqualToString:[[NSString alloc]initWithFormat:@"%@", btn.currentTitle]]){
                
                btn.selected = YES;
                
                [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title]] forState:UIControlStateSelected];
                
                
                [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
                
                
                
            }
            
           
        }
        
    }
    
    dest.provincePopover.delegate = self;
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    [dest.provincePopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
}

- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    
    if (phMapGlobalViewScale == 1)
        return;
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat max_width = CGRectGetWidth(screen);
    CGFloat max_height = CGRectGetHeight(screen);
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp){
        //NSLog(@" *** SWIPE UP *** %f %f", recognizer.view.center.y, max_height);
        if (recognizer.view.center.y <= 0)
            return;
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y - 200);
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        //NSLog(@" *** SWIPE DOWN *** %f", recognizer.view.center.y);
        if (recognizer.view.center.y >= max_height)
            return;
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + 200);
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        if (recognizer.view.center.x <= 0)
            return;
        recognizer.view.center = CGPointMake(recognizer.view.center.x - 200,
                                             recognizer.view.center.y);
    } else {
        if (recognizer.view.center.x >= max_width)
            return;
        recognizer.view.center = CGPointMake(recognizer.view.center.x + 200,
                                             recognizer.view.center.y);
    }
}


- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    phMapGlobalViewScale = recognizer.scale;
    
    if ([recognizer numberOfTouches] < 2)
        return;
    
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        previousTouchPoint = [recognizer locationInView:self.view];
    }
    
    //zoom in/out view based on scale
    if (recognizer.scale < 1){
        recognizer.scale = 1;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
    // you can implement any int/float value in context of what scale you want to zoom in or out
    self.view.transform = transform;
    
    //sets the center of view
    if([recognizer state] == UIGestureRecognizerStateChanged){
        CGPoint currentTouchPoint = [recognizer locationInView:self.view];
        CGPoint tCenter = self.view.center;
        tCenter.x -= (previousTouchPoint.x - currentTouchPoint.x);
        tCenter.y -= (previousTouchPoint.y - currentTouchPoint.y);
        if (recognizer.scale == 1){
            self.view.center = CGPointMake( self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
        } else {
            //self.view.center = tCenter;
        }
        
        self.view.clipsToBounds = YES;
    }
    previousTouchPoint = [recognizer locationInView:self.view];
}

-(IBAction)btn_back_home:(id)sender
{
    
    for(UIButton *sel_button in btn_object)
    {
        // NSLog(@"%@", sel_button);
        
        [sel_button setImage:nil forState:UIControlStateSelected];
        
        
        [sel_button setFrame:CGRectMake(sel_button.frame.origin.x, sel_button.frame.origin.y, sel_button.frame.size.width, sel_button.frame.size.height)];
        
        
    }
    
    accumulatedScore = 0;
    
    [self performSelector:@selector(totalScore) withObject:self];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ViewController_Home *home = [[ViewController_Home alloc] init];
    
    home = [storyboard instantiateViewControllerWithIdentifier:@"Home"];
    
    [home setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:home animated:YES completion:nil];
    
}

-(IBAction)btn_reset:(UIButton *)sender{
    
    accumulatedScore = 0;
    
    [progress setImage:[UIImage imageNamed:@"Stars - no stars.png"]];
    
    [self performSelector:@selector(totalScore) withObject:self];
    
    str_statusAnswer = @"Default";
    
    for(UIButton *sel_button in btn_object)
    {
        
        
        [sel_button setImage:nil forState:UIControlStateSelected];
        
        
        [sel_button setFrame:CGRectMake(sel_button.frame.origin.x, sel_button.frame.origin.y, sel_button.frame.size.width, sel_button.frame.size.height)];
        
        
    }
    
    
    for(NSString *str_nameOfPlace in list_name){
        
        NSLog(@"%@", str_nameOfPlace);
    }
    
    [list_name removeObjectsInArray:list_name];
    [btn_object removeObjectsInArray:btn_object];
    
    [list_name2 removeObjectsInArray:list_name2];
    
    //NSLog(@"%@", correctAnswers);
}



@end
