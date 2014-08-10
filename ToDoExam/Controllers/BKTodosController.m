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
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error! %@",error);
        abort();
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    Todo *todo = (Todo *) [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = todo.name;
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteTodoAtIndexPath:indexPath];
    }
}

#pragma mark - Data Handling

- (void)deleteTodoAtIndexPath:(NSIndexPath *)indexPath {
    Todo *todo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.managedObjectContext deleteObject:todo];
    NSError *error;
    if ( !  [[self managedObjectContext]save:&error] ) {
        NSLog(@"An error! %@",error);
    }
}

#pragma mark - Fetched Results Controller

-(NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate: {
            Todo *changedTodo = [self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changedTodo.name;
        }
            break;
    }
    
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
        controller.todo = (Todo *) [self.fetchedResultsController objectAtIndexPath:indexPath];
        controller.managedObjectContext = self.managedObjectContext;
    }
}

- (IBAction)close:(UIStoryboardSegue *)segue {
    
}


@end
