//
//  ViewController_Home.h
//  PH Map
//
//  Created by Reggie Cabalo on 3/19/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ViewController_Home.h"

extern NSString *str_mode;
extern int nPlayedIntroMusic;

@interface ViewController_Home : UIViewController
{
    AVAudioPlayer *background_main;
}
@end
