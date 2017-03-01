//
//  CHMenuView.m
//  CHCourselView
//
//  Created by chenghao on 2017/2/28.
//  Copyright © 2017年 clearcdm.com. All rights reserved.
//

#import "CHMenuView.h"
#import "CHMenuCollectionViewCell.h"
static NSString *const cellId = @"cellId";
@implementation CHMenuView{
    NSArray* _menus;
    NSArray* _views;
    UIView* _barline;
    NSMutableArray* _titlesDic;
    UICollectionView* _titlesView;
    UIScrollView* _scrollview;
    UIColor* _color;
    UICollectionViewFlowLayout* _collectionViewLayout;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles andViews:(NSArray*)views andTitleColor:(UIColor*)color{
    if (self = [super initWithFrame:frame]) {
        _menus = titles;
        _views = views;
        _color = color;
        _titlesDic = [NSMutableArray array];
        [self createMenuView];
    }
    return self;
    
}
-(void)createMenuView{
    for (int i = 0; i<_menus.count; i++) {
        NSMutableDictionary* dic;
        if (i==0) {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_menus[i],@"title",[NSNumber numberWithBool:YES],@"isSelect",nil];
        }else{
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_menus[i],@"title",[NSNumber numberWithBool:NO],@"isSelect",nil];
        }
        [_titlesDic addObject:dic];
    }
    _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    _titlesView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55) collectionViewLayout:_collectionViewLayout];
    _titlesView.backgroundColor = [UIColor whiteColor];
    _titlesView.delegate = self;
    _titlesView.dataSource = self;
    [self addSubview:_titlesView];
    [_titlesView registerClass:[CHMenuCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    _barline = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/_menus.count-[UIScreen mainScreen].bounds.size.width/(_menus.count+1))/2, _titlesView.frame.size.height-3, [UIScreen mainScreen].bounds.size.width/(_menus.count+1), 3)];
    _barline.backgroundColor = _color;
    [self addSubview:_barline];
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _titlesView.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height-_titlesView.frame.size.height)];
    _scrollview.delegate = self;
    _scrollview.pagingEnabled = YES;
    for (int i = 0; i<_views.count; i++) {
        if ([_views[i] isKindOfClass:[UITableView class]]) {
            UITableView* tableview = _views[i];
            tableview.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, _scrollview.frame.size.height);
            [_scrollview addSubview:tableview];
        }else if ([_views[i] isKindOfClass:[UIView class]]){
            UIView* view = _views[i];
            view.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, _scrollview.frame.size.height);
            [_scrollview addSubview:view];
        }else if ([_views[i] isKindOfClass:[UICollectionView class]]){
            UICollectionView* collectionview = _views[i];
            collectionview.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, _scrollview.frame.size.height);
            [_scrollview addSubview:collectionview];
        }
    }
    [_scrollview setContentSize:CGSizeMake(_views.count*[UIScreen mainScreen].bounds.size.width, _scrollview.frame.size.height)];
    [self addSubview:_scrollview];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (int i = 0; i<_titlesDic.count; i++) {
        NSMutableDictionary* dic = _titlesDic[i];
        if (i==scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width) {
            [dic setObject:[NSNumber numberWithBool:YES] forKey:@"isSelect"];
        }else{
            [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isSelect"];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        _barline.frame = CGRectMake(scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width*([UIScreen mainScreen].bounds.size.width/_menus.count)+([UIScreen mainScreen].bounds.size.width/_menus.count-[UIScreen mainScreen].bounds.size.width/(_menus.count+1))/2, _titlesView.frame.size.height-3, [UIScreen mainScreen].bounds.size.width/(_menus.count+1), 3);
    }];
    [_titlesView reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CHMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (_titlesDic.count) {
        NSMutableDictionary* dic = _titlesDic[indexPath.row];
        cell.title.text = dic[@"title"];
        if ([dic[@"isSelect"] boolValue]) {
            cell.title.textColor = _color;
            cell.title.font = [UIFont systemFontOfSize:18];
        }else{
            cell.title.textColor = [UIColor darkGrayColor];
            cell.title.font = [UIFont systemFontOfSize:16];
        }
        
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i<_titlesDic.count; i++) {
        NSMutableDictionary* dic = _titlesDic[i];
        if (i==indexPath.row) {
            [dic setObject:[NSNumber numberWithBool:YES] forKey:@"isSelect"];
        }else{
            [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isSelect"];
        }
    }

    [UIView animateWithDuration:0.3 animations:^{
        _barline.frame = CGRectMake(indexPath.row*([UIScreen mainScreen].bounds.size.width/_menus.count)+([UIScreen mainScreen].bounds.size.width/_menus.count-[UIScreen mainScreen].bounds.size.width/(_menus.count+1))/2, _titlesView.frame.size.height-3, [UIScreen mainScreen].bounds.size.width/(_menus.count+1), 3);
    }];
    [_scrollview setContentOffset:CGPointMake(indexPath.row*[UIScreen mainScreen].bounds.size.width, 0) animated:NO];
    [_titlesView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _menus.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){[UIScreen mainScreen].bounds.size.width/_menus.count,55};
}
@end
