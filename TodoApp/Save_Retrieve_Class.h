//
//  Save_Retrieve_Class.h
//  TodoApp
//
//  Created by Mostafa Samir on 12/16/19.
//  Copyright © 2019 momen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Save_Retrieve_Class : NSObject

+(void)Save_Data:(NSMutableArray*)todoList;
+(NSMutableArray*) Retrieve_Data;
+(NSMutableArray*) Retrieve_Progress_Data;
+(NSMutableArray*) Retrieve_Done_Data;
+(NSMutableArray*) Retrieve_High_Data;
+(NSMutableArray*) Retrieve_Medium_Data;
+(NSMutableArray*) Retrieve_Low_Data;
@end

NS_ASSUME_NONNULL_END
