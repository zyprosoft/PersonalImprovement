//
//  RootFormViewController.m
//  BasicExample
//
//  Created by Nick Lockwood on 25/03/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "RootFormViewController2.h"
#import "RootForm2.h"


@implementation RootFormViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        //set up form
        self.formController.form = [[RootForm2 alloc] init];
    }
    return self;
}

@end
