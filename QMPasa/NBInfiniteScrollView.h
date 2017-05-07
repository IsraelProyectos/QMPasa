//
//  NBInfiniteScrollView.h
//
//  Created by Nathaniel Brown on 11/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBInfiniteScrollView, CKRadialMenu;
@protocol NBInfiniteScrollViewDelegate <NSObject> 

- (void)infiniteScrollView:(NBInfiniteScrollView *)infiniteScrollView didSelectPopout:(UIView*)popout fromRadialMenu:(CKRadialMenu*)radialMenu;

@end

@interface NBInfiniteScrollView : UIScrollView <UIScrollViewDelegate>

@property (weak, nonatomic) id<NBInfiniteScrollViewDelegate> infiniteScrollViewDelegate;

@property (nonatomic, copy) UIView *(^viewForIndex)(NSUInteger index);
@property (assign, nonatomic) NSUInteger count;
@property (assign, nonatomic) BOOL vertical;
@property (assign, nonatomic) UIEdgeInsets padding;

@end

