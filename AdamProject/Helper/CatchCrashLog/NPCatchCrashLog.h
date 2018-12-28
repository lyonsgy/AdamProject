//
//  NPCatchCrashLog.h
//  Jikebaba
//
//  Created by lyons on 2017/5/23.
//  Copyright © 2017年 NewZhiWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPCatchCrashLog : NSObject
void UncaughtExceptionHandler(NSException * _Nullable exception);
+ (BOOL)writeCrashFileOnDocumentsException:(NSDictionary *_Nullable)exception;
+ (nullable NSArray *)sd_getCrashLogs;
+ (BOOL)sd_clearCrashLogs;
@end
