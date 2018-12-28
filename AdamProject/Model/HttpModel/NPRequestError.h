//
//  NPRequestError.h
//  Jikebaba
//
//  Created by NPlus on 2017/1/17.
//  Copyright © 2017年 nplus. All rights reserved.
//

#import "NPRootDataModel.h"
@protocol NPRequestError <NSObject>


@end

@interface NPRequestError : NPRootDataModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *msg;

@end
