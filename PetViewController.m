//
//  PetViewController.m
//  Paws Alert
//
//  Created by Tyler Weppler on 7/3/15.
//  Copyright (c) 2015 NerdboyDevelopment. All rights reserved.
//

#import "PetViewController.h"

@interface PetViewController ()

@property (nonatomic) BOOL *lostOrFound;
@property (nonatomic) BOOL *submitAblePaw;
@property (nonatomic) BOOL *submitAblePic;
@property (strong) Kumulos *k;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

@end

@implementation PetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lostOrFound = NO;
    self.submitAblePaw = NO;
    self.submitAblePic = NO;
    self.submitButton.enabled = NO;
    self.submitButton.tintColor = [UIColor grayColor];
    self.k = [[Kumulos alloc] init];
    [self.k setDelegate:self];
    self.petTypeTextField.delegate = self;
    self.petNameTextField.delegate = self;
    self.petDetailsTextView.delegate = self;
    //editing = NO;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    
}

- (void) allowSubmit
{
    if(self.submitAblePic == YES && self.submitAblePaw == YES)
    {
        self.submitButton.enabled = YES;
        self.submitButton.tintColor = [UIColor brownColor];
    }
}

//These 3 methods dismiss the keyboard
- (void) keyboardWillShow:(NSNotification *) note
{
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:self.tapRecognizer];
}

- (void)didTapAnywhere: (UITapGestureRecognizer *) recognizer
{
    [self.petTypeTextField resignFirstResponder];
    [self.petNameTextField resignFirstResponder];
    [self.petDetailsTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submit:(id)sender
{
    if([self.petTypeTextField.text isEqualToString:@""])
        {
            self.petTypeTextField.text = @"Pet";
        }
    if([self.petNameTextField.text isEqualToString:@""])
    {
        self.petNameTextField.text = @"No Name";
    }
    if(self.lostOrFound == YES)
    {
        NSData *imageDataToSendForLost = UIImageJPEGRepresentation(self.petImage.image, 1);
        [self.k createLostFoundTableWithTitle:[NSString stringWithFormat:@"Lost %@", self.petTypeTextField.text] andName:self.petNameTextField.text andDetails:self.petDetailsTextView.text andImageData:imageDataToSendForLost];
    }
    else
    {
        NSData *imageDataToSend = UIImageJPEGRepresentation(self.petImage.image, 0.0);
        [self.k createLostFoundTableWithTitle:[NSString stringWithFormat:@"Found %@", self.petTypeTextField.text] andName:self.petNameTextField.text andDetails:self.petDetailsTextView.text andImageData:imageDataToSend];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation createLostFoundImageDidCompleteWithResult:(NSNumber *)newRecordID
{
    //NSLog(@"finsished sending. Should end");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)camera:(id)sender
{
    //self.petImage.image = [UIImage imageNamed:@"paw.png"];
    self.submitAblePic = YES;
    [self allowSubmit];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    self.petImage.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)lost:(id)sender
{
    self.lostButton.tintColor = [UIColor yellowColor];
    self.foundButton.tintColor = [UIColor blackColor];
    self.lostOrFound = YES;
    self.submitAblePaw = YES;
    [self allowSubmit];
}

- (IBAction)found:(id)sender
{
    self.foundButton.tintColor = [UIColor yellowColor];
    self.lostButton.tintColor = [UIColor blackColor];
    self.lostOrFound = NO;
    self.submitAblePaw = YES;
    [self allowSubmit];
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
