//
//  PVCViewController.m
//  App CVC
//
//  Created by Jose Kovacevich on 4/8/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "PVCViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PVCViewController ()

@end

@implementation PVCViewController

NSArray *buttons;

NSInteger pageCount;
NSMutableArray *pageViews;
NSMutableArray *semesterPages;

NSInteger semestres = 9;
NSInteger numeroSemestre = 1;
NSInteger paginasBotones = 3;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Plan de Vida y Carrera";
    // Do any additional setup after loading the view.
    
    self.scrollView.delegate = self;
    self.semestreScrollView.delegate = self;
    
    //Definicion de los botones - Cambiar los placeholders segun se requiera e identificarlo usando tags (del 1 al 11 para cada funcion)
    UIButton *boton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton1 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton2 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton3 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton4 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton5 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton6 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton7 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton8 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton9 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton10 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton10 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    UIButton *boton11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton11 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    
    //Temporal, para propositos de prueba solamente
    buttons = [[NSArray alloc] initWithObjects:boton1, boton2, boton3, boton4, boton5, boton6, boton7, boton8, boton9, boton10, boton11, nil];
    
    pageCount = paginasBotones;
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
    
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * paginasBotones, pagesScrollViewSize.height);
    self.semestreScrollView.contentSize = CGSizeMake(semestrePageScrollViewSize.width * semestres, semestrePageScrollViewSize.height); //Linea para prueba
    
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
    
    CGFloat anchoSemestre = self.semestreScrollView.frame.size.width;
    NSInteger semestreActual = (NSInteger)floor((self.semestreScrollView.contentOffset.x * 2.0f + anchoSemestre) / (anchoSemestre * 2.0f));
    
    self.pageControl.currentPage = page;
    self.labelSemestre.text = [NSString stringWithFormat:@"%ld", ((long)semestreActual + 1)];
    
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i = 0; i < firstPage; i++) {
        [self purgeButtonsPage:i];
    }
    
    for (NSInteger i = firstPage; i <= lastPage; i++) {
        [self loadButtonsPage:i];
    }
    
    for (NSInteger i = lastPage + 1; i < paginasBotones; i++) {
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
    
    if (page < 0 || page >= paginasBotones) {
        return;
    }
    
    UIView *pageView = [pageViews objectAtIndex:page];
    
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)loadButtonsPage:(NSInteger)page {
    if (page < 0 || page >= paginasBotones) {
        return;
    }
    
    UIView *pageView = [pageViews objectAtIndex:page];
    
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIView *newView = [[UIView alloc] initWithFrame:frame];
        
        newView.backgroundColor = [UIColor grayColor]; //Cambiar el color, un gris claro podría ser... se deja para después
        
        //TODO: encontrar una forma de determinar los indices de los botones de la pag actual
        //Formula matemática?
        
        //botones de la primera pagina
        if (page == 0) {
            UIButton *button1 = [buttons objectAtIndex:0];
            UIButton *button2 = [buttons objectAtIndex:1];
            UIButton *button3 = [buttons objectAtIndex:2];
            UIButton *button4 = [buttons objectAtIndex:3];
            
            button1.frame = CGRectMake(15,10, 50, 50);
            button2.frame = CGRectMake(95,10, 50, 50);
            button3.frame = CGRectMake(175,10, 50, 50);
            button4.frame = CGRectMake(255,10, 50, 50);
            
            [newView addSubview:button1];
            [newView addSubview:button2];
            [newView addSubview:button3];
            [newView addSubview:button4];
            
        }
        //botones de la segunda pagina
        else if (page == 1) {
            UIButton *button1 = [buttons objectAtIndex:4];
            UIButton *button2 = [buttons objectAtIndex:5];
            UIButton *button3 = [buttons objectAtIndex:6];
            UIButton *button4 = [buttons objectAtIndex:7];
            
            button1.frame = CGRectMake(15,10, 50, 50);
            button2.frame = CGRectMake(95,10, 50, 50);
            button3.frame = CGRectMake(175,10, 50, 50);
            button4.frame = CGRectMake(255,10, 50, 50);
            
            [newView addSubview:button1];
            [newView addSubview:button2];
            [newView addSubview:button3];
            [newView addSubview:button4];
            
        }
        else if (page == 2) {
            //TODO: agregar botones y cambiar sus posiciones, solo son 3 en esta view
            UIButton *button1 = [buttons objectAtIndex:8];
            UIButton *button2 = [buttons objectAtIndex:9];
            UIButton *button3 = [buttons objectAtIndex:10];;
            
            button1.frame = CGRectMake(54,10, 50, 50);
            button2.frame = CGRectMake(137,10, 50, 50);
            button3.frame = CGRectMake(216,10, 50, 50);
            
            [newView addSubview:button1];
            [newView addSubview:button2];
            [newView addSubview:button3];
            
        }
        
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
        //CGRect frame = self.semestreScrollView.bounds;
        CGRect frame;
        frame.size.width = self.semestreScrollView.bounds.size.width;
        frame.size.height = self.semestreScrollView.bounds.size.height;
        
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        
        
        //self.labelSemestre.text = [NSString stringWithFormat:@"%ld", (long)page];
        
        UIScrollView *newView = [[UIScrollView alloc] initWithFrame:frame];
        
        //Se agregan las actividades a cada semestre
        [self agregarActividadesExistentes:newView];
        
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

- (void)agregarActividadesExistentes:(UIScrollView *) view {
    //Se va a encargar de obtener las actividades guardadas y ponerlas en el scrollview de cada semestre

    //Propiedades de las actividades
    NSInteger posX = 20;
    NSInteger posY = 20;
    NSInteger ancho = 280;
    NSInteger alto = 50;
    
    //Para fines de prueba, deberá de cargar las activiades de una base de datos o plist
    NSInteger cantActividades = 10;
    
    //Se determina el tamaño del ScrollView donde se desplegarán
    NSInteger pagActividades = ceil(cantActividades / 5.0);
    
    view.contentSize = CGSizeMake(view.frame.size.width, view.frame.size.height * pagActividades);
    
    view.backgroundColor = [UIColor greenColor];

    //Se crean views para cada actividad
    for (NSInteger i = 0; i < cantActividades; i++) {
        CGRect actividad;
        actividad.size.width = ancho;
        actividad.size.height = alto;
    
        actividad.origin.x = posX;
        actividad.origin.y = posY;
    
        UIView *viewActividad = [[UIView alloc] initWithFrame:actividad];
        viewActividad.backgroundColor = [UIColor whiteColor];
    
        viewActividad.layer.cornerRadius = 5;
        viewActividad.layer.masksToBounds = YES;
    
        [view addSubview:viewActividad];

        posY = posY + alto + 20;
    }
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
