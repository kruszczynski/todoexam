//
//  Todo.h
//  ToDoExam
//
//  Created by Bartek Kruszczynski on 29/07/14.
//  Copyright (c) 2014 Bartek Kruszczynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * name;

@end
