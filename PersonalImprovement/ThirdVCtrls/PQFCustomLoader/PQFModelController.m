//
//  ModelController.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFModelController.h"
#import "PQFDataViewController.h"

#import "PQFCustomLoaders.h"

@interface PQFModelController ()

@property (readonly, strong, nonatomic) NSArray *pageData;

@end

@implementation PQFModelController

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageData = @[@"PQFBouncingBalls", @"PQFBarsInCircle", @"PQFCirclesInTriangle", @"PQFBallDrop"];
    }
    return self;
}

- (PQFDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }

    PQFDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"PQFDataViewController"];
    dataViewController.pageIndex = index;
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(PQFDataViewController *)viewController {
    
    NSString *loaderClass = NSStringFromClass([viewController.loader class]);

    return [self.pageData indexOfObject:loaderClass];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PQFDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    else if (index == 0) {
        return [self viewControllerAtIndex:[self.pageData count] - 1 storyboard:viewController.storyboard];
    }
    
    index--;
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PQFDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return [self viewControllerAtIndex:0 storyboard:viewController.storyboard];
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}


@end
