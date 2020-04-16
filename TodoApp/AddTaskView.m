//
//  AddTaskView.m
//  TodoApp
//
//  Created by Mostafa Samir on 12/14/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import "AddTaskView.h"
#import "Task.h"
#import "Save_Retrieve_Class.h"

@interface AddTaskView ()
@property (weak, nonatomic) IBOutlet UITextField *TaskNameField;
@property (weak, nonatomic) IBOutlet UITextField *TaskDescription;
@property (weak, nonatomic) IBOutlet UISegmentedControl *PrioritySegments;
@property (weak, nonatomic) IBOutlet UISegmentedControl *TodoSegments;
@property (weak, nonatomic) IBOutlet UIButton *TaskButton;
@property (weak, nonatomic) IBOutlet UILabel *MessageLabel;

@end

@implementation AddTaskView
{
    NSMutableArray *todoList;
    NSUserDefaults *def;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)AddTask:(id)sender {
 
    /*def=[NSUserDefaults standardUserDefaults];
    NSData *savedArray = [def objectForKey:@"TodoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            todoList = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            todoList = [[NSMutableArray alloc] init];
        }
    }*/
    todoList=[Save_Retrieve_Class Retrieve_Data];

    
if (![_TaskNameField.text isEqual:@""]&&
    ![_TaskDescription.text isEqual:@""])
{
        
    Task *task=[Task new];
    NSString *name,*des;
    NSString *prior=@"0",*todo=@"0";
    name=_TaskNameField.text;
    des=_TaskDescription.text;
    switch (_PrioritySegments.selectedSegmentIndex) {
        case 0:
            prior=@"h";
            break;
        case 1:
            prior=@"m";
            break;
        case 2:
            prior=@"l";
            break;
    }

    switch (_TodoSegments.selectedSegmentIndex) {
        case 0:
            todo=@"p";
            break;
        case 1:
            todo=@"d";
            break;
    }
    
    [task FillTask:name :des :prior :todo:@"":(int)todoList.count];
    [todoList addObject:task];
    
    [Save_Retrieve_Class Save_Data:todoList];
    [self dismissViewControllerAnimated:YES completion:nil];
}
else
{
    _MessageLabel.text=@"Fill Data";
}
}
- (IBAction)BackButon:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
