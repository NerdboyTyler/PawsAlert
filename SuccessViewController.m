//
//  SuccessViewController.m
//  Paws Alert
//
//  Created by Tyler Weppler on 1/4/16.
//  Copyright © 2016 NerdboyDevelopment. All rights reserved.
//

#import "SuccessViewController.h"
#import "LostFoundViewController.h"

@interface SuccessViewController ()

@property (strong) Kumulos *k;
@property (strong) NSMutableArray *pictureListData;
@property (strong) UIActivityIndicatorView *indicator;

@end
//GET METHODS FROM OTHER APP
@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.k = [[Kumulos alloc] init];
    [self.k setDelegate:self];
    self.pictureListData = [[NSMutableArray alloc] init];
    
    //uiactivityindicator
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [self.view addSubview:self.indicator];
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self.k getSuccessTable];
    //[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.k getSuccessTable];
    [self.tableView reloadData];
    [self.indicator startAnimating];
}

- (void)kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getSuccessTableDidCompleteWithResult:(NSArray *)theResults
{
    [self.pictureListData removeAllObjects];
    [self.pictureListData addObjectsFromArray:theResults];
    [self.tableView reloadData];
    [self.indicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    //return [self.stringDescription count];
    return [self.pictureListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    //NSLog(@"%@", self.pictureListData);
    cell.textLabel.text = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.detailTextLabel.text = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"subtitle"];
    NSData *imageData = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"imageData"];
    cell.imageView.image = [UIImage imageWithData:imageData];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *thisImageData = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"imageData"];
    UIImage *imageToSend = [UIImage imageWithData:thisImageData];
    LostFoundViewController *lfvc = [[LostFoundViewController alloc] initWithNibName:nil bundle:nil petType:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"title"] name:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"subtitle"] details:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"description"] andPetImage:imageToSend andIDNumber:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"successTableID"] withButton:@"NO"];
    [self presentViewController:lfvc animated:YES completion:nil];
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
