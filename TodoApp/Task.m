//
//  Task.m
//  TodoApp
//
//  Created by Mostafa Samir on 12/14/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import "Task.h"

@implementation Task
-(void)FillTask:(NSString*)name:(NSString*)descrip:(NSString*)prior:(NSString*)todo:(NSString*)date:(int)pos
{
    _name=name;
    _desc=descrip;
    _priority=prior;
    _todo=todo;
    _date=date;
    _MyPos=pos;
}
- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.name forKey:@"keyForname"];
    [coder encodeObject:self.desc forKey:@"keyFordesc"];
    [coder encodeObject:self.priority forKey:@"keyForpriority"];
    [coder encodeObject:self.todo forKey:@"keyFortodo"];
    [coder encodeObject:self.date forKey:@"keyFordate"];
    [coder encodeInt:self.MyPos forKey:@"keyForpos"];
    // do same for all property
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [[Task alloc] init];
    if (self != nil)
    {
        self.name = [coder decodeObjectForKey:@"keyForname"];
        self.desc = [coder decodeObjectForKey:@"keyFordesc"];
        self.priority = [coder decodeObjectForKey:@"keyForpriority"];
        self.todo = [coder decodeObjectForKey:@"keyFortodo"];
        self.date = [coder decodeObjectForKey:@"keyFordate"];
        self.MyPos = [coder decodeIntForKey:@"keyForpos"];
    }
    return self;
}
@end
