//
//  SYAPNSModel.h
//  Jikebaba
//
//  Created by nplus on 15/9/21.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "NPRootDataModel.h"
typedef NS_ENUM(NSInteger, NPAPNSType) {
    NPAPNSTypeSystem=0,
    NPAPNSTypePay,
    NPAPNSTypeRefund,
};
@protocol NPAPNSMessage
@end


@interface NPAPNSMessage : NPRootDataModel

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *msg_id;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic,assign)NPAPNSType type;

@end

@interface NPAPNSModel : NPRootDataModel
@property (nonatomic,strong)NSMutableArray <NPAPNSMessage>*msgs;
@end


