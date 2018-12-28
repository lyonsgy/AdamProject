//
//  NPConfigManager.h
//  Jikebaba
//
//  Created by nplus on 16/4/15.
//  Copyright © 2016年 Syousoft2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPHttpManager.h"
@interface NPConfigManager : NSObject
@property (nonatomic,strong,readonly)NPHttpManager *httpManager;
-(void)setAPPConfig;
+(instancetype)shareConfigManager;
@end



