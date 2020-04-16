//
//  Task.h
//  TodoApp
//
//  Created by Mostafa Samir on 12/14/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject

@property NSString *name;
@property NSString *desc;
@property NSString *priority;
@property NSString *todo;
@property NSString *date;
@property int MyPos;

-(void)FillTask:(NSString*)name:(NSString*)descrip:(NSString*)prior:(NSString*)todo:(NSString*)date:(int)pos;
@end

NS_ASSUME_NONNULL_END
