//
//  TodoView.m
//  TodoApp
//
//  Created by Mostafa Samir on 12/14/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import "TodoView.h"
#import "AddTaskView.h"
#import "Task.h"
#import "TaskDetailsView.h"
#import "Save_Retrieve_Class.h"
@interface TodoView ()
@property (weak, nonatomic) IBOutlet UITableView *TableTodo;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;

@end

@implementation TodoView
{
    NSMutableArray *TodoList,*FilteredTasks;
    Boolean isFiltered;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.SearchBar.delegate=self;
    FilteredTasks =[NSMutableArray new];
    isFiltered=NO;
}

- (void) viewWillAppear:(BOOL)animated
{
    TodoList=[Save_Retrieve_Class Retrieve_Data];
    [_TableTodo reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0) {
        isFiltered=NO;
        printf("no");
    [_TableTodo reloadData];
    }
    else
    {
        FilteredTasks.removeAllObjects;
        isFiltered=YES;
        printf("yes");
        for (Task *task in TodoList) {
            
            NSRange range = [task.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (range.location != NSNotFound) {
                
                [FilteredTasks addObject:task];
            }
            
        }
    
        [_TableTodo reloadData];
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
    return TodoList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    Task *task;
    if (isFiltered) {
        task = [FilteredTasks objectAtIndex:indexPath.row];
        cell.textLabel.text=task.name;
    }
    else
    {
    task=[TodoList objectAtIndex:indexPath.row];
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
        [view setMyTask:[TodoList objectAtIndex:indexPath.row]];
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
            t=[TodoList objectAtIndex:indexPath.row];
        [TodoList removeObjectAtIndex:indexPath.row];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self deleteTask:t];
    }
}

-(void) deleteTask :(Task*)t
{
    NSMutableArray *todoList=[Save_Retrieve_Class Retrieve_Data];
    [todoList removeObjectAtIndex:t.MyPos];
    for (int i = t.MyPos; i<todoList.count ; i++) {
        Task *task=[todoList objectAtIndex:i];
        [task setMyPos:--task.MyPos];
        [todoList replaceObjectAtIndex:i withObject:task];
    }
    [Save_Retrieve_Class Save_Data:todoList];
    TodoList=[Save_Retrieve_Class Retrieve_Data];
}
/*
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    <#code#>
}
*/
/*
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}
*/
/*
- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}
*/
/*
- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    <#code#>
}
*/
/*
- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}
*/
/*

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}
*/
@end
