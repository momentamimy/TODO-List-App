//
//  PriorityView.m
//  TodoApp
//
//  Created by Mostafa Samir on 12/17/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import "PriorityView.h"
#import "AddTaskView.h"
#import "Task.h"
#import "TaskDetailsView.h"
#import "Save_Retrieve_Class.h"

@interface PriorityView ()
@property (weak, nonatomic) IBOutlet UITableView *tabl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *PrioritySegments;
@end

@implementation PriorityView
{
    NSMutableArray *priorityList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    int index=(int)[_PrioritySegments selectedSegmentIndex];
    if (index==0) {
            priorityList=[Save_Retrieve_Class Retrieve_High_Data];
    }
    else if(index==1)
    {
            priorityList=[Save_Retrieve_Class Retrieve_Medium_Data];
    }
    else if(index==2)
    {
            priorityList=[Save_Retrieve_Class Retrieve_Low_Data];
    }
    else
    {
        priorityList=[Save_Retrieve_Class Retrieve_Data];
    }
    [_tabl reloadData];
}
- (IBAction)SegmentClick:(id)sender {
    int index=(int)[_PrioritySegments selectedSegmentIndex];
    if (index==0) {
        priorityList=[Save_Retrieve_Class Retrieve_High_Data];
    }
    else if(index==1)
    {
        priorityList=[Save_Retrieve_Class Retrieve_Medium_Data];
    }
    else if(index==2)
    {
        priorityList=[Save_Retrieve_Class Retrieve_Low_Data];
    }
    else
    {
        priorityList=[Save_Retrieve_Class Retrieve_Data];
    }
    [_tabl reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return priorityList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriorityCell" forIndexPath:indexPath];
    Task *task=[priorityList objectAtIndex:indexPath.row];
    UIImage *img = [UIImage imageNamed:@"high.png"];;
    
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
    [view setMyTask:[priorityList objectAtIndex:indexPath.row]];
    [self presentViewController:view animated:YES completion:nil];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Task *t=[priorityList objectAtIndex:indexPath.row];
        
        [priorityList removeObjectAtIndex:indexPath.row];
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

    int index=(int)[_PrioritySegments selectedSegmentIndex];
    if (index==0) {
        priorityList=[Save_Retrieve_Class Retrieve_High_Data];
    }
    else if(index==1)
    {
        priorityList=[Save_Retrieve_Class Retrieve_Medium_Data];
    }
    else if(index==2)
    {
        priorityList=[Save_Retrieve_Class Retrieve_Low_Data];
    }
}
@end
