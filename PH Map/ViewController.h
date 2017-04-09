//
//  ViewController.h
//  PH Map
//
//  Created by Reggie Cabalo on 3/11/14.
//  Copyright (c) 2014 Reggie Cabalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pop-overController.h"


extern NSInteger phMapGlobalCounter;
extern NSMutableArray *list_name;
extern NSMutableArray *list_name2;
extern UIButton *btn;
extern NSString *str_capital;
extern unsigned long totalProvinceCapital;
extern UILabel *label_score;
extern UILabel *label_slash;
extern UILabel *label_totalProvinceCapital;
extern UIImageView *progress;

@interface ViewController : UIViewController <UIPopoverControllerDelegate>
{
    CGFloat lastScale;
    NSMutableArray *btn_object;
    NSString *name;
    NSMutableArray *array_totalProvinceCapital;
    NSString *str_total;
    UILabel *label_place;
}

@property (nonatomic, strong) IBOutlet UIImageView *scoreBoard;
@property (nonatomic, strong) IBOutlet UIImageView *place_icon;


@end
