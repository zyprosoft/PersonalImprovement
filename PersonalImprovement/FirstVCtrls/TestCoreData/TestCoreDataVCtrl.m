//
//  TestCoreDataVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/4/14.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "TestCoreDataVCtrl.h"
#import "TableVDatasource.h"
#import "PersistentStack.h"
#import "Store.h"
#import "Item.h"

static NSString* const selectItemSegue = @"selectItem";

@interface TestCoreDataVCtrl ()<DataSourceDelegate, UITextFieldDelegate>

@property (nonatomic, strong) TableVDatasource* tableVDatasource;
@property (nonatomic, strong) UITextField* titleField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)Store *store;
@property (strong,nonatomic)PersistentStack *stack;

@end

@implementation TestCoreDataVCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    if (self.navigationController.viewControllers.count == 2) {
        self.store = [[Store alloc] init];
        self.stack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
        self.store.managedObjectContext = self.stack.managedObjectContext;
        self.parent = self.store.rootItem;
    }
    
    [self setupFetchedResultsController];
    [self setupNewItemField];
    
}

- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"TestCoreData" withExtension:@"momd"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.tableView numberOfRowsInSection:0] > 0) {
        [self hideNewItemField];
    }
    self.tableVDatasource.paused = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableVDatasource.paused = YES;
    
    // 利用上下文对象，将数据同步到持久化存储库
    [self.store.managedObjectContext save:NULL];
}


- (void)setupFetchedResultsController
{
    self.tableVDatasource = [[TableVDatasource alloc] initWithTableView:self.tableView identifier:@"cell"];
    self.tableVDatasource.fetchedResultsController = self.parent.childrenFetchedResultsController;
    self.tableVDatasource.delegate = self;
}

- (void)setupNewItemField
{
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    self.titleField.delegate = self;
    self.titleField.placeholder = NSLocalizedString(@"Add a new item", @"Placeholder text for adding a new item");
    self.tableView.tableHeaderView = self.titleField;
}

#pragma mark Fetched Results Controller Delegate

- (void)configureCell:(id)theCell withObject:(id)object
{
    UITableViewCell* cell = theCell;
    Item* item = object;
    cell.textLabel.text = item.title;
}

- (void)deleteObject:(id)object
{
    Item* item = object;
    NSString* actionName = [NSString stringWithFormat:NSLocalizedString(@"Delete \"%@\"", @"Delete undo action name"), item.title];
    [self.undoManager setActionName:actionName];
    
    // 传入需要删除的实体对象
    [item.managedObjectContext deleteObject:item];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCoreDataVCtrl *ctrl = [[TestCoreDataVCtrl alloc]initWithNibName:@"TestCoreDataVCtrl" bundle:nil];
    Item* item = [self.tableVDatasource selectedItem];
    ctrl.parent = item;
    [self.navigationController pushViewController:ctrl animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSString* title = textField.text;
    NSString* actionName = [NSString stringWithFormat:NSLocalizedString(@"add item \"%@\"", @"Undo action name of add item"), title];
    [self.undoManager setActionName:actionName];
    [Item insertItemWithTitle:title parent:self.parent inManagedObjectContext:self.managedObjectContext];
    textField.text = @"";
    [textField resignFirstResponder];
    [self hideNewItemField];
    return NO;
}

- (NSManagedObjectContext*)managedObjectContext
{
    return self.parent.managedObjectContext;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if (-scrollView.contentOffset.y > self.titleField.bounds.size.height) {
        [self showNewItemField];
    } else if (scrollView.contentOffset.y > 0) {
        [self hideNewItemField];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset
{
    BOOL itemFieldVisible = self.tableView.contentInset.top == 0;
    if (itemFieldVisible) {
        [self.titleField becomeFirstResponder];
    }
}

- (void)showNewItemField
{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = 0;
    self.tableView.contentInset = insets;
}

- (void)hideNewItemField
{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = -self.titleField.bounds.size.height;
    self.tableView.contentInset = insets;
}

- (void)setParent:(Item*)parent
{
    _parent = parent;
    self.navigationItem.title = parent.title;
}

#pragma mark Undo

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSUndoManager*)undoManager
{
    return self.managedObjectContext.undoManager;
}


@end
