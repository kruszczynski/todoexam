//
//  BKTodosController.m
//  ToDoExam
//
//  Created by Bartek Kruszczynski on 29/07/14.
//  Copyright (c) 2014 Bartek Kruszczynski. All rights reserved.
//

#import "BKTodosController.h"
#import "BKTodoController.h"
#import "BKAddTodoController.h"
#import "Todo.h"

@interface BKTodosController ()
@end

@implementation BKTodosController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchTodos];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    Todo *todo = (Todo *)self.todos[indexPath.row];
    cell.textLabel.text = todo.name;
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteTodoAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Data Handling

- (void)deleteTodoAtIndexPath:(NSIndexPath *)indexPath {
    Todo *todo = (Todo *)self.todos[indexPath.row];
    [self.managedObjectContext deleteObject:todo];
    NSError *error;
    if ( !  [[self managedObjectContext]save:&error] ) {
        NSLog(@"An error! %@",error);
    } else {
        [self fetchTodos];
    }
}

- (void)fetchTodos {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    self.todos = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddTodoSegue"]) {
        BKAddTodoController *controller = (BKAddTodoController *)[segue destinationViewController];
        controller.managedObjectContext = self.managedObjectContext;
    } else if ([segue.identifier isEqualToString:@"TodoDetails"]) {
        BKTodoController *controller = (BKTodoController *) [segue destinationViewController];
        UITableViewCell *cell = (UITableViewCell *) sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        controller.todo = self.todos[indexPath.row];
        controller.managedObjectContext = self.managedObjectContext;
    }
}

- (IBAction)close:(UIStoryboardSegue *)segue {
    
}


@end
