//
//  GYHomeViewController.m
//  AdamProject
//
//  Created by lyons on 2018/12/20.
//  Copyright © 2018 lyons. All rights reserved.
//

#import "GYHomeViewController.h"
#import "SDCycleScrollView.h"
#import "GYTodayRecommendCell.h"

static NSString * const kCellIdentifier = @"GYTodayRecommendCell";

@interface GYHomeViewController () <SDCycleScrollViewDelegate>
@property (nonatomic ,strong) NSMutableArray *imagesURLStrings;
@property(nonatomic, strong) QMUIOrderedDictionary *dataSource;

@end

@implementation GYHomeViewController
- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    self.title = @"首页";
    
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView3.imageURLStringsGroup = self.imagesURLStrings;
    self.tableView.tableHeaderView = cycleScrollView3;
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStyleDone target:self action:@selector(handleRightBarButtonItem)];
}

- (void)initTableView {
    [super initTableView];
    // 如果需要自动缓存 cell 高度的计算结果，则打开这个属性，然后实现 - [QMUITableViewDelegate qmui_tableView:cacheKeyForRowAtIndexPath:] 方法即可
    // 只要打开这个属性，cell 的 self-sizing 特性也会被开启，所以请保证你的 cell 正确重写了 sizeThatFits: 方法（Auto-Layout 的忽略这句话）
    self.tableView.estimatedRowHeight = 300;// 注意，QMUI 通过配置表的开关 TableViewEstimatedHeightEnabled，默认在所有 iOS 版本打开 estimatedRowHeight（系统是在 iOS 11 之后默认打开），所以图方便的话这一句也可以不用写。
    self.tableView.qmui_cacheCellHeightByKeyAutomatically = YES;
}

- (void)handleRightBarButtonItem {
    // 在 key 没变的情况下，如果要令某个 cell 的高度重新计算，可以参照下方这么写：
    // 如果 key 变化了，则直接调用系统的 reloadRowsAtIndexPaths 就行了，不用手动去 invalidate 缓存的高度
    NSIndexPath *indexPathForSpecificRow = [NSIndexPath indexPathForRow:2 inSection:0];
    id<NSCopying> cacheKeyForSpecificRow = [self.tableView.delegate qmui_tableView:self.tableView cacheKeyForRowAtIndexPath:indexPathForSpecificRow];
    [self.tableView.qmui_currentCellHeightKeyCache invalidateHeightForKey:cacheKeyForSpecificRow];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathForSpecificRow] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - <QMUITableViewDelegate, QMUITableViewDataSource>

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 返回一个用于标记当前 cell 高度的 key，只要 key 不变，高度就不会重新计算，所以建议将有可能影响 cell 高度的数据字段作为 key 的一部分（例如 username、content.md5 等），这样当数据发生变化时，只要触发 cell 的渲染，高度就会自动更新
    NSString *keyName = self.dataSource.allKeys[indexPath.row];
    NSString *contentText = [self.dataSource objectForKey:keyName];
    return @(contentText.length);// 这里简单处理，认为只要长度不同，高度就不同（但实际情况下长度就算相同，高度也有可能不同，要注意）
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GYTodayRecommendCell *cell = (GYTodayRecommendCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[GYTodayRecommendCell alloc] initForTableView:tableView withReuseIdentifier:kCellIdentifier];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    NSString *keyName = self.dataSource.allKeys[indexPath.row];
    [cell updateCellAppearanceWithIndexPath:indexPath];
    [cell renderWithNameText:[NSString stringWithFormat:@"%@ - %@", @(indexPath.row), keyName] contentText:[self.dataSource objectForKey:keyName]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView qmui_clearsSelection];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

#pragma mark - getter & setter
- (NSMutableArray *)imagesURLStrings{
    if (!_imagesURLStrings) {
        _imagesURLStrings = [NSMutableArray arrayWithArray:@[@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                                             @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                                             @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"]];
    }
    return _imagesURLStrings;
}
- (QMUIOrderedDictionary *)dataSource{
    if (!_dataSource) {
        _dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                                         @"张三 的想法", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                                         @"李四 的想法", @"UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                                         @"王五 的想法", @"高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         @"QMUI Team 的想法", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         
                                         @"张三 的想法1", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                                         @"李四 的想法1", @"UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                                         @"王五 的想法1", @"高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         @"QMUI Team 的想法1", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         
                                         @"张三 的想法2", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                                         @"李四 的想法2", @"UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                                         @"王五 的想法2", @"高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         @"QMUI Team 的想法2", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         
                                         @"张三 的想法3", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。",
                                         @"李四 的想法3", @"UIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。",
                                         @"王五 的想法3", @"高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         @"QMUI Team 的想法3", @"全局 UI 配置：只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\nUIKit 拓展及版本兼容：拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题。\n高效的工具方法及宏：提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率。",
                                         nil];
    }
    return _dataSource;
}
@end


