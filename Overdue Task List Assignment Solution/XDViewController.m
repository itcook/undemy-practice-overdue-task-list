//
//  XDViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import "XDViewController.h"
#import "XDAddTaskViewController.h"
#import "XDDetailTaskViewController.h"

@interface XDViewController () <addTaskViewControllerDelegate>

@end


@implementation XDViewController

- (NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

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
	// Do any additional setup after loading the view, typically from a nib.
    
    for (NSDictionary *taskProperties in [self taskObjectsFromNSUserDefaults]) {
        XDTask *task = [[XDTask alloc] init];
        [self.taskObjects addObject:[task initWithData:taskProperties]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initTableView
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    XDTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //    NSString *taskDate = [dateFormatter stringFromDate:task.date];
    cell.detailTextLabel.text = [task stringFormattedFromDate];
    if ([task isTaskDatePastCurrent]) {
        cell.backgroundColor = [UIColor redColor];
    }
    else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    if (task.completion) {
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateCompletionOfTask:self.taskObjects[indexPath.row] forIndexPath:indexPath];
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *) tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self removeTaskforIndexPath:indexPath];
    //    [self.tableView reloadData];
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeTaskforIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"pushSegueFromViewControllerToTaskDetailViewController" sender:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    XDTask *taskObject = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    
    [self saveTasks];
}

#pragma mark - IBActions
- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender
{
    if (self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
    }
}

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"modalSegueFromViewControllerToAddTaskViewController" sender:sender];
}

#pragma mark - propareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[XDAddTaskViewController class]] && [sender isKindOfClass:[UIBarButtonItem class]]) {
        XDAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    
    if ([segue.destinationViewController isKindOfClass:[XDDetailTaskViewController class]] && [sender isKindOfClass:[NSIndexPath class]]) {
        XDDetailTaskViewController *taskDetailVC = segue.destinationViewController;
        NSIndexPath *path = sender;
        taskDetailVC.task = self.taskObjects[path.row];
        taskDetailVC.delegate = self;
    }
}

#pragma mark - addTaskViewController Delegate methods
- (void)didAddTask:(XDTask *)task
{
    [self.taskObjects addObject:task];
    [self saveTasks];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - XDDetailTaskViewController Delegate Methods

- (void)updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
}

#pragma mark - helper methods

- (NSMutableArray *)taskObjectsFromNSUserDefaults
{
    NSArray *taskObjectsInNSUserDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_FOR_SAVE];
    
    if (!taskObjectsInNSUserDefaults) {
        NSMutableArray *taskObjects = [[NSMutableArray alloc] init];
        return taskObjects;
    }
    else {
        NSMutableArray *taskObjects = [taskObjectsInNSUserDefaults mutableCopy];
        return taskObjects;
    }
}

- (NSDictionary *)taskObjectAsPropertyList:(XDTask *)taskObject
{
    NSParameterAssert(taskObject);
    NSDictionary *taskPropertyList = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.description, TASK_DATE : taskObject.date, TASK_COMPLETION : [NSNumber numberWithBool:taskObject.completion]};
    return taskPropertyList;
}

- (void)updateCompletionOfTask:(XDTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    task.completion = !task.completion;
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    [self.taskObjects insertObject:task atIndex:indexPath.row];
    
    [self saveTasks];
    
}

- (void)removeTaskforIndexPath:(NSIndexPath *)indexPath
{
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    [self saveTasks];
}

- (void)saveTasks
{
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.taskObjects count]; x ++) {
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:self.taskObjects[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_FOR_SAVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
