//
//  UserInterfaceKitViewController.m
//  BFKitDemo
//
//  Created by Fabrizio on 08/09/14.
//  Copyright (c) 2014 Fabrizio Brancati. All rights reserved.
//

#import "UserInterfaceKitViewController.h"
#import "BFKit.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "BFKitVCtrl.h"

@interface UserInterfaceKitViewController () {
    IBOutlet UITableView *_uikitTableView;
    
    AppDelegate *appDelegate;
}
@end

static NSString *CellIdentifier = @"UIKitCell";

@implementation UserInterfaceKitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"UIKit";
        self.tabBarItem.image = [UIImage imageNamed:@"UIKitIcon"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [_uikitTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self deselect:_uikitTableView];
}

#pragma mark - Show Info

- (IBAction)showInfo:(id)sender {
    [self presentViewController:_bfKitVCtrl.infoNavigationController animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"By %@ - BFKit v%@ (%@)", BFKIT_AUTHOR, APP_VERSION, APP_BUILD];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_bfKitVCtrl.uikitArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([[_bfKitVCtrl.uikitArray objectAtIndex:indexPath.row] isEqualToString:@"UIToolbar"]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        [[cell detailTextLabel] setText:@"+ UIBarButtonItem"];
    }
    
    [[cell textLabel] setText:[_bfKitVCtrl.uikitArray objectAtIndex:indexPath.row]];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    [detailViewController prepareForDetail:indexPath.row + _bfKitVCtrl.bfkitArray.count];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)deselect:(UITableView *)tableView {
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

@end
