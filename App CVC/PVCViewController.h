//
//  PVCViewController.h
//  App CVC
//
//  Created by Jose Kovacevich on 4/8/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVCViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UIScrollView *semestreScrollView;
@property (strong, nonatomic) IBOutlet UILabel *labelSemestre;
- (void) loadVisibleButtonPages;
- (void)loadButtonsPage:(NSInteger)page;

- (void) loadVisibleSemesterPages;
- (void)loadSemesterPages:(NSInteger)page;
@end
