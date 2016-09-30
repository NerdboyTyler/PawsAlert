//
//  PetItemsViewController.m
//  Paws Alert
//
//  Created by Tyler Weppler on 1/1/16.
//  Copyright © 2016 NerdboyDevelopment. All rights reserved.
//

#import "PetItemsViewController.h"

@interface PetItemsViewController ()
@property (strong) Kumulos *k;
@property (strong) NSMutableArray *itemList;

@end

@implementation PetItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.k = [[Kumulos alloc] init];
    [self.k setDelegate:self];
    self.itemList = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.k getPetItemsTable];
}

- (void)kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getPetItemsTableDidCompleteWithResult:(NSArray *)theResults
{
    [self.itemList removeAllObjects];
    [self.itemList addObjectsFromArray:theResults];
    long count = self.itemList.count;
    NSString *itemsString = @"";
    NSString *newString = itemsString;
    for(long i = 0; i < count; i++)
    {
        newString = [[self.itemList objectAtIndex:i] valueForKey:@"item"];
        newString = [newString stringByAppendingString:@"\n"];
        itemsString = [newString stringByAppendingString:[NSString stringWithFormat:@"%@", itemsString]];
    }
    self.petItemsTextView.text = itemsString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
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
