//
//  PersistenStoreProtocol.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@protocol PersistenStoreProtocol <NSObject> {
    
}

- (void)saveContext;
- (Contact *)newContact;
- (BOOL)removeContactWithID:(int)contactID;
- (NSArray <Contact *>*)getAllContacts;
- (Contact *)getContactWithID:(int)contactID;
- (BOOL)updateContact:(Contact)contact;
- (NSArray <Contact *>*)getContacts:(NSString *)contactKey contactValue:(NSString *)contactValue;

@end

@interface CoreDataManager : NSObject<PersistenStoreProtocol>

@end
