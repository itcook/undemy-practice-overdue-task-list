//
//  XDAddTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import "XDAddTaskViewController.h"

@interface XDAddTaskViewController ()

@end

@implementation XDAddTaskViewController

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
    self.taskDescriptionTextView.delegate = self;
    self.taskTitleTextField.delegate = self;
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

- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    [self.delegate didAddTask:[self returnNewTaskObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
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

- (XDTask *)returnNewTaskObject
{
    XDTask *task = [[XDTask alloc] init];
    task.title = self.taskTitleTextField.text;
    task.description = self.taskDescriptionTextView.text;
    task.date = self.taskDatePicker.date;
    task.completion = NO;
    
    return task;
}

@end