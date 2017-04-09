//
//  pop-overController.m
//  PH Map
//
//  Created by Reggie Cabalo on 3/11/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//


#import "pop-overController.h"
#import "ModeViewController.h"
#import "ViewController_Home.h"
#import "StatusViewController.h"
#import "ViewController.h"

NSString *str_statusAnswer;

int accumulatedScore = 0;

@interface pop_overController ()

@end

@implementation pop_overController

@synthesize provincePopover = _provincePopover;

int numberOfEmptyField = 0;

int nIncorrect = 0;


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
    
    array_textfield_list = [[NSMutableArray alloc] init];
    array_textfield_list2 = [[NSMutableArray alloc] init];
    array_textfieldsText_list = [[NSMutableArray alloc] init];
    array_textfieldsText_list2 = [[NSMutableArray alloc] init];
    array_textfieldsText_list3 = [[NSMutableArray alloc] init];
    str_textFieldsCurrentText = [[NSString alloc] init];
    str_textField_status = [[NSString alloc] init];
    str_textFielsDefaultTextValue = [[NSString alloc] init];
    
    
    //REGGIEMAR152014 - sets the font size and color of the text of the label.
    self.nameOfPlacelabel.font = [UIFont fontWithName:@"Romeral" size:19];
    
    [self.nameOfPlacelabel setTextColor:[UIColor orangeColor]];
    
    self.nameOfProvincelabel.font = [UIFont fontWithName:@"Romeral" size:16];
    
    [self.nameOfProvincelabel setTextColor:[UIColor brownColor]];
    
    
    
    //REGGIE24MAY2014 - sets the size and content of the image called image_icon_wrong.
    image_icon_wrong = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"X MARK.png"]];
    
    [image_icon_wrong setFrame:CGRectMake(90, 70, 100, 80)];
    
    [image_icon_wrong setAlpha:0];
    
    [self.view addSubview:image_icon_wrong];
    
    
    
    //REGGIE24MAY2014 - sets the size and content of the label caleed label_wrong which will displayed in the popup if the answer is incorrect.
    
    label_wrong = [[UILabel alloc] initWithFrame:CGRectMake(200, 80, 120, 50)];
    
    label_wrong.text = @"Try Again!";
    
    label_wrong.font = [UIFont fontWithName:@"Romeral" size:19];
    
    [label_wrong setTextColor:[UIColor colorWithRed:0x93/255.0f green:0x1a/255.0f blue:0x10/255.0f alpha:1]];
    
    [label_wrong setAlpha:0];
    
    [self.view addSubview:label_wrong];
    
    
    
    //REGGIE25MAY2014 - sets the content of the label named label_hintRemaining.
    self.label_hintRemaining.font = [UIFont fontWithName:@"Romeral" size:20];
    
    self.label_hintRemaining.textColor = [UIColor colorWithRed:0xA6/255.0f green:0x9C/255.0f blue:0x63/255.0f alpha:1];
    
    //REGGIEJUNE102014 - adds a tap recognizer for the hint label.
    UITapGestureRecognizer *tapHintLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btn_hint:)];
    
    [tapHintLabel setNumberOfTapsRequired:1];
    [tapHintLabel setNumberOfTouchesRequired:1];
    
    self.label_hintRemaining.userInteractionEnabled = YES;
    
    [self.label_hintRemaining addGestureRecognizer:tapHintLabel];
    
    
    //REGGIE11JUNE2104 - Image and Layout of the YES button in revealing the correct answer.
    btnYesCorrectAnswer = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, 152, 65)];
    
    [btnYesCorrectAnswer setImage:[UIImage imageNamed:@"Correct Answer - YES.png"] forState:UIControlStateNormal];
    
    [btnYesCorrectAnswer setAlpha:0];
    
    [btnYesCorrectAnswer addTarget:self action:@selector(revealAnswers) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnYesCorrectAnswer];
    
    
    //REGGIE11JUNE2104 - Image and Layout of the "Continue Typing" button in refusing to reveal the answer.
    btnContinueTryingCorrectAnswer = [[UIButton alloc] initWithFrame:CGRectMake(180, 90, 185, 80)];
    
    [btnContinueTryingCorrectAnswer setImage:[UIImage imageNamed:@"Correct Answer - Continue trying.png"] forState:UIControlStateNormal];
    
    [btnContinueTryingCorrectAnswer setAlpha:0];
    
    [btnContinueTryingCorrectAnswer addTarget:self action:@selector(dontRevealAnswers) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnContinueTryingCorrectAnswer];
    
    
    //REGGIE11JUNE2104 - Image and Layout of the "YES" button in using the remaining hint.
    btnUseHint = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, 152, 65)];
    
    [btnUseHint setImage:[UIImage imageNamed:@"Use a hint - Yes.png"] forState:UIControlStateNormal];
    
    [btnUseHint setAlpha:0];
    
    [btnUseHint addTarget:self action:@selector(yesTriggerUseHint) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnUseHint];
    
    
    //REGGIE11JUNE2104 - Image and Layout of the "No" button in using the remaining hint.
    btnDontUseHint = [[UIButton alloc] initWithFrame:CGRectMake(190, 90, 152, 70)];
    
    [btnDontUseHint setImage:[UIImage imageNamed:@"Use a hint - No.png"] forState:UIControlStateNormal];
    
    [btnDontUseHint setAlpha:0];
    
    [btnDontUseHint addTarget:self action:@selector(dontUseHint) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnDontUseHint];
    
    
    
    //REGGIE11JUNE2014 - Background image of the "Do you want to use a hint" content of the popup.
    image_background_hint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Use a hint box simple.png"]];
    
    [image_background_hint setFrame:CGRectMake(-35, -40, 469, 312)];
    
    [image_background_hint setAlpha:0];
    
    [self.view addSubview:image_background_hint];
    
    
    
    //REGGIE11JUNE2014 - Background image of the "Do you want to know the correct answer" content of the popup.
    image_background_question = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CORRECT ANSWER - box final.png"]];
    
    [image_background_question setFrame:CGRectMake(-35, -40, 469, 312)];
    
    [image_background_question setAlpha:0];
    
    [self.view addSubview:image_background_question];
    
    
    btnCancelPopup = [[UIButton alloc] initWithFrame:CGRectMake(366, 5, 30, 30)];
    
    [btnCancelPopup setImage:[UIImage imageNamed:@"X Button popup.png"] forState:UIControlStateNormal];
    
    [btnCancelPopup addTarget:self action:@selector(dismissPopout) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnCancelPopup];
    
    
    image_background = [[UIImageView alloc] initWithFrame:CGRectMake(-35, -30, 470, 300)];

    
    if([str_mode isEqualToString:@"Learn"])
    {
        CGSize size = CGSizeMake(250, 80); // size of view in popover
        self.preferredContentSize = size;
        
        image_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Learn box.png"]];
        
        [image_background setFrame:CGRectMake(0, 0, 300, 90)];
        
        self.btnHintOutlet.hidden = YES;
        
        self.label_hintRemaining.hidden = YES;
        
        //NSString *nameOfPlace = [[NSString alloc] initWithFormat:@"%@.mp3, "]
        
        
        
        if([str_placeType isEqualToString:@"Province"])
        {
            
            [self.nameOfPlacelabel setFrame:CGRectMake(0, 20, 250, 33)];
            
            self.nameOfProvincelabel.hidden = YES;
            
        }
        else if ([str_placeType isEqualToString:@"Capital"])
        {
            self.nameOfProvincelabel.text = self.nameOfProvinceCalled;
            
            if([self.nameOfProvinceCalled isEqualToString:@"Tawi-tawi"])
            {
                self.nameOfPlacelabel.font = [UIFont fontWithName:@"Romeral" size:15];
            }
        }
        
        [self play_provinceCapitalName];
    }
    else if ([str_mode isEqualToString:@"Play"])
    {
        CGSize size = CGSizeMake(400, 218); // size of view in popover
        self.preferredContentSize = size;
        
        self.nameOfPlacelabel.hidden = YES;
        
        self.nameOfProvincelabel.hidden = YES;
        
        if([str_placeType isEqualToString:@"Province"])
        {
            [image_background setImage:[UIImage imageNamed:@"GUESS THE PROVINCE,469px.png"]];
        }
        else if ([str_placeType isEqualToString:@"Capital"])
        {
            [image_background setImage:[UIImage imageNamed:@"GUESS THE CAPITALS, 469px.png"]];
        }
        
        //REG21APRIL2014 - allocate and initialize a mutable array with the capacity of the value of the label "nameOFPalceCalled"
        array_characterOfString = [[NSMutableArray alloc] initWithCapacity:[self.nameOfPlaceCalled length]];
        
        if([self.nameOfPlaceCalled length] > 0 && [self.nameOfPlaceCalled length] < 4){
            //int sizeOfViw - an integer variable that devides the total width of the view (pop-over) into the number of character of the specific word selected.
            widthOfView = 400/([self.nameOfPlaceCalled length] + 1.5);
            
        }
        else if([self.nameOfPlaceCalled length] > 3 && [self.nameOfPlaceCalled length] < 7){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 2);
            
            
        }
        else if ([self.nameOfPlaceCalled length] > 6 && [self.nameOfPlaceCalled length] < 10){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 2.4);
            
        }
        else if ([self.nameOfPlaceCalled length] > 9 && [self.nameOfPlaceCalled length] < 13){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 3);
            
        }
        else if ([self.nameOfPlaceCalled length] > 12 && [self.nameOfPlaceCalled length] < 16){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 3.5);
            
        }
        
        else if ([self.nameOfPlaceCalled length] > 15 && [self.nameOfPlaceCalled length] < 19){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 4);
            
        }
        else if ([self.nameOfPlaceCalled length] > 18 && [self.nameOfPlaceCalled length] < 22){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 4.5);
            
        }
        else if ([self.nameOfPlaceCalled length] > 21 && [self.nameOfPlaceCalled length] < 25){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 5);
            
        }
        else if ([self.nameOfPlaceCalled length] > 24 && [self.nameOfPlaceCalled length] < 28){
            
            widthOfView = 420/([self.nameOfPlaceCalled length] + 5.5);
            
        }
        
        // variable x contains the devided value of the variable "sizeOfView"
        position_x = widthOfView;
        
        randomValue_status = 0;
        
        if(randomValue_status < 3 || (randomValue_status == [self.nameOfPlaceCalled length])){
            
            [self loopFunction];
            
        }
    }
    
    [self.view insertSubview:image_background atIndex:0];
    
    self.nameOfPlacelabel.text = self.nameOfPlaceCalled;
    
    
    for (UITextField *checkTextOfTextfield2 in array_textfield_list){
        
        
        //stores the retrieve value of array into another array
        [array_textfieldsText_list2 addObject:checkTextOfTextfield2.text];
        
    }
    
    for(NSString *str_contentOfTextField in array_textfieldsText_list2){
        
        if([str_contentOfTextField  isEqualToString:@""])
        {
            numberOfEmptyField = numberOfEmptyField + 1;
            
        }
        
    }
    
    
    //the value of the numberOfEmptyField variable will be stored in the the totalHint variable
    totalHint = numberOfEmptyField;
    
    totalHint = totalHint/2;
    
    //checks if the totalHint is greater than 1, then the text of the label would display the same text declared inside the condition.
    
    if(totalHint > 1){
        
        self.label_hintRemaining.text = [NSString stringWithFormat:@"%i Hints Left", totalHint];
        
    }
    else if (totalHint == 1){
        
        self.label_hintRemaining.text = [NSString stringWithFormat:@"%i Hint Left", totalHint];
    }
    else if (totalHint == 0){
        
        self.btnHintOutlet.userInteractionEnabled = NO;
        self.btnHintOutlet.selected = YES;
        
        self.label_hintRemaining.text = [NSString stringWithFormat:@"No Hint Left"];
    }
    
    
}

-(void)play_provinceCapitalName
{
    NSURL *url;
    if([str_placeType isEqualToString:@"Province"])
    {
        url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3",[[NSBundle mainBundle] resourcePath], btn.currentTitle]];
       
    }
    else if ([str_placeType isEqualToString:@"Capital"])
    {
        url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3",[[NSBundle mainBundle] resourcePath], self.nameOfPlaceCalled]];
    }
    
    NSError *error;
    
    tap_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    [tap_sound  setVolume:1.0];
    
    tap_sound.numberOfLoops = 0;
    [tap_sound play];
}



//REGGIE12MAY2014 - loop function that applies in the Play Mode and Both Type of Place. The loop sets the randomized text to be displayed in the texfield of the popup.
-(void)loopFunction
{
    
    //REG21APRIL2014 - loops the value of array and splits the words into letters or individual characters of the specific word (province name)
    for (int i=0; i < [self.nameOfPlaceCalled length]; i++) {
        
        //Converts the array value into string
        str_textFielsDefaultTextValue  = [NSString stringWithFormat:@"%c", [self.nameOfPlaceCalled characterAtIndex:i]];
        
        //Adds the string object into the array
        [array_characterOfString addObject:str_textFielsDefaultTextValue];
        
        
        //REG21APRIL2014 - creates text field object into the view with corresponding location and size.
        textfield_container = [[UITextField alloc] initWithFrame:CGRectMake(position_x, 100, 50, 30)];
        
        //Sets the value of the text field center in vertical and horizontal aspect
        textfield_container.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textfield_container.textAlignment = NSTextAlignmentCenter;
        
        [textfield_container setTag:i];
        
        
        
        textfield_container.delegate = self;
        
        
        //REG21APRIL2014 - checks if the value of the string contains whitespace element
        
        position_x = position_x + widthOfView;
        
        if([str_textFielsDefaultTextValue rangeOfString:@" "].location != NSNotFound){
            
            
            textfield_container.text = @" ";
            textfield_container.userInteractionEnabled = NO;
            
        }
        
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"-().,"];
        
        if([str_textFielsDefaultTextValue rangeOfCharacterFromSet:set].location != NSNotFound){
            
            textfield_container.text = str_textFielsDefaultTextValue;
            textfield_container.userInteractionEnabled = NO;
            
        }
        
        
        randomValue = arc4random_uniform(i) + 1;
        
        if(randomValue == 1){
            
            randomValue = arc4random_uniform(i) + 1;
        }
        
        
        
        //REG21APRIL2014 - if the value of the randomValue is not equal to the iteration i, text are set to empty.
        
        if(randomValue != i)
        {
            
            textfield_container.placeholder = @"_";
            str_textField_status = @"EMPTY";
            [textfield_container becomeFirstResponder];
            
            
        }
        
        //REG21APRIL2014 - if the value of the randomValue is not equal to the iteration i, text are displayed in the textfield.
        else{
            
            NSMutableAttributedString *str_attributedStringValue = [[NSMutableAttributedString alloc] initWithString:str_textFielsDefaultTextValue];
            
            [str_attributedStringValue addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleNone] range:NSMakeRange(0, str_attributedStringValue.length)];
            
            
            [textfield_container setAttributedText:str_attributedStringValue];
            
            [textfield_container setEnabled:NO];
            
            str_textField_status = @"FILLED";
            
            randomValue_status++;
            
            
        }
        
        
        [textfield_container setTextColor:[UIColor brownColor]];
        textfield_container.font = [UIFont fontWithName:@"Varela Round" size:25];
        
        //Adds the textfield as part of the subview
        [self.view addSubview:textfield_container];
        
        
        //textfield_container is added in array
        [array_textfield_list addObject:textfield_container];
        
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //nIncorrect = 0;
    return YES;
}





//Sets the limit character to be type into 1.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 1) ? NO : YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UITextFieldTextDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:textField];
    
    [textField resignFirstResponder];
}


//REG28APRIL2014 - function that detects changes in the textfield.
- (void)UITextFieldTextDidChange:(NSNotification*)notification
{
    NSString *str_status = [[NSString alloc] init];
    int t = 0; //iteration for loop
    int d = 0; //iteration for loop
    
    
    UITextField *textfield = (UITextField*)notification.object;
    
    for(NSString *text in array_characterOfString){
        
        str_textFieldsCurrentText = [NSString stringWithFormat:@"%@", text];
        
        
        //REG28APRIL2014 - checks if the user types the correct letter on the correct tag of the textfield
        if( ([textfield.text caseInsensitiveCompare:str_textFieldsCurrentText] == NSOrderedSame) && textfield.tag == t){
            
            str_status = @"correct";
            
            textfield.text = str_textFieldsCurrentText;
            
            [self stringStyle:textfield];
            
            break;
            
        }
        else if([textfield.text isEqualToString:@""]){
            textfield.text = @"";
            
            
            
        }
        //If the user types the wrong letter, it notifies the user that the answer is wrong.
        else if(![textfield.text isEqualToString:text]){
            
            str_status = @"wrong";
            
        }
        
        t++;
        
        if(t == [array_characterOfString count]){
            if ([str_status isEqualToString:@"wrong"])
            {
                
                nIncorrect += 1;
                                
                if((nIncorrect > 0)  && (nIncorrect < 5))
                {
                    [self wrongAnswer];
                }
                else if ((nIncorrect >= 5) && (totalHint != 0))
                {
                    [self performSelector:@selector(popupContentQuestionUseHint) withObject:nil afterDelay:0.5];
                    
                }
                else if ((nIncorrect >= 5) && (totalHint == 0))
                {
                    [self performSelector:@selector(popupContentQuestionPresentAnswer) withObject:nil afterDelay:0.5];
                    
                }

                
                
                textfield.text = @"";
                
                [textfield becomeFirstResponder];
                
                return;
            }
        }
        
    }
    
    
    int counterResponder = 0;
    
    //REGGIE29APRIL2014 - loops the content of an array whichs are the textfields.
    for(textfield in array_textfield_list){
        
        
        //Checks if the user types the correct answer of the correct textfield tag and if its true, the "str_textField_status" is equal to "FILLED".
        if (([textfield.text isEqual:[array_characterOfString objectAtIndex:d]]) && ([textfield.text caseInsensitiveCompare:[array_characterOfString objectAtIndex:d]] == NSOrderedSame) && textfield.tag == d) {
            
            
            str_textField_status = @"FILLED";
            
            
        }
        else{
            str_textField_status = @"EMPTY";
            if(counterResponder == 0){
                [textfield becomeFirstResponder];
                counterResponder = 1;
            }
            
        }
        
        //Adds the str_textField_status in an array
        [array_textfield_list2 addObject:str_textField_status];
        
        d++;
        
    }
    
    
    //If array("array_textfield_list2") does not contain "EMPTY" string element then, all answers are correct.
    
    if(![array_textfield_list2 containsObject:@"EMPTY"]){
        
        //increments the score by 1
        accumulatedScore = accumulatedScore + 1;
        
        str_statusAnswer = @"AllCorrect";
        
        [list_name2 addObject:self.nameOfPlaceCalled];
        
        [self performSelector:@selector(correctAnswer) withObject:nil afterDelay:0.5];
        
        NSString *str_image_title = [[NSString alloc] initWithFormat:@"TOUCHED_%@.png", btn.currentTitle];
        
        NSString *str_image_title2 = [[NSString alloc] initWithFormat:@"TOUCHED CAPITAL %@.png", btn.currentTitle];
        
        //Change the state of the button from deault to slected.
        if([btn.currentTitle isEqualToString:[[NSString alloc]initWithFormat:@"%@", self.nameOfPlaceCalled]]){
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title]] forState:UIControlStateSelected];
            
            
        }
        else{
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title2]] forState:UIControlStateSelected];
            
        }
        
        
        
        btn.selected = YES;
        
        [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
        
        [self play_provinceCapitalName];
        
        //dismiss the popout
        [self performSelector:@selector(dismissPopout) withObject:self afterDelay:2];
        
    }
    
    
    [array_textfield_list2 removeObjectsInArray:array_textfield_list2];
    
}

//REG02MAY2014 - a function for the hint button which supplies a letter in an empty textfield to thelp the user get the correct annswer.



-(IBAction)btn_hint:(id)sender{
    
    int r = 0; //loop iteration
    
    UITextField *hintTextField = [[UITextField alloc] init];
    
    for(hintTextField in array_textfield_list){
        if(([hintTextField.text isEqualToString:@""]) && hintTextField.tag == r){
            
            hintTextField.text = [NSString stringWithFormat:@"%c", [self.nameOfPlaceCalled characterAtIndex:hintTextField.tag]];
            
            [self stringStyle:hintTextField];
            
            break;
        }
        
        
        r++;
    }
    
    int counterResponderHint = 0;
    
    for (UITextField *checkTextOfTextfield in array_textfield_list){
        
        if([checkTextOfTextfield.text isEqualToString:@""])
        {
            if(counterResponderHint == 0){
                [checkTextOfTextfield becomeFirstResponder];
                counterResponderHint = 1;
            }
        }
        
        [array_textfieldsText_list addObject:checkTextOfTextfield.text];
        
    }
    
    //Robin --- need to fix this section (if a wrong answer had been entered before using a hint to finish up the letters doesn't result in a correct answer)                      
    if(![array_textfieldsText_list containsObject:@""]){
        
        accumulatedScore = accumulatedScore + 1;
        
        str_statusAnswer = @"AllCorrect";
        
        [list_name2 addObject:self.nameOfPlaceCalled];
        
        [self performSelector:@selector(correctAnswer) withObject:nil afterDelay:0.5];
        
        NSString *str_image_title = [[NSString alloc] initWithFormat:@"TOUCHED_%@.png", btn.currentTitle];
        
        NSString *str_image_title2 = [[NSString alloc] initWithFormat:@"TOUCHED CAPITAL %@.png", btn.currentTitle];
        
        if([btn.currentTitle isEqualToString:[[NSString alloc]initWithFormat:@"%@", self.nameOfPlaceCalled]]){
            
            btn.selected = YES;
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title]] forState:UIControlStateSelected];
            
            [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
            
        }
        else
        {
            btn.selected = YES;
            
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title2]] forState:UIControlStateSelected];
            
            
            [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
        }
        
        [self play_provinceCapitalName];
        
        [self performSelector:@selector(dismissPopout) withObject:self afterDelay:2.0];
        
        
        
    }
    
    
    //decrement the totalhint once the button is touched.
    totalHint = totalHint - 1;
    
    self.label_hintRemaining.text = [NSString stringWithFormat:@"%i Hints Available", totalHint];
    
    //checks if the total hint is equal to 1
    if(totalHint == 1){
        
        self.label_hintRemaining.text = [NSString stringWithFormat:@"%i Hint Available", totalHint];
        
    }
    
    else if (totalHint <= 0)
    {
        totalHint = 0;
        self.label_hintRemaining.text= [NSString stringWithFormat:@"No Hint Available"];
        self.btnHintOutlet.userInteractionEnabled = NO;
        self.btnHintOutlet.selected = YES;
    }
    
    [array_textfieldsText_list removeObjectsInArray:array_textfieldsText_list];
    
    
    
}

//REGGIE13JUNE2014 - Animates back top the previous content. Executes if the user refuse to reveal the answer, refure to use a hint or choose to use a hint.
- (void)btnNoInPopup:(UIButton *)button :(UIButton *)button2
{
    int counterResponderHint = 0;
    
    for(UITextField *textfield in array_textfield_list)
    {
        textfield.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self.view setBackgroundColor:[UIColor colorWithRed:0xe4/255.0f green:0xeb/255.0f blue:0xe5/255.0f alpha:1]];
            
            [UIView beginAnimations:nil context:NULL];
            
            [UIView setAnimationDuration:0.5];
            
            [button setAlpha:0];
            
            [button2 setAlpha:0];
            
            [image_background setAlpha:1];
            
            [UIView commitAnimations];
            
            [self.label_hintRemaining setAlpha:1];
            
            [textfield setAlpha:1];
            [self.btnHintOutlet setAlpha:1];
            
        }completion:nil];
        
        if([textfield.text isEqualToString:@""])
        {
            if(counterResponderHint == 0){
                [textfield becomeFirstResponder];
                counterResponderHint = 1;
            }
        }
        
    }
}

-(void)yesTriggerUseHint
{
    [self performSelector:@selector(btn_hint:) withObject:nil];
    [self btnNoInPopup:btnUseHint :btnDontUseHint];
    
    
    
}


- (void)dontUseHint
{
    
    [self btnNoInPopup:btnUseHint :btnDontUseHint];
}


- (void)dontRevealAnswers
{
    
    [self btnNoInPopup:btnYesCorrectAnswer :btnContinueTryingCorrectAnswer];
}

//REGGIE11JUNE2014 - Reveals all the answer if the user choose to reveal all the answers.
-(void)revealAnswers
{
    int r = 0; //loop iteration
    
    int counterResponderHint = 0;
    
    
    UITextField *hintTextField = [[UITextField alloc] init];
    
    for(hintTextField in array_textfield_list){
        if(([hintTextField.text isEqualToString:@""]) && hintTextField.tag == r){
            
            hintTextField.text = [NSString stringWithFormat:@"%c", [self.nameOfPlaceCalled characterAtIndex:hintTextField.tag]];
            
            [self stringStyle:hintTextField];
            
        }
        
        hintTextField.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self.view setBackgroundColor:[UIColor colorWithRed:0xe4/255.0f green:0xeb/255.0f blue:0xe5/255.0f alpha:1]];
            
            [UIView beginAnimations:nil context:NULL];
            
            [UIView setAnimationDuration:0.5];
            
            [btnContinueTryingCorrectAnswer setAlpha:0];
            
            [btnYesCorrectAnswer setAlpha:0];
            
            [image_background setAlpha:1];
            
            [UIView commitAnimations];
            
            [image_background setAlpha:1];
            
            [self.label_hintRemaining setAlpha:1];
            
            [hintTextField setAlpha:1];
            [self.btnHintOutlet setAlpha:1];
            
        }completion:nil];
        
        if([hintTextField.text isEqualToString:@""])
        {
            if(counterResponderHint == 0){
                [hintTextField becomeFirstResponder];
                counterResponderHint = 1;
            }
            
            [array_textfieldsText_list3 addObject:hintTextField.text];
        }
        
        r++;
    }
    
    if(![array_textfieldsText_list3 containsObject:@""]){
        
        //accumulatedScore = accumulatedScore + 1;
        
        str_statusAnswer = @"AllCorrect";
        
        [list_name2 addObject:self.nameOfPlaceCalled];
        
        //[self performSelector:@selector(correctAnswer) withObject:nil afterDelay:0.5];
        
        NSString *str_image_title = [[NSString alloc] initWithFormat:@"TOUCHED_%@.png", btn.currentTitle];
        
        NSString *str_image_title2 = [[NSString alloc] initWithFormat:@"TOUCHED CAPITAL %@.png", btn.currentTitle];
        
        if([btn.currentTitle isEqualToString:[[NSString alloc]initWithFormat:@"%@", self.nameOfPlaceCalled]]){
            
            btn.selected = YES;
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title]] forState:UIControlStateSelected];
            
            [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
            
        }
        else
        {
            btn.selected = YES;
            
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithString:str_image_title2]] forState:UIControlStateSelected];
            
            
            [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
        }
        
        [self play_provinceCapitalName];
        
        [self performSelector:@selector(dismissPopout) withObject:self afterDelay:3.0];
        
        
        
    }
}





//REG23MAY2014 - function that executes if the user gets the correct answer
- (void)correctAnswer
{
    
    CGSize size = CGSizeMake(250, 90); // size of the popover for this function
    self.preferredContentSize = size;
    
    label_correct = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 100, 50)];
    
    UILabel *label_score = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 130, 50)];
    
    [label_correct setAlpha:0];
    
    [label_score setAlpha:0];
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.5];
    
    [textfield_container setAlpha:0];
    [self.btnHintOutlet setAlpha:0];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0xe4/255.0f green:0xeb/255.0f blue:0xe5/255.0f alpha:1]];
    
    UIImageView *image_icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CHECK MARK.png"]];
    
    [image_icon setFrame:CGRectMake(0, 10, 100, 80)];
    
    [self.view addSubview:image_icon];
    
    label_correct.text = @"Correct!";
    
    label_correct.font = [UIFont fontWithName:@"Romeral" size:19];
    
    [label_correct setTextColor:[UIColor colorWithRed:0x18/255.0f green:0x79/255.0f blue:0x9a/255.0f alpha:1]];
    
    [label_correct setAlpha:1];
    
    
    label_score.text = [NSString stringWithFormat:@"Total score is: %i", accumulatedScore];
    
    label_score.font = [UIFont fontWithName:@"Romeral" size:15];
    
    [label_score setTextColor:[UIColor colorWithRed:0x18/255.0f green:0x79/255.0f blue:0x9a/255.0f alpha:1]];
    
    [label_score setAlpha:1];
    
    
    [self.view addSubview:label_score];
    
    [self.view addSubview:label_correct];
    
    [image_background removeFromSuperview];
    
    [image_background_hint removeFromSuperview];
    
    [image_background_question removeFromSuperview];
    
    [UIView commitAnimations];
    
    AudioServicesPlaySystemSound (1054);
}

//REG23MAY2014 - function that executes if the user gets the incorrect answer
- (void)wrongAnswer
{
    
    for(UITextField *textfield in array_textfield_list)
    {
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear animations:^{
                                
                                [textfield setAlpha:0];
                                
                                [self.btnHintOutlet setAlpha:0];
                                
                                [self.label_hintRemaining setAlpha:0];
                                
                                [image_background setAlpha:0];
                                
                                [image_background_question setAlpha:0];
                                
                                [image_background_hint setAlpha:0];
                                
                                [image_icon_wrong setAlpha:1];
                                
                                [label_wrong setAlpha:1];
                                
                            }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                                 
                                 [self.view setBackgroundColor:[UIColor colorWithRed:0xe4/255.0f green:0xeb/255.0f blue:0xe5/255.0f alpha:1]];
                                 
                                 [UIView beginAnimations:nil context:NULL];
                                 
                                 [UIView setAnimationDuration:1.5];
                                 
                                 [image_icon_wrong setAlpha:0];
                                 
                                 [label_wrong setAlpha:0];
                                 
                                 [UIView commitAnimations];
                                 
                                 [image_background setAlpha:1];
                                 
                                 [self.label_hintRemaining setAlpha:1];
                                 
                                 [textfield setAlpha:1];
                                 [self.btnHintOutlet setAlpha:1];
                                 
                             }completion:nil];
                         }];
    }
    
    AudioServicesPlaySystemSound (1053);
}

//REGGIE13JUNE2014 - Animates the content of the popup into the new content which contains a questions.
- (void)newPopupContent:(UIButton *)button1 :(UIButton *)button2 :(UIImageView *)background
{
    for(UITextField *textfield in array_textfield_list)
    {
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear animations:^{
                                
                                [textfield setAlpha:0];
                                
                                textfield.userInteractionEnabled = NO;
                                
                                [self.btnHintOutlet setAlpha:0];
                                
                                [self.label_hintRemaining setAlpha:0];
                                
                                [image_background setAlpha:0];
                                
                                [button1 setAlpha:1];
                                
                                [button2 setAlpha:1];
                                
                                [self.view insertSubview:background atIndex:0];
                                
                                [background setAlpha:1];
                            }
                         completion:nil];
        
    }
    
    //nIncorrect = 0;
}

- (void)popupContentQuestionPresentAnswer
{
    
    [self newPopupContent:btnYesCorrectAnswer :btnContinueTryingCorrectAnswer :image_background_question];
    
}


- (void)popupContentQuestionUseHint
{
    
    [self newPopupContent:btnUseHint :btnDontUseHint :image_background_hint];
    
}


//REG25MAY2014 - dismiss the popup
- (void)dismissPopout
{
    [self.provincePopover dismissPopoverAnimated:YES];
    
    
    if([str_mode isEqualToString:@"Play"]){
        ViewController *vc = [[ViewController alloc] init];
        
        [vc viewWillAppear:YES];
        
    }
}




- (void)viewWillAppear:(BOOL)animated
{
    
    if([str_mode isEqualToString:@"Learn"])
    {
        [self.provincePopover dismissPopoverAnimated:YES];
        
        AudioServicesPlaySystemSound (1103);
        
        [self performSelector:@selector(dismissPopout) withObject:nil afterDelay:2.0];
    }
    
    phMapGlobalCounter--;
    
    if(([str_statusAnswer isEqualToString:@"AllCorrect"]) && [list_name2 containsObject:self.nameOfPlaceCalled]){
        
        if([self.nameOfPlaceCalled length] > 0 && [self.nameOfPlaceCalled length] < 4){
            //int sizeOfViw - an integer variable that devides the total width of the view (pop-over) into the number of character of the specific word selected.
            widthOfView = 400/([self.nameOfPlaceCalled length] + 1.5);
            
            // variable x contains the devided value of the variable "sizeOfView"
            
            
        }
        else if([self.nameOfPlaceCalled length] > 3 && [self.nameOfPlaceCalled length] < 7){
            //int sizeOfViw - an integer variable that devides the total width of the view (pop-over) into the number of character of the specific word selected.
            widthOfView = 400/([self.nameOfPlaceCalled length] + 2);
            
            // variable x contains the devided value of the variable "sizeOfView"
            
        }
        else if ([self.nameOfPlaceCalled length] > 6 && [self.nameOfPlaceCalled length] < 10){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 2.4);
            
            
        }
        else if ([self.nameOfPlaceCalled length] > 9 && [self.nameOfPlaceCalled length] < 13){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 3);
            
            
        }
        else if ([self.nameOfPlaceCalled length] > 12 && [self.nameOfPlaceCalled length] < 16){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 3.5);
            
            
        }
        
        else if ([self.nameOfPlaceCalled length] > 15 && [self.nameOfPlaceCalled length] < 19){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 4);
            
            
            
        }
        else if ([self.nameOfPlaceCalled length] > 18 && [self.nameOfPlaceCalled length] < 22){
            
            widthOfView = 300/([self.nameOfPlaceCalled length] + 4.5);
            
            
        }
        else if ([self.nameOfPlaceCalled length] > 21 && [self.nameOfPlaceCalled length] < 25){
            
            widthOfView = 400/([self.nameOfPlaceCalled length] + 5);
            
            
        }
        
        position_x = widthOfView;
        
        UITextField *textFieldAfterAllAnswersCorrect;
        int z = 0;
        for(textFieldAfterAllAnswersCorrect in array_textfield_list)
        {
            
            [textFieldAfterAllAnswersCorrect setFrame:CGRectMake(position_x, 100, 50, 30)];
            
            str_textFielsDefaultTextValue  = [NSString stringWithFormat:@"%c", [self.nameOfPlaceCalled characterAtIndex:z]];
            
            if([str_textFielsDefaultTextValue rangeOfString:@" "].location != NSNotFound){
                
                
                textFieldAfterAllAnswersCorrect.userInteractionEnabled = NO;
                
            }
            
            position_x = position_x+widthOfView;
            
            NSMutableAttributedString *str_attributedStringValue = [[NSMutableAttributedString alloc] initWithString:str_textFielsDefaultTextValue];
            
            [str_attributedStringValue addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, str_attributedStringValue.length)];
            
            [textFieldAfterAllAnswersCorrect setAttributedText:str_attributedStringValue];
            
            [textFieldAfterAllAnswersCorrect setTextColor:[UIColor brownColor]];
            
            [textFieldAfterAllAnswersCorrect setEnabled:NO];
            
            z++;
            
        }
        
        self.btnHintOutlet.userInteractionEnabled = NO;
        self.btnHintOutlet.selected = YES;
        
        self.label_hintRemaining.hidden = YES;
        
        
        [self performSelector:@selector(dismissPopout) withObject:self afterDelay:2.0];
        
    }
}


//REG01MAY2014 - function for the display of the text in the textfield.
-(void)stringStyle:(UITextField *)textField
{
    NSMutableAttributedString *str_attributedStringValue = [[NSMutableAttributedString alloc] initWithString:textField.text];
    
    [str_attributedStringValue addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, str_attributedStringValue.length)];
    
    [textField setAttributedText:str_attributedStringValue];
    
    textField.font = [UIFont fontWithName:@"Varela Round" size:25];
    
    [textField setTextColor:[UIColor brownColor]];
    
    [textField setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
