//
//  PawsTableViewController.m
//  Paws Alert
//
//  Created by Tyler Weppler on 6/28/15.
//  Copyright (c) 2015 NerdboyDevelopment. All rights reserved.
//

#import "PawsTableViewController.h"
#import "LostFoundViewController.h"

@interface PawsTableViewController ()

@property (nonatomic) UIBarButtonItem *pawButton;
@property (nonatomic) UIBarButtonItem *helpButton;
/*@property (strong) NSMutableArray *petArray;
@property (strong) NSMutableArray *nameArray;
@property (strong) NSMutableArray *detailsArray;
@property (strong) NSMutableArray *imageArray;*/
@property (strong) Kumulos *k;
@property (strong) NSMutableArray *pictureListData;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation PawsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.k = [[Kumulos alloc] init];
    [self.k setDelegate:self];
    self.pictureListData = [[NSMutableArray alloc] init];
    
    self.title = @"Paws Alert";
    /*self.petArray = [[NSMutableArray alloc] init];
    self.nameArray = [[NSMutableArray alloc] init];
    self.detailsArray = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];*/
    UIColor *prettyBlue = [[UIColor alloc] initWithRed:132.0f/255.0f green:147.0f/255.0f blue:243.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = prettyBlue;
    self.navigationController.navigationBarHidden = NO;
    self.pawButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"brownPaw.png"] style:UIBarButtonItemStylePlain target:self action:@selector(paws:)];
    //self.pawButton = [[UIBarButtonItem alloc] initWithTitle:@"Paw" style:UIBarButtonItemStylePlain target:self action:@selector(paws:)];
    self.helpButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(helpAPet:)];
    self.helpButton.tintColor = [UIColor brownColor];
    self.navigationItem.leftBarButtonItem = self.helpButton;
    self.pawButton.tintColor = [UIColor brownColor];
    self.navigationItem.rightBarButtonItem = self.pawButton;
    
    //uiactivityindicator
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [self.view addSubview:self.indicator];
    
    //pull to refresh code
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = prettyBlue;
    self.refreshControl.tintColor = [UIColor brownColor];
    [self.refreshControl addTarget:self action:@selector(getData) forControlEvents:UIControlEventValueChanged];
}

- (void)getData
{
    [self.k getLostFoundTable];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self.k getLostFoundTable];
    //[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.k getLostFoundTable];
    [self.tableView reloadData];
    [self.indicator startAnimating];
}

- (void)kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getLostFoundTableDidCompleteWithResult:(NSArray *)theResults
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.pictureListData count];
}

- (IBAction)paws:(id)sender
{
    PetViewController *pvc = [[PetViewController alloc] init];
    [self.navigationController presentViewController:pvc animated:YES completion:nil];
}

- (IBAction)helpAPet:(id)sender
{
    HelpViewController *hvc = [[HelpViewController alloc] init];
    [self.navigationController presentViewController:hvc animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    //NSLog(@"%@", self.pictureListData);
    cell.textLabel.text = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.detailTextLabel.text = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSData *imageData = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"imageData"];
    cell.imageView.image = [UIImage imageWithData:imageData];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    NSData *thisImageData = [[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"imageData"];
    UIImage *imageToSend = [UIImage imageWithData:thisImageData];
    LostFoundViewController *lfvc = [[LostFoundViewController alloc] initWithNibName:nil bundle:nil petType:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"title"] name:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"name"] details:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"details"] andPetImage:imageToSend andIDNumber:[[self.pictureListData objectAtIndex:indexPath.row] valueForKey:@"lostFoundTableID"] withButton:@"YES"];
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
