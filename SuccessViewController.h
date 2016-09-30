//
//  SuccessViewController.h
//  Paws Alert
//
//  Created by Tyler Weppler on 1/4/16.
//  Copyright © 2016 NerdboyDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"

@interface SuccessViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
