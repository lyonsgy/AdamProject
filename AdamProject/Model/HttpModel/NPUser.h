//
//  NPUser.h
//  Jikebaba
//
//  Created by lyons on 2017/4/6.
//  Copyright © 2017年 NewZhiWei. All rights reserved.
//

#import "NPRootDataModel.h"

@protocol NPUser <NSObject>

@end

@interface NPUser : NPRootDataModel
@property (nonatomic) NSInteger userId;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *wechatId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *backgroundImg;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) NSInteger isWechatBind;
@property (nonatomic, assign) NSInteger isTelephoneBind;
@property (nonatomic, copy) NSString *content;


@end

