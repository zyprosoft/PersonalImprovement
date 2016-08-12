//
//  Item.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/4/15.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) NSNumber* order;
@property (nonatomic, retain) Item* parent;
@property (nonatomic, retain) NSSet* children;

+ (instancetype)insertItemWithTitle:(NSString*)title
                             parent:(Item*)parent
             inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (NSFetchedResultsController*)childrenFetchedResultsController;

@end