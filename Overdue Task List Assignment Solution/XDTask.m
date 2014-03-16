//
//  XDTask.m
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import "XDTask.h"

@implementation XDTask

- (id)init
{
    self = [self initWithData:nil];
    return self;
    
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    self.title = data[TASK_TITLE];
    self.description = data[TASK_DESCRIPTION];
    self.date = data[TASK_DATE];
    self.completion = [data[TASK_COMPLETION] boolValue];
    
    return self;
}

- (BOOL)isTaskDatePastCurrent
{
    if ([self.date timeIntervalSince1970] >= [[NSDate date] timeIntervalSince1970]) {
        return NO;
    }
    else {
        return YES;
    }
}

- (NSString *)stringFormattedFromDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm"];
    
    return [formatter stringFromDate:self.date];
}

@end
