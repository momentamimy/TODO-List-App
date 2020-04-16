//
//  Save_Retrieve_Class.m
//  TodoApp
//
//  Created by Mostafa Samir on 12/16/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import "Save_Retrieve_Class.h"
#import "Task.h"

@implementation Save_Retrieve_Class
+(void)Save_Data:(NSMutableArray*)todoList
{
        NSUserDefaults*def=[NSUserDefaults standardUserDefaults];
        [def setObject:[NSKeyedArchiver archivedDataWithRootObject:todoList] forKey:@"TodoList"];
}

+(NSMutableArray*) Retrieve_Data
{
    NSMutableArray *todoList;
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSData *savedArray = [def objectForKey:@"TodoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            todoList = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            todoList = [[NSMutableArray alloc] init];
        }
    }
    else
    {
        todoList = [[NSMutableArray alloc] init];
    }
    return todoList;
}

+(NSMutableArray*) Retrieve_Progress_Data
{
    NSMutableArray *todoList;
    NSUserDefaults*def=[NSUserDefaults standardUserDefaults];
    NSData *savedArray = [def objectForKey:@"TodoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            todoList = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            todoList = [[NSMutableArray alloc] init];
        }
    }
    NSMutableArray *progressList=[NSMutableArray new];
    for (int i=0; i<todoList.count; i++) {
        Task *t=[todoList objectAtIndex:i];
        if ([t.todo isEqual:@"p"]) {
            [progressList addObject:t];
        }
    }
    
    return progressList;
}

+(NSMutableArray*) Retrieve_Done_Data
{
    NSMutableArray *todoList;
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSData *savedArray = [def objectForKey:@"TodoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            todoList = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            todoList = [[NSMutableArray alloc] init];
        }
    }
    NSMutableArray *DoneList=[NSMutableArray new];
    for (int i=0; i<todoList.count; i++) {
        Task *t=[todoList objectAtIndex:i];
        if ([t.todo isEqual:@"d"]) {
            [DoneList addObject:t];
        }
    }
    
    return DoneList;
}
+(NSMutableArray*) Retrieve_High_Data
{
    NSMutableArray *todoList;
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSData *savedArray = [def objectForKey:@"TodoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            todoList = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            todoList = [[NSMutableArray alloc] init];
        }
    }
    NSMutableArray *HighList=[NSMutableArray new];
    for (int i=0; i<todoList.count; i++) {
        Task *t=[todoList objectAtIndex:i];
        if ([t.priority isEqual:@"h"]) {
            [HighList addObject:t];
        }
    }
    return HighList;
}

+(NSMutableArray*) Retrieve_Medium_Data
{
    NSMutableArray *todoList;
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSData *savedArray = [def objectForKey:@"TodoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            todoList = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            todoList = [[NSMutableArray alloc] init];
        }
    }
    NSMutableArray *MediumList=[NSMutableArray new];
    for (int i=0; i<todoList.count; i++) {
        Task *t=[todoList objectAtIndex:i];
        if ([t.priority isEqual:@"m"]) {
            [MediumList addObject:t];
        }
    }
    
    return MediumList;
}

+(NSMutableArray*) Retrieve_Low_Data
{
    NSMutableArray *todoList;
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSData *savedArray = [def objectForKey:@"TodoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            todoList = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            todoList = [[NSMutableArray alloc] init];
        }
    }
    NSMutableArray *LowList=[NSMutableArray new];
    for (int i=0; i<todoList.count; i++) {
        Task *t=[todoList objectAtIndex:i];
        if ([t.priority isEqual:@"l"]) {
            [LowList addObject:t];
        }
    }
    
    return LowList;
}
@end
