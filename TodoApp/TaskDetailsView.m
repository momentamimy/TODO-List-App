//
//  TaskDetailsView.m
//  TodoApp
//
//  Created by Mostafa Samir on 12/15/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import "TaskDetailsView.h"
#import "Task.h"
#import "Save_Retrieve_Class.h"

@interface TaskDetailsView ()
@property (weak, nonatomic) IBOutlet UITextField *NameField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *PriorSegments;
@property (weak, nonatomic) IBOutlet UISegmentedControl *TdSegments;
@property (weak, nonatomic) IBOutlet UITextField *descField;


@end

@implementation TaskDetailsView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    _NameField.text=_MyTask.name;
    _descField.text=_MyTask.desc;
    if ([_MyTask.priority isEqual:@"h"]) {
        [_PriorSegments setSelectedSegmentIndex:0];
    }
    else if ([_MyTask.priority isEqual:@"m"]) {
        [_PriorSegments setSelectedSegmentIndex:1];
    }
    else if ([_MyTask.priority isEqual:@"l"]) {
        [_PriorSegments setSelectedSegmentIndex:2];
    }
    
    if ([_MyTask.todo isEqual:@"p"]) {
        [_TdSegments setSelectedSegmentIndex:0];
    }
    else if ([_MyTask.todo isEqual:@"d"]) {
        [_TdSegments setSelectedSegmentIndex:1];
    }
}
- (IBAction)EditButtonClicked:(id)sender {
    NSMutableArray *todoList=[Save_Retrieve_Class Retrieve_Data];
    
    NSString *name,*des;
    NSString *prior=@"0",*todo=@"0";
    name=_NameField.text;
    des=_descField.text;
    switch (_PriorSegments.selectedSegmentIndex) {
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
    
    switch (_TdSegments.selectedSegmentIndex) {
        case 0:
            todo=@"p";
            break;
        case 1:
            todo=@"d";
            break;
    }

    [_MyTask FillTask:name :des :prior :todo:@"":_MyTask.MyPos];


    [todoList replaceObjectAtIndex:_MyTask.MyPos withObject:_MyTask];
    [Save_Retrieve_Class Save_Data:todoList];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
