//
//  CabDriver.m
//  Facade
//
//  Created by Carlo Chung on 11/15/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "CabDriver.h"


@implementation CabDriver

- (void) driveToLocation:(CGPoint) x
{
  // ...
  
  // set off the taximeter
  Taximeter *meter = [[Taximeter alloc] init];
  [meter start];
  
  // operate the vehicle
  // until location x is reached
  Car1 *car = [[Car1 alloc] init];
  [car releaseBrakes];
  [car changeGears];
  [car pressAccelerator];
  
  // ...
  
  // when it's reached location x
  // then stop the car and taximeter
  [car releaseAccelerator];
  [car pressBrakes];
  [meter stop];
  
  // ...
}

@end
