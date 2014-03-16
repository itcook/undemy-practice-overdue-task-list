//
//  XDEditTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDTask.h"

@protocol XDEditTaskViewControllerDelegate <NSObject>

- (void)didUpdateTask;

@end


@interface XDEditTaskViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) XDTask *task;
@property (weak, nonatomic) id <XDEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;
@end