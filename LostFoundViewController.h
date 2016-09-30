//
//  LostFoundViewController.h
//  Paws Alert
//
//  Created by Tyler Weppler on 7/14/15.
//  Copyright (c) 2015 NerdboyDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface LostFoundViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *petImageView;
@property (weak, nonatomic) IBOutlet UILabel *lostFoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *petNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *petDetailsLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reuniteButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petType:(NSString *)petString name:(NSString *)petName details:(NSString *)petDets andPetImage:(UIImage *)petImage andIDNumber:(NSString *)idNum withButton:(NSString *)buttonOn;
@end
