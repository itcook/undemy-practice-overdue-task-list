//
//  XDEditTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import "XDEditTaskViewController.h"

@interface XDEditTaskViewController ()

@end

@implementation XDEditTaskViewController

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
    self.taskTitleTextField.text = self.task.title;
    self.taskDescriptionTextView.text = self.task.description;
    self.taskDatePicker.date = self.task.date;
    self.taskTitleTextField.delegate = self;
    self.taskDescriptionTextView.delegate = self;
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

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender
{
    [self updateTask];
    [self.delegate didUpdateTask];
}

#pragma mark - UITextView Delegate Methods
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.taskDescriptionTextView resignFirstResponder];
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - UITextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTitleTextField resignFirstResponder];
    return YES;
}

#pragma mark - helper methods
- (void)updateTask
{
    self.task.title = self.taskTitleTextField.text;
    self.task.description = self.taskDescriptionTextView.text;
    self.task.date = self.taskDatePicker.date;
    self.task.completion = NO;
    
}
@end
