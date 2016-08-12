//
//  ViewController.m
//  Demo
//
//  Created by Andrea on 16/04/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMWaveViewController.h"
#import "SecondViewController.h"
#import "AMWaveTransition.h"

@interface AMWaveViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray *data;

@end

@implementation AMWaveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.view setBackgroundColor:[UIColor colorWithRed:0.912 green:0.425 blue:0.029 alpha:1.000]];
	[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.912 green:0.425 blue:0.029 alpha:1.000]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.912 green:0.425 blue:0.029 alpha:1.000]];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 84;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    [self setTitle:@"Demo"];
    self.data =
    @[
      @{@"text": @"Stylized organs", @"icon": @"heart"},
      @{@"text": @"Food pictures", @"icon": @"camera"},
      @{@"text": @"Straight line maker", @"icon": @"pencil"},
      @{@"text": @"Let's cook!", @"icon": @"beaker"},
      @{@"text": @"That's the puzzle!", @"icon": @"puzzle"},
      @{@"text": @"Cheers", @"icon": @"glass"}
      ];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setDelegate:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary* dict = self.data[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = dict[@"text"];
    NSString *imgName = dict[@"icon"];
    UIImage *img = [UIImage imageNamed:imgName];
    [cell.imageView setImage:img];
    [cell setBackgroundColor:[UIColor clearColor]];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewController *vctrl = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:vctrl animated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation != UINavigationControllerOperationNone) {
        return [AMWaveTransition transitionWithOperation:operation andTransitionType:AMWaveTransitionTypeBounce];
    }
    return nil;
}

- (void)dealloc
{
    [self.navigationController setDelegate:nil];
}

@end
