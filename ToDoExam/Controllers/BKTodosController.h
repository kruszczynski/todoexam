//
//  BKTodosController.h
//  ToDoExam
//
//  Created by Bartek Kruszczynski on 29/07/14.
//  Copyright (c) 2014 Bartek Kruszczynski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKTodosController : UITableViewController
@property (strong, nonatomic) NSArray *todos;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)fetchTodos;

@end
