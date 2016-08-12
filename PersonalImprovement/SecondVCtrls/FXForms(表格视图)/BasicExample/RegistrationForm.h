//
//  RegistrationForm.h
//  BasicExample
//
//  Created by Nick Lockwood on 04/03/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TermsViewController.h"
#import "PrivacyPolicyViewController.h"
#import "FXForms.h"
#import "DynamicForm.h"



typedef NS_OPTIONS(NSInteger, ServicePlan)
{
    ServicePlanMicro = 0,
    ServicePlanNormal,
    ServicePlanMaxi
};


@interface RegistrationForm : NSObject <FXForm>

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *repeatPassword;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, strong) NSDate *dateOfBirth;
@property (nonatomic, strong) UIImage *profilePhoto;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSArray *interests;
@property (nonatomic, assign) Interests otherInterests;
@property (nonatomic, copy) NSString *about;

@property (nonatomic, assign) ServicePlan plan;

@property (nonatomic, copy) NSString *notifications;

@property (nonatomic, readonly) TermsViewController *termsAndConditions;
@property (nonatomic, readonly) PrivacyPolicyViewController *privacyPolicy;
@property (nonatomic, assign) BOOL agreedToTerms;

@end
