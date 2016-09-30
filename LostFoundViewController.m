//
//  LostFoundViewController.m
//  Paws Alert
//
//  Created by Tyler Weppler on 7/14/15.
//  Copyright (c) 2015 NerdboyDevelopment. All rights reserved.
//

#import "LostFoundViewController.h"

@interface LostFoundViewController ()

@property (weak) NSString *petString;
@property (weak) NSString *petName;
@property (weak) NSString *petDets;
@property (weak) UIImage *petImage;
@property (weak) NSString *idNumber;
@property (weak) NSString *buttonOn;


@end

@implementation LostFoundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petType:(NSString *)petString name:(NSString *)petName details:(NSString *)petDets andPetImage:(UIImage *)petImage andIDNumber:(NSString *)idNum withButton:(NSString *)buttonOn
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.petString = petString;
        self.petName = petName;
        self.petDets = petDets;
        self.petImage = petImage;
        self.idNumber = idNum;
        self.buttonOn = buttonOn;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    backButton.tintColor = [UIColor brownColor];
    self.navigationController.navigationItem.leftBarButtonItem = backButton;
    // Do any additional setup after loading the view from its nib.
    self.lostFoundLabel.text = self.petString;
    self.petNameLabel.text = self.petName;
    self.petDetailsLabel.text = self.petDets;
    self.petImageView.image = self.petImage;
    
    if([self.buttonOn isEqualToString:@"YES"] == YES)
    {
        self.reuniteButton.tintColor = [UIColor brownColor];
        self.reuniteButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)complete:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:[NSString stringWithFormat:@"Reporting Success Story %@", self.idNumber]];
        [mail setMessageBody:[NSString stringWithFormat:@"This is a confirmation that a %@ was successfully reunited with their owner and may be selected for a Success Story in the Paws Alert app. Please see story number %@. This pet can be removed from the lost and found section now. Feel free to add any more details to make your story stand out:  ", self.petString, self.idNumber] isHTML:NO];
        [mail setToRecipients:@[@"pawsalertapp@gmail.com"]];
        
        [self presentViewController:mail animated:YES completion:nil];
                                
    }
    else
    {
        NSLog(@"Can't email");
    }
}

- (IBAction)save:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.petImageView.image, nil, nil, nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Saved!" message:@"Image saved to Camera Roll" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
