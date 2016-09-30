//
//  VolunteerViewController.m
//  Paws Alert
//
//  Created by Tyler Weppler on 1/4/16.
//  Copyright © 2016 NerdboyDevelopment. All rights reserved.
//

#import "VolunteerViewController.h"

@interface VolunteerViewController ()

@end

@implementation VolunteerViewController

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

- (IBAction)sawc:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.stillwaterawc.weebly.com"]];
}

- (IBAction)hss:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hspets.org/page/home/volunteer"]];
}

- (IBAction)tp:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://raniamus.wix.com/tinypawrescue#!volunteer/cihc"]];
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
