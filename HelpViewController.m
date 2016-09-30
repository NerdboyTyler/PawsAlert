//
//  HelpViewController.m
//  Paws Alert
//
//  Created by Tyler Weppler on 7/14/15.
//  Copyright (c) 2015 NerdboyDevelopment. All rights reserved.
//

#import "HelpViewController.h"
#import "FosterViewController.h"
#import "PetItemsViewController.h"
#import "VolunteerViewController.h"
#import "SuccessViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donateMoney:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.cfok.org/Donors/Give-Now?fn=Stillwater+Animal+Welfare+Advisory+Committee+Fiscal+Sponsorship"]];
}

- (IBAction)donateItems:(id)sender
{
    //list of items needed and an address to send them to
    PetItemsViewController *pivc = [[PetItemsViewController alloc] init];
    [self presentViewController:pivc animated:YES completion:nil];
}

- (IBAction)foster:(id)sender
{
    FosterViewController *fvc = [[FosterViewController alloc] init];
    [self presentViewController:fvc animated:YES completion:nil];
    //list of animals that need help and how to help them
}

- (IBAction)volunteer:(id)sender
{
    //buttons for all the places that take you to site
    VolunteerViewController *vvc = [[VolunteerViewController alloc] init];
    [self presentViewController:vvc animated:YES completion:nil];
}

- (IBAction)sucessStories:(id)sender
{
    NSLog(@"Success!");
    //list of all the success stories from online
    //only need back button and list that opens it
    SuccessViewController *svc = [[SuccessViewController alloc] init];
    [self presentViewController:svc animated:YES completion:nil];
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
