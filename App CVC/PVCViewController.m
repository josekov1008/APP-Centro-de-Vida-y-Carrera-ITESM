//
//  PVCViewController.m
//  App CVC
//
//  Created by Jose Kovacevich on 4/8/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "PVCViewController.h"

@interface PVCViewController ()

@end

@implementation PVCViewController

NSArray *buttons;
NSInteger pageCount;
NSMutableArray *pageViews;
NSMutableArray *semesterPages;
NSInteger semestres = 9;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Plan de Vida y Carrera";
    // Do any additional setup after loading the view.
    
    self.scrollView.delegate = self;
    self.semestreScrollView.delegate = self;
    
    //Temporal, para propositos de prueba solamente
    buttons = [[NSArray alloc] initWithObjects:@"Primera Pagina", @"Segunda Pagina", @"Tercera Pagina", nil];
    
    pageCount = buttons.count;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = pageCount;
    
    pageViews = [[NSMutableArray alloc] init];
    semesterPages = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < pageCount; i++) {
        [pageViews addObject:[NSNull null]];
    }
    
    for (NSInteger i = 0; i < semestres; i++) {
        [semesterPages addObject:[NSNull null]];
    }
    
    //Scroll View de los semestres
    /*self.semestreScrollView.backgroundColor = [UIColor blackColor];
    self.semestreScrollView.pagingEnabled = YES;

    CGRect ViewSize = self.semestreScrollView.bounds;*/
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    CGSize semestrePageScrollViewSize = self.semestreScrollView.frame.size;
    
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * buttons.count, pagesScrollViewSize.height);
    self.semestreScrollView.contentSize = CGSizeMake(semestrePageScrollViewSize.width * semestres, semestrePageScrollViewSize.height);
    
    [self loadVisibleButtonPages];
    [self loadVisibleSemesterPages];
}

- (void)loadVisibleSemesterPages {
    CGFloat anchoSemestre = self.semestreScrollView.frame.size.width;
    NSInteger semestreActual = (NSInteger)floor((self.semestreScrollView.contentOffset.x * 2.0f + anchoSemestre) / (anchoSemestre * 2.0f));
    
    NSInteger semestreAnterior = semestreActual - 1;
    NSInteger semestreSiguiente = semestreActual + 1;
    
    for (NSInteger i = 0; i < semestreAnterior; i++) {
        [self purgeSemesterPage:i];
    }
    
    for (NSInteger i = semestreAnterior; i <= semestreSiguiente; i++) {
        [self loadSemesterPages:i];
    }
    
    for (NSInteger i = semestreSiguiente + 1; i < semestres; i++) {
        [self purgeSemesterPage:i];
    }
}

- (void)loadVisibleButtonPages {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    //CGFloat anchoSemestre = self.semestreScrollView.frame.size.width;
    //NSInteger semestreActual = (NSInteger)floor((self.semestreScrollView.contentOffset.x * 2.0f + anchoSemestre) / (anchoSemestre * 2.0f));
    
    self.pageControl.currentPage = page;
    //self.labelSemestre.text = [NSString stringWithFormat:@"%ld", ((long)semestreActual + 1)];
    
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i = 0; i < firstPage; i++) {
        [self purgeButtonsPage:i];
    }
    
    for (NSInteger i = firstPage; i <= lastPage; i++) {
        [self loadButtonsPage:i];
    }
    
    for (NSInteger i = lastPage + 1; i < buttons.count; i++) {
        [self purgeButtonsPage:i];
    }
}

- (void)purgeSemesterPage:(NSInteger)page {
    
    if (page < 0 || page >= semestres) {
        return;
    }
    
    UIView *pageView = [semesterPages objectAtIndex:page];
    
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [semesterPages replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)purgeButtonsPage:(NSInteger)page {
    
    if (page < 0 || page >= buttons.count) {
        return;
    }
    
    UIView *pageView = [pageViews objectAtIndex:page];
    
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)loadButtonsPage:(NSInteger)page {
    if (page < 0 || page >= buttons.count) {
        return;
    }
    
    UIView *pageView = [pageViews objectAtIndex:page];
    
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIView *newView = [[UIView alloc] initWithFrame:frame];
        
        newView.backgroundColor = [UIColor grayColor];
        
        NSString *title = [buttons objectAtIndex:page];
        
        UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(5, 5, 200, 20)];
        
        label.text = title;
        
        [newView addSubview:label];
        
        [_scrollView addSubview:newView];
        [pageViews replaceObjectAtIndex:page withObject:newView];
    }
}

- (void)loadSemesterPages:(NSInteger)page {
    if (page < 0 || page >= semestres) {
        return;
    }
    
    UIView *pageView = [semesterPages objectAtIndex:page];
    
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.semestreScrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        self.labelSemestre.text = [NSString stringWithFormat:@"%ld", page];
        
        UIView *newView = [[UIView alloc] initWithFrame:frame];
        
        newView.backgroundColor = [UIColor greenColor];
        
        NSString *title = @"Pagina de Semestre, aquí irá la información";
        
        UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(5, 5, 200, 20)];
        
        label.text = title;
        
        [newView addSubview:label];
        
        [_semestreScrollView addSubview:newView];
        [semesterPages replaceObjectAtIndex:page withObject:newView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadVisibleButtonPages];
    [self loadVisibleSemesterPages];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
