//
//  TouchConsoleController.h
//  Bridge
//
//  Created by Carlo Chung on 11/26/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsoleController1.h"

@interface TouchConsoleController : ConsoleController1
{

}

- (void) up;
- (void) down;
- (void) left;
- (void) right;
- (void) select;
- (void) start;
- (void) action1;
- (void) action2;

@end
