//
//  XDDetailTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import "XDDetailTaskViewController.h"

@interface XDDetailTaskViewController ()

@end

@implementation XDDetailTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskTitleLabel.text = self.task.title;
    self.taskDateLabel.text = [self.task stringFormattedFromDate];
    self.taskDescriptionLabel.text = self.task.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - IBActions
- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"pushSegueFromTaskDetailControllerToEditTaskController" sender:sender];
}

#pragma mark - prepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[XDEditTaskViewController class]] && [sender isKindOfClass:[UIBarButtonItem class]]) {
        XDEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
    }
}

#pragma mark - XDEditTaskViewController Delegate Methods
- (void)didUpdateTask
{
    self.taskTitleLabel.text = self.task.title;
    self.taskDescriptionLabel.text = self.task.description;
    self.taskDateLabel.text = [self.task stringFormattedFromDate];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTask];
}
@end
