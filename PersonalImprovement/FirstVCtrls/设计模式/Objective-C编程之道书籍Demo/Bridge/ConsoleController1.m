//
//  VirtualController.m
//  Bridge
//
//  Created by Carlo Chung on 11/26/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "ConsoleController1.h"


@implementation ConsoleController1

@synthesize emulator=emulator_;

- (void) setCommand:(ConsoleCommand) command
{
  [emulator_ loadInstructionsForCommand:command];
  [emulator_ executeInstructions];
}

@end
