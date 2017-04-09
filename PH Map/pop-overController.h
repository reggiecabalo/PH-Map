//
//  pop-overController.h
//  PH Map
//
//  Created by Reggie Cabalo on 3/11/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

extern  NSString *str_statusAnswer;

extern int accumulatedScore;

@interface pop_overController : UIViewController <UITextFieldDelegate>
{
    AVAudioPlayer *tap_sound;
    
    NSMutableArray *array_textfield_list;
    NSMutableArray *array_textfield_list2;
    NSMutableArray *array_textfieldsText_list;
    NSMutableArray *array_textfieldsText_list2;
    NSMutableArray *array_textfieldsText_list3;
    NSMutableArray *array_characterOfString;
    
    float position_x;
    float widthOfView;
    
    int randomValue;
    int randomValue_status;
    int numberOfEmptyField;
    int totalHint;
    int nIncorrect;
    
    NSString *str_textFieldsCurrentText;
    NSString *str_textField_status;
    NSString *str_textFielsDefaultTextValue;
    
    UITextField *textfield_container;
    
    UIImageView *image_background;
    UIImageView *image_icon_wrong;
    UIImageView *image_background_hint;
    UIImageView *image_background_question;
    
    UILabel *label_wrong;
    UILabel *label_correct;
    UILabel *label_remainingHint;
    
    UIButton *btnYesCorrectAnswer;
    UIButton *btnContinueTryingCorrectAnswer;
    UIButton *btnUseHint;
    UIButton *btnDontUseHint;
    
    UIButton *btnCancelPopup;
    

    
}


@property (weak, nonatomic) IBOutlet UIButton *btnHintOutlet;

@property (weak, nonatomic) IBOutlet UILabel *nameOfPlacelabel;

@property (weak, nonatomic) IBOutlet UILabel *label_hintRemaining;

@property (nonatomic, readwrite) NSString *nameOfPlaceCalled;

@property (weak, nonatomic) IBOutlet UILabel *nameOfProvincelabel;

@property (nonatomic, readwrite) NSString *nameOfProvinceCalled;

@property (nonatomic, strong) UIPopoverController *provincePopover;

@end
