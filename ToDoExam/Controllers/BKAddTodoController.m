//
//  BKAddTodoController.m
//  ToDoExam
//
//  Created by Bartek Kruszczynski on 29/07/14.
//  Copyright (c) 2014 Bartek Kruszczynski. All rights reserved.
//

#import "BKAddTodoController.h"
#import "BKTodosController.h"
#import "Todo.h"

@interface BKAddTodoController ()
@property (nonatomic) BOOL isSubmitted;
@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation BKAddTodoController

- (void)viewDidLoad {
    self.isSubmitted = NO;
}
- (IBAction)addTodo:(id)sender {
    self.isSubmitted = YES;
}

#pragma navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (self.isSubmitted) {
        Todo *newTodo = (Todo *)[NSEntityDescription
                                 insertNewObjectForEntityForName:@"Todo"
                                 inManagedObjectContext:[self managedObjectContext]];
        
        newTodo.name = self.name.text;
        NSError *error = nil;
        
        if ( !  [[self managedObjectContext]save:&error] ) {
            NSLog(@"An error! %@",error);
        }
    }
}


@end
