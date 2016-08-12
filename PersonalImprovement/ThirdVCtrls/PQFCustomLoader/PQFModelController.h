//
//  ModelController.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PQFDataViewController;

@interface PQFModelController : NSObject <UIPageViewControllerDataSource>

- (PQFDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PQFDataViewController *)viewController;

@end

