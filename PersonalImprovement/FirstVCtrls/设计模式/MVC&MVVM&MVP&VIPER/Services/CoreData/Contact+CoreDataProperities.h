//
//  Contact+CoreDataProperities.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "Contact.h"

@interface Contact (CoreDataProperities)
@property (copy,nonatomic)NSString *phoneNumber;
@property (copy,nonatomic)NSString *avatarURL;
@property (copy,nonatomic)NSString *nickname;
@property (assign,nonatomic)NSInteger contactID;
@end
