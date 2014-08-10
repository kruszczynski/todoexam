//
//  BKTodoCellController.h
//  ToDoExam
//
//  Created by Bartek Kruszczynski on 10/08/14.
//  Copyright (c) 2014 Bartek Kruszczynski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface BKTodoCellController : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *doneSwitch;
@property (copy, nonatomic) Todo *todo;
- (IBAction)doneChanged:(UISwitch *)sender;

@end
