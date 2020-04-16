//
//  DoneView.m
//  TodoApp
//
//  Created by Mostafa Samir on 12/14/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import "DoneView.h"
#import "AddTaskView.h"
#import "Task.h"
#import "TaskDetailsView.h"
#import "Save_Retrieve_Class.h"
@interface DoneView ()
@property (weak, nonatomic) IBOutlet UITableView *tabl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation DoneView
{
    NSMutableArray *DoneList,*FilteredTasks;
    Boolean isFiltered;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate=self;
    FilteredTasks =[NSMutableArray new];
    isFiltered=NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    DoneList=[Save_Retrieve_Class Retrieve_Done_Data];
    [_tabl reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0) {
        isFiltered=NO;
        [_tabl reloadData];
    }
    else
    {
        FilteredTasks.removeAllObjects;
        isFiltered=YES;
        
        for (Task *task in DoneList) {
            NSRange range = [task.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (range.location != NSNotFound) {
                [FilteredTasks addObject:task];
            }
        }
        [_tabl reloadData];
    }
}


- (IBAction)AddTask:(id)sender {
    AddTaskView *view=[self.storyboard instantiateViewControllerWithIdentifier:@"AddTask"];
    [self presentViewController:view animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFiltered) {
        return FilteredTasks.count;
    }
    return DoneList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoneCell" forIndexPath:indexPath];
    Task *task;
    if (isFiltered) {
        task=[FilteredTasks objectAtIndex:indexPath.row];
    }
    else
    {
        task=[DoneList objectAtIndex:indexPath.row];
    }
    UIImage *img = [UIImage imageNamed:@"high.png"];
    
    if ([task.priority isEqual:@"h"]) {
        img = [UIImage imageNamed:@"high.png"];
    }
    else if ([task.priority isEqual:@"m"]) {
        img = [UIImage imageNamed:@"medium.png"];
    }
    else if ([task.priority isEqual:@"l"]) {
        img = [UIImage imageNamed:@"low.png"];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %d", task.name,task.MyPos];
    cell.imageView.image=img;
    
    cell.accessoryType= UITableViewCellAccessoryDetailButton;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    printf("accessory Tapped");
    TaskDetailsView *view=[self.storyboard instantiateViewControllerWithIdentifier:@"TaskDetails"];
    if (isFiltered) {
        [view setMyTask:[FilteredTasks objectAtIndex:indexPath.row]];
    }
    else
    {
        [view setMyTask:[DoneList objectAtIndex:indexPath.row]];
    }

    [self presentViewController:view animated:YES completion:nil];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *t;
        if (isFiltered) {
            t=[FilteredTasks objectAtIndex:indexPath.row];
            [FilteredTasks removeObjectAtIndex:indexPath.row];
        }
        else
        {
            t=[DoneList objectAtIndex:indexPath.row];
            [DoneList removeObjectAtIndex:indexPath.row];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self deleteTask:t];
    }
}

-(void) deleteTask :(Task*)t
{
    NSMutableArray *TodoList=[Save_Retrieve_Class Retrieve_Data];
    [TodoList removeObjectAtIndex:t.MyPos];
    for (int i = t.MyPos; i<TodoList.count ; i++) {
        Task *task=[TodoList objectAtIndex:i];
        [task setMyPos:--task.MyPos];
        [TodoList replaceObjectAtIndex:i withObject:task];
    }
    [Save_Retrieve_Class Save_Data:TodoList];
    DoneList=[Save_Retrieve_Class Retrieve_Done_Data];
}
@end
