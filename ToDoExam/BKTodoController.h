//
//  BKTodoController.h
//  ToDos
//
//  Created by Bartek Kruszczynski on 13/07/14.
//  Copyright (c) 2014 Bartek Kruszczyńskli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface BKTodoController : UIViewController

@property (strong, nonatomic) Todo *todo;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
