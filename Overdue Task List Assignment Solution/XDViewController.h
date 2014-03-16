//
//  XDViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDDetailTaskViewController.h"
#import "XDAddTaskViewController.h"

@interface XDViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, addTaskViewControllerDelegate, XDDetailTaskViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *taskObjects;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender;


@end
