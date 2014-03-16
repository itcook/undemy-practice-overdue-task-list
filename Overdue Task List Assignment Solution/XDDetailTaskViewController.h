//
//  XDDetailTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDTask.h"
#import "XDEditTaskViewController.h"

@protocol XDDetailTaskViewControllerDelegate <NSObject>

- (void)updateTask;

@end

@interface XDDetailTaskViewController : UIViewController <XDEditTaskViewControllerDelegate>

@property (strong, nonatomic) XDTask *task;
@property (weak, nonatomic) id <XDDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionLabel;

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;
@end
