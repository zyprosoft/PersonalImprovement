//
//  Item.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/4/15.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "Item.h"


@implementation Item

@dynamic title;
@dynamic parent;
@dynamic children;
@dynamic order;

+ (instancetype)insertItemWithTitle:(NSString*)title
                             parent:(Item*)parent
             inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSUInteger order = parent.numberOfChildren;
    // 先传入上下文，创建一个Item实体对象
    Item* item = [NSEntityDescription insertNewObjectForEntityForName:self.entityName
                                               inManagedObjectContext:managedObjectContext];
    // 对传入的对象赋值
    item.title = title;
    item.parent = parent;
    item.order = @(order);
    return item;
}

+ (NSString*)entityName
{
    return @"Item";
}

- (NSUInteger)numberOfChildren
{
    return self.children.count;
}

- (NSFetchedResultsController*)childrenFetchedResultsController
{
    // 初始化一个查询请求
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:[self.class entityName]];
    
//    // 设置要查询的实体
//    request.entity = [NSEntityDescription entityForName:@"Person"inManagedObjectContext:context];
    
    // 设置条件过滤
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", self];
    // 设置排序（按照age降序）
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]];
    // 执行查询请求
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void)prepareForDeletion
{
    if (self.parent.isDeleted) return;
    
    NSSet* siblings = self.parent.children;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"order > %@", self.order];
    NSSet* itemsAfterSelf = [siblings filteredSetUsingPredicate:predicate];
    [itemsAfterSelf enumerateObjectsUsingBlock:^(Item* sibling, BOOL* stop)
     {
         sibling.order = @(sibling.order.integerValue - 1);
     }];
}

@end
