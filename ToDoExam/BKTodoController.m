//
//  BKTodoController.m
//  ToDos
//
//  Created by Bartek Kruszczynski on 13/07/14.
//  Copyright (c) 2014 Bartek Kruszczyńskli. All rights reserved.
//

#import "BKTodoController.h"
#import "BKTodosController.h"

@interface BKTodoController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation BKTodoController

- (void) viewDidLoad {
    self.nameField.text = self.todo.name;
}

#pragma navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.nameField resignFirstResponder];
    self.todo.name = self.nameField.text;
    BKTodosController *controller = (BKTodosController *) [segue destinationViewController];
    NSError *error;
    if ( !  [[self managedObjectContext]save:&error] ) {
        NSLog(@"An error! %@",error);
    } else {
        [controller.tableView reloadData];
    }
}

@end
