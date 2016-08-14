/**************************************************************************
 async
**************************************************************************/
---
title: "dispatch_async Pattern for Background Processing"
summary: "Dispatch to do work in the background, and then to the main queue with the results"
completion-scope: Function or Method
---

dispatch_async(dispatch_get_global_queue(<#dispatch_queue_priority_t priority#>, <#unsigned long flags#>), ^(void) {
    <#code#>

    dispatch_async(dispatch_get_main_queue(), ^(void) {
        <#code#>
    });
});

/**************************************************************************
cdfetch
**************************************************************************/
---
title: "Core Data Fetch"
summary: "Simple Core Data Fetch with Predicate & Sort Descriptor"
completion-scope: Function or Method
---

NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:<#entityName#>];
fetchRequest.predicate = [NSPredicate predicateWithFormat:<#predicateFormat#>];

NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:<#key#> ascending:<#isAscending#> selector:<#selector#>];
fetchRequest.sortDescriptors = @[sortDescriptor];

NSError *error;
NSArray *results = [<#context#> executeFetchRequest:fetchRequest error:&error];

if (error) {
    NSLog(@"%@", error);
}

/*************************************************************************
 checkerror
**************************************************************************/
---
title: "CheckError"
summary: "Function that extracts human-readable information from OSStatus codes."
credit: "'Learning Core Audio: A Hands-on Guide to Audio Programming for Mac and iOS', by Chris Adamson, Kevin Avila"
completion-scopes:
- Code Expression
- Function or Method
---

static void CheckError(OSStatus error, const char *operation) {
    if (error == noErr) {
        return;
    }
    
    char str[20];
    *(UInt32 *) (str + 1) = CFSwapInt32HostToBig(error);
    if (isprint(str[1]) && isprint(str[2]) && isprint(str[3]) && isprint(str[4])) {
        str[0] = str[5] = '\'';
        str[6] = '\0';
    } else {
        sprintf(str, "%d", (int)error);
    }
    
    fprintf(stderr, "[Error] %s (%s)\n", operation, str);
    exit(1);
}


/*************************************************************************
continuation
**************************************************************************/
---
title: "Class Continuation"
summary: "Anonymous category to define private methods in an implementation"
completion-scope: Top Level
---

@interface <#Class Name#> ()
<#Continuation#>
@end


/*************************************************************************
cvds
**************************************************************************/
---
title: "UICollectionViewDataSource"
summary: "Placeholders for essential UICollectionViewDataSource delegate methods"
platform: iOS
completion-scope: Class Implementation
---

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
numberOfItemsInSection:(NSInteger)section
{
    return <#numberOfItemsInSection#>;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:<#reuseIdentifier#> forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
forItemAtIndexPath:(NSIndexPath *)indexPath
{
    <# statements #>
}


/*************************************************************************
 documents
 **************************************************************************/
---
title: "Documents Directory Path"
completion-scope: Function or Method
---

NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];


/*************************************************************************
 frame
 **************************************************************************/
---
title: "Set Frame"
summary: "Initializes a view frame inside a code block"
completion-scope: Function or Method
---

<# view #>.frame = ({
    CGRect frame = <# view #>.frame;
    <# ... #>
    frame;
});


/*************************************************************************
 frc
 **************************************************************************/
---
title: "NSFetchedResultsController"
summary: "Boilerplate for creating an NSFetchedResultsController"
platform: iOS
completion-scope: Function or Method
---

NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:<#(NSString *)#>];
fetchRequest.predicate = [NSPredicate predicateWithFormat:<#(NSString *), ...#>];
fetchRequest.sortDescriptors = @[<#(NSSortDescriptor *), ...#>];

NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:<#(NSFetchRequest *)#> managedObjectContext:<#(NSManagedObjectContext *)#> sectionNameKeyPath:<#(NSString *)#> cacheName:<#(NSString *)#>];
fetchedResultsController.delegate = <#(id <NSFetchedResultsControllerDelegate>)#>;

NSError *error = nil;
if (![fetchedResultsController performFetch:&error]) {
    NSLog(@"Error: %@", error);
}


/*************************************************************************
 frcd
 **************************************************************************/
---
title: "NSFetchedResultsControllerDelegate"
summary: "Placeholders for the fetched results controller delegate methods"
platform: iOS
completion-scope: Class Implementation
---

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
atIndex:(NSUInteger)sectionIndex
forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
didChangeObject:(id)object
atIndexPath:(NSIndexPath *)indexPath
forChangeType:(NSFetchedResultsChangeType)type
newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] forRowAtIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


/*************************************************************************
 imv
 **************************************************************************/
---
title: "ImageView"
summary: "Create & Initialize UIImageView with Named Image"
platform: iOS
completion-scope: Code Expression
---

[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"<#image name#>"]]


/*************************************************************************
 init
 **************************************************************************/
---
title: "init"
summary: "Designated incantation for your designated initializers"
completion-scope: Function or Method
---

self = [super init];
if (!self) {
    return nil;
}

<#initializations#>

return self;


/*************************************************************************
 library
 **************************************************************************/
---
title: "Library Directory Path"
completion-scope: Function or Method
---

[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];


/*************************************************************************
 lifecycle
 **************************************************************************/
---
title: "UIViewController Lifecycle"
summary: "Placeholders for all of the view controller lifecycle methods"
platform: iOS
completion-scope: Class Implementation
---

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*************************************************************************
 mailcomp
 **************************************************************************/
---
title: "MFMailComposeViewController Initialization & Delegate"
summary: "Methods required to use the iOS Mail Composer"
platform: iOS
completion-scope: Class Implementation
---

#import <MessageUI/MessageUI.h>

- (void)presentModalMailComposerViewController:(BOOL)animated {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] init];
        composeViewController.mailComposeDelegate = self;
        
        [composeViewController setSubject:<#Subject#>];
        [composeViewController setMessageBody:<#Body#> isHTML:YES];
        [composeViewController setToRecipients:@[<#Recipients#>]];
        
        [self presentViewController:composeViewController animated:animated completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"<#Cannot Send Mail Message#>", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
didFinishWithResult:(MFMailComposeResult)result
error:(NSError *)error
{
    if (error) {
        NSLog(@"%@", error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*************************************************************************
 mark
 **************************************************************************/
---
title: "#pragma Mark"
summary: "Dividers and labels to organize your code into sections"
completion-scopes:
- Top Level
- Class Implementation
- Class Interface Methods
---

#pragma mark - <#Section#>


/*************************************************************************
 nscoding
 **************************************************************************/
---
title: "NSCoding Protocol Methods"
summary: "Placeholders for NSCoding protocol methods"
completion-scope: Class Implementation
---

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    <# implementation #>
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    <# implementation #>
}


/*************************************************************************
 nsl
 **************************************************************************/
---
title: "NSLocalizedString"
completion-scope: Code Expression
---

NSLocalizedString(@"<#Message#>", <#Comment#>)


/*************************************************************************
 pdel
 **************************************************************************/
---
title: "UIPickerViewDelegate"
summary: "Placeholders for required UIPickerView Delegate methods"
platform: iOS
completion-scope: Class Implementation
---

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
titleForRow:(NSInteger)row
forComponent:(NSInteger)component
{
    <#code#>
}

- (void)pickerView:(UIPickerView *)pickerView
didSelectRow:(NSInteger)row
inComponent:(NSInteger)component
{
    <#code#>
}


/*************************************************************************
 pds
 **************************************************************************/
---
title: "UIPickerViewDataSource"
summary: "Placeholders for required UIPickerView datasource methods"
platform: iOS
completion-scope: Class Implementation
---

#pragma mark - UIPickerDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return <#number#>
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return <#number#>
}


/*************************************************************************
 singleton
 **************************************************************************/
---
title: "Shared Singleton"
summary: "Class method that returns a singleton instance"
completion-scope: Class Implementation
---

+ (instancetype)shared<#name#> {
    static <#class#> *_shared<#name#> = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared<#name#> = <#initializer#>;
    });
    
    return _shared<#name#>;
}


/*************************************************************************
 stack
 **************************************************************************/
---
title: "Log Stack Trace"
completion-scope: Function or Method
---

NSLog(@"Call Stack: %@", [NSThread callStackSymbols]);


/*************************************************************************
 strongself
 **************************************************************************/
---
title: "__strong self"
summary: "Declare strong reference to weak reference"
completion-scope: Function or Method
---

__strong __typeof(<#weakSelf#>)strongSelf = <#weakSelf#>;


/*************************************************************************
 tu
 **************************************************************************/
---
title: "UIControlEventTouchUpInside"
platform: iOS
completion-scope: Code Expression
---

UIControlEventTouchUpInside


/*************************************************************************
 tvdel
 **************************************************************************/
---
title: "UITableViewDelegate"
summary: "Placeholders for required UITableViewDelegate protocol methods"
platform: iOS
completion-scope: Class Implementation
---

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    <#statements#>
}


/*************************************************************************
 tvds
 **************************************************************************/
---
title: "UITableViewDataSource"
summary: "Placeholders for required UITableViewDataSource delegate methods"
platform: iOS
completion-scope: Class Implementation
---

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return <#number#>;
}

- (NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return <#number#>;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#reuseIdentifier#> forIndexPath:<#indexPath#>];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    <#statements#>
}


/*************************************************************************
 weakself
 **************************************************************************/
---
title: "__weak self"
summary: "Declare weak reference to self"
completion-scope: Function or Method
---

__weak typeof(self)weakSelf = self;


/*************************************************************************
 xae
 **************************************************************************/
---
title: "XCT Assert Equals"
summary: "Assert equals for XCTest"
completion-scope: Function or Method
---

XCTAssertEqual(<#expected#>, <#actual#>, <#message#>);


/*************************************************************************
 xaf
 **************************************************************************/
---
title: "XCT Assert False"
summary: "Assert false for XCTest"
completion-scope: Function or Method
---

XCTAssertFalse(<#expression#>, <#message#>);


/*************************************************************************
 xan
 **************************************************************************/
---
title: "XCT Assert Nil"
summary: "Assert for XCTest"
completion-scope: Function or Method
---

XCTAssertNil(<#expression#>, <#message#>);



/*************************************************************************
 xann
 **************************************************************************/
---
title: "XCT Assert Not Nil"
summary: "Assert not nil for XCTest"
completion-scope: Function or Method
---

XCTAssertNotNil(<#expression#>, <#message#>);



/*************************************************************************
 xat
 **************************************************************************/
---
title: "XCT Assert True"
summary: "Assert true for XCTest"
completion-scope: Function or Method
---

XCTAssertTrue(<#expression#>, <#message#>);

