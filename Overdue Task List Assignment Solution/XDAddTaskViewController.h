//
//  XDAddTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDTask.h"

@protocol addTaskViewControllerDelegate <NSObject>

- (void)didAddTask:(XDTask *)task;
- (void)didCancel;

@end

@interface XDAddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak,nonatomic) id <addTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;


@end
