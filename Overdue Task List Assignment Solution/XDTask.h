//
//  XDTask.h
//  Overdue Task List Assignment Solution
//
//  Created by Wayne on 14-3-16.
//  Copyright (c) 2014年 iXoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

- (id)initWithData:(NSDictionary *)data;
- (BOOL)isTaskDatePastCurrent;
- (NSString *)stringFormattedFromDate;

@end
