//
//  ServiceManager.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersistentManager.h"

@interface ServiceManager : NSObject {
    PersistentManager <ModelConvertorProtocol>*persistentManager;
}

@end
