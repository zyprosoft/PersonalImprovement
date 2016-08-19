//
// MMRootWireframe.m
//
// Copyright (c) 2014 Mutual Mobile (http://www.mutualmobile.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VTDRootWireframe.h"

@implementation VTDRootWireframe

- (void)showRootViewController:(UIViewController *)viewController
                      inWindow:(UIWindow *)window
{
    UIViewController *ctr = [self controllerFromWindow:window];
    if([ctr isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)ctr setViewControllers:@[viewController]];
    }else if ([ctr isKindOfClass:[UITabBarController class]]) {
        UINavigationController *ctrl = [(UITabBarController *)ctr selectedViewController];
        [ctrl pushViewController:viewController animated:YES];
//        [ctrl setViewControllers:@[viewController]];
    }
    
}


- (UIViewController *)controllerFromWindow:(UIWindow *)window
{
    UIViewController *ctrl = (UIViewController *)[window rootViewController];
    
    return ctrl;
}

@end
