//
//  VirtualController.h
//  Bridge
//
//  Created by Carlo Chung on 11/26/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsoleEmulator1.h"
#import "ConsoleCommands.h"

@interface ConsoleController1 : NSObject 
{
  @private
  ConsoleEmulator1 *emulator_;
}

@property (nonatomic, retain) ConsoleEmulator1 *emulator;

- (void) setCommand:(ConsoleCommand) command;

// other behaviors and properties

@end
