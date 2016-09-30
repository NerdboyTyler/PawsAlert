//
//  PetViewController.h
//  Paws Alert
//
//  Created by Tyler Weppler on 7/3/15.
//  Copyright (c) 2015 NerdboyDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"

@interface PetViewController : UIViewController <UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *lostButton;
@property (weak, nonatomic) IBOutlet UIButton *foundButton;
@property (weak, nonatomic) IBOutlet UITextField *petTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *petNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *petDetailsTextView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIImageView *petImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;

@end
