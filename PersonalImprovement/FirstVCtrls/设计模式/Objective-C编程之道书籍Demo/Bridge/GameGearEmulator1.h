//
//  GameGearEmulator.h
//  Bridge
//
//  Created by Carlo Chung on 11/26/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsoleEmulator1.h"

@interface GameGearEmulator1 : ConsoleEmulator1
{

}

// overridden behaviors from the abstract class
- (void) loadInstructionsForCommand:(ConsoleCommand) command;
- (void) executeInstructions;

// other behaviors and properties.

@end
