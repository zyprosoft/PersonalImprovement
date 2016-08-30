//
//  BrandingFactory.m
//  AbstractFactory
//
//  Created by Carlo Chung on 11/1/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "BrandingFactory1.h"
#import "AcmeBrandingFactory1.h"
#import "SierraBrandingFactory1.h"


@implementation BrandingFactory1

+ (BrandingFactory1 *) factory
{
#if defined (USE_ACME)
	return [[[AcmeBrandingFactory1 alloc] init] autorelease];
#elif defined (USE_SIERRA)
	return [[[SierraBrandingFactory1 alloc] init] autorelease];
#else
	return nil;
#endif
}

- (UIView *) brandedView
{
	return nil;
}

- (UIButton *) brandedMainButton
{
	return nil;
}

- (UIToolbar *) brandedToolbar
{
	return nil;
}

@end
