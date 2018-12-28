//
//  NPAreaPickerView.h
//  ThreePigsPianoParents
//
//  Created by NPlus on 2017/1/22.
//  Copyright © 2017年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZMAreaPickerView.h"

@class NPAreaPickerView;
@protocol NPAreaPickerViewDelegate <NSObject>
- (void)areaPickerViewCurrentProvinceModel:(DZMProvinceModel *)currentProvinceModel currentCityModel:(DZMCityModel *)currentCityModel currentAreaModel:(DZMAreaModel *)currentAreaModel;

@end
@interface NPAreaPickerView : UIView<DZMAreaPickerViewDelegate>
@property (nonatomic,assign) id <NPAreaPickerViewDelegate> delegate;
@property (nonatomic,strong) DZMProvinceModel *currentProvinceModel;
@property (nonatomic,strong) DZMCityModel *currentCityModel;
@property (nonatomic,strong) DZMAreaModel *currentAreaModel;
- (void)show;
- (void)hide;

@end
