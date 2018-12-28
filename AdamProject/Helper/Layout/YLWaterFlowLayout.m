//
//  YLWaterFlowLayout.m
//  YLLanJiQuan
//
//  Created by TK-001289 on 16/5/10.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLWaterFlowLayout.h"

@interface YLWaterFlowLayout()
@property(nonatomic,strong)NSMutableArray *originxArray;
@property(nonatomic,strong)NSMutableArray *originyArray;
@property(nonatomic,strong)NSMutableArray *lastItemOriginyArray;
@end


@implementation YLWaterFlowLayout
#pragma mark - 初始化属性
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        self.minimumInteritemSpacing = 15;//同一行不同cell间距
        self.minimumLineSpacing = 20;//行间距
        self.sectionInset = UIEdgeInsetsMake(15, 0, 15, 0);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        _originxArray = [NSMutableArray array];
        _originyArray = [NSMutableArray array];
        _lastItemOriginyArray = [NSMutableArray array];
        _lastItemOriginyArray[0]=@0;
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing = PX_TRANS(18);//同一行不同cell间距
        self.minimumLineSpacing = PX_TRANS(20);//行间距
        self.sectionInset = UIEdgeInsetsMake(15, 0, 15, 0);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        _originxArray = [NSMutableArray array];
        _originyArray = [NSMutableArray array];
        _lastItemOriginyArray = [NSMutableArray array];
        _lastItemOriginyArray[0]=@0;
    }
    return self;
}

#pragma mark - 重写父类的方法，实现瀑布流布局
#pragma mark - 当尺寸有所变化时，重新刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (void)prepareLayout {
    [super prepareLayout];
}

#pragma mark - 处理所有的Item的layoutAttributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *mutArray = [NSMutableArray arrayWithCapacity:array.count];
    /*
    for(UICollectionViewLayoutAttributes *attrs in array){
        UICollectionViewLayoutAttributes *theAttrs = [self layoutAttributesForItemAtIndexPath:attrs.indexPath];
        [mutArray addObject:theAttrs];
    }
    */
    for(UICollectionViewLayoutAttributes *attrs in array){
        UICollectionViewLayoutAttributes *theAttrs;
        if (attrs.representedElementKind)
        {
            theAttrs=[self layoutAttributesForSupplementaryViewOfKind:attrs.representedElementKind atIndexPath:attrs.indexPath];
        }
        else
        {
            theAttrs = [self layoutAttributesForItemAtIndexPath:attrs.indexPath];
        }
 
        [mutArray addObject:theAttrs];
    }
    
    return mutArray;
}

#pragma mark - 处理单个的Item的layoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    CGFloat headerHeight=0;
    CGFloat headerY=0;
    
    NSInteger preSection=indexPath.section-1;
    
    if (preSection>=0)
    {
        NSInteger preNumberItems=[self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:preSection];
        if (preNumberItems==0)
        {
            //第preSection中item的个数为0
            CGFloat preHeaderHeight=0;
            if ([self.delegate respondsToSelector:@selector(waterFlowLayout:headerHeightAtIndexPath:)])
            {
                preHeaderHeight=[self.delegate waterFlowLayout:self headerHeightAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:preSection]];
            }
            if (preSection==0)
            {
                _lastItemOriginyArray[indexPath.section]=@([_lastItemOriginyArray[preSection] floatValue]+preHeaderHeight+self.sectionInset.bottom+self.sectionInset.top);
            }
            else
            {
                _lastItemOriginyArray[indexPath.section]=@([_lastItemOriginyArray[preSection] floatValue]+preHeaderHeight+self.sectionInset.bottom);
            }
        }
        
        
    }
    
    headerY=[_lastItemOriginyArray[indexPath.section] floatValue];
    
    if ([self.delegate respondsToSelector:@selector(waterFlowLayout:headerHeightAtIndexPath:)])
    {
        headerHeight=[self.delegate waterFlowLayout:self headerHeightAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
        
    }
    CGFloat x = self.sectionInset.left;
    CGFloat y = (headerY+headerHeight)+self.sectionInset.top;
    //判断获得前一个cell的x和y
    NSInteger preRow = indexPath.row - 1;
    if(preRow >= 0){
        if(_originyArray.count > preRow){
            x = [_originxArray[preRow]floatValue];
            y = [_originyArray[preRow]floatValue];
        }
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:preRow inSection:indexPath.section];
        CGFloat preWidth = [self.delegate waterFlowLayout:self widthAtIndexPath:preIndexPath];
        x += preWidth + self.minimumInteritemSpacing;
    }
    
    CGFloat currentWidth = [self.delegate waterFlowLayout:self widthAtIndexPath:indexPath];
    //保证一个cell不超过最大宽度
    currentWidth = MIN(currentWidth, self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right);
    if(x + currentWidth > self.collectionView.frame.size.width - self.sectionInset.right){
        //超出范围，换行
        x = self.sectionInset.left;
        y += _rowHeight + self.minimumLineSpacing;
    }
    
    
    NSInteger itemCount=[self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:indexPath.section];
    
    if (indexPath.row==itemCount-1)
    {
        _lastItemOriginyArray[indexPath.section+1]=@(y+_rowHeight+self.sectionInset.bottom);
    }
    
    // 创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, currentWidth, _rowHeight);
    _originxArray[indexPath.row] = @(x);
    _originyArray[indexPath.row] = @(y);
    
    return attrs;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *currentHead=[super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(waterFlowLayout:headerHeightAtIndexPath:)])
    {
        currentHead.frame=CGRectMake(0, [_lastItemOriginyArray[indexPath.section] floatValue], ScreenWidth, [self.delegate waterFlowLayout:self headerHeightAtIndexPath:indexPath]);
    }
    return currentHead;
}
#pragma mark - CollectionView的滚动范围
- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
//    CGFloat width = self.collectionView.frame.size.width;
//    
//    __block CGFloat maxY = 0;
//    [_originyArray enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([number floatValue] > maxY) {
//            maxY = [number floatValue];
//        }
//    }];
//
//    return CGSizeMake(width, maxY + _rowHeight + self.sectionInset.bottom);
}

@end
