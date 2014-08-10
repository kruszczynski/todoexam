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
@property (weak, nonatomic) IBOutlet UISwitch *doneSwitch;

@end

@implementation BKTodoController

- (void) viewDidLoad {
    self.nameField.text = self.todo.name;
    [self.doneSwitch setOn: [self.todo.done boolValue] animated:NO];
}

#pragma navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.nameField resignFirstResponder];
    self.todo.name = self.nameField.text;
    self.todo.done = [NSNumber numberWithBool:self.doneSwitch.on];
    NSError *error;
    if ( !  [[self managedObjectContext]save:&error] ) {
        NSLog(@"An error! %@",error);
    }
}

@end
