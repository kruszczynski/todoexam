//
//  BKTodoCellController.m
//  ToDoExam
//
//  Created by Bartek Kruszczynski on 10/08/14.
//  Copyright (c) 2014 Bartek Kruszczynski. All rights reserved.
//

#import "BKAppDelegate.h"
#import "BKTodoCellController.h"

@implementation BKTodoCellController
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)doneChanged:(UISwitch *)sender {
    self.todo.done = [NSNumber numberWithBool:self.doneSwitch.on];
    [self saveContext];
}

- (void)saveContext {
    BKAppDelegate *delegate = (BKAppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
}

- (void)setTodo:(Todo *)todo {
    _todo = todo;
    self.nameLabel.text = todo.name;
    [self.doneSwitch setOn:[todo.done boolValue] animated:NO];
}
@end
