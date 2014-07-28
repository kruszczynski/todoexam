//
//  BKAppDelegate.h
//  ToDoExam
//
//  Created by Bartek Kruszczynski on 29/07/14.
//  Copyright (c) 2014 Bartek Kruszczynski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
