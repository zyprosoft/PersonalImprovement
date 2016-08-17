//
// Created by Chris Eidhof on 8/13/13.
// Copyright (c) 2013 Chris Eidhof. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PersistentStack.h"


@interface PersistentStack ()

@property (nonatomic,strong,readwrite) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSURL* modelURL;
@property (nonatomic,strong) NSURL* storeURL;

@end

@implementation PersistentStack

- (id)initWithStoreURL:(NSURL*)storeURL modelURL:(NSURL*)modelURL
{
    self = [super init];
    if (self) {
        self.storeURL = storeURL;
        self.modelURL = modelURL;
        [self setupManagedObjectContext];
    }
    return self;
}

- (void)setupManagedObjectContext
{
    // 2、传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    // 3、初始化上下文，设置persistentStoreCoordinator属性
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = coordinator;
    NSError* error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeURL options:nil error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
}

- (NSManagedObjectModel*)managedObjectModel
{
    // 1、 从应用程序包中加载模型文件
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

@end