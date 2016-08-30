//
//  AcmeBrandingFactory.m
//  AbstractFactory
//
//  Created by Carlo Chung on 11/1/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "AcmeBrandingFactory1.h"
#import "AcmeView.h"
#import "AcmeMainButton.h"
#import "AcmeToolbar.h"


@implementation AcmeBrandingFactory1

- (UIView *) brandedView
{
	// returns a custom view for Acme
	return [[AcmeView alloc] init];
}

- (UIButton *) brandedMainButton
{
	// returns a custom main button for Acme
	return [[AcmeMainButton alloc] init];
}

- (UIToolbar *) brandedToolbar
{
	// returns a custom toolbar for Acme
	return [[AcmeToolbar alloc] init];
}

@end
