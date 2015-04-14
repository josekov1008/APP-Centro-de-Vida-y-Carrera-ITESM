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

NSInteger semestres;
NSInteger numeroSemestre = 1;
NSInteger paginasBotones = 3;

NSMutableArray *actividadesSemestre; //Array de actividades, el index representa el semestre, cada objeto será un array de actividades

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Se registra la notificación para la persistencia
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aplicacionBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    //Se cargan las actividades
    //NSString *pathPlist = [ [NSBundle mainBundle] pathForResource: @"ListaActividades" ofType: @"plist"];
    //actividadesSemestre = [[NSMutableArray alloc] initWithContentsOfFile:pathPlist];
    //actividadesSemestre = [NSMutableArray alloc];
    [self cargarArchivo];
    
    semestres = actividadesSemestre.count;
    
    self.title = @"Plan de Vida y Carrera";
    // Do any additional setup after loading the view.
    
    self.scrollView.delegate = self;
    self.semestreScrollView.delegate = self;
    
    //Se inicializan los botones
    [self inicializacionBotones];
    
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
}

- (void) inicializacionBotones {
    //Definicion de los botones - Cambiar los placeholders segun se requiera e identificarlo usando tags (del 1 al 11 para cada funcion)
    UIButton *boton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton1 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton1.tag = 1;
    [boton1 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton2 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton2.tag = 2;
    [boton2 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton3 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton3.tag = 3;
    [boton3 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton4 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton4.tag = 4;
    [boton4 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton5 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton5.tag = 5;
    [boton5 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton6 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton6.tag = 6;
    [boton6 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton7 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton7.tag = 7;
    [boton7 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton8 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton8.tag = 8;
    [boton8 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton9 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton9.tag = 9;
    [boton9 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton10 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton10 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton10.tag = 10;
    [boton10 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *boton11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [boton11 setImage:[UIImage imageNamed:@"buttonPlaceholder.png"] forState:UIControlStateNormal];
    boton11.tag = 11;
    [boton11 addTarget:self action:@selector(agregarActividadNueva:) forControlEvents:UIControlEventTouchUpInside];
    
    //Arreglo de los botones de la barra inferior
    buttons = [[NSArray alloc] initWithObjects:boton1, boton2, boton3, boton4, boton5, boton6, boton7, boton8, boton9, boton10, boton11, nil];
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
    
    if (semestres == 1) {
        self.btnEliminar.enabled = NO;
    }
    else {
        self.btnEliminar.enabled = YES;
    }
    
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
        [self agregarActividadesExistentes:newView pageNo:page];
        
        [_semestreScrollView addSubview:newView];
        [semesterPages replaceObjectAtIndex:page withObject:newView];
    }
}

- (IBAction)agregarSemestre:(id)sender {
    //Se agrega un nuevo semestre al arreglo
    NSMutableArray *semestreNuevo = [[NSMutableArray alloc] init];
    [actividadesSemestre addObject:semestreNuevo];
    
    semestres++;
    
    //Se redibuja el la view
    CGSize tamanoActual = self.semestreScrollView.contentSize;
    tamanoActual.width += self.semestreScrollView.frame.size.width;
    
    self.semestreScrollView.contentSize = tamanoActual;
    
    [semesterPages addObject:[NSNull null]];
    
    [self loadVisibleSemesterPages];
}

- (IBAction)eliminarSemestre:(id)sender {
    //Se muestra confirmacion
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"¿Eliminar?" message:@"¿Estas seguro que deseas borrar el semestre actual?" delegate:self cancelButtonTitle: @"Cancelar" otherButtonTitles:@"Eliminar", nil];
    
    alert.tag = 999;
    [alert show];
}

- (IBAction)eliminarActividad:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"¿Eliminar?" message:@"¿Estas seguro que deseas borrar la actividad seleccionada?" delegate:self cancelButtonTitle: @"Cancelar" otherButtonTitles:@"Eliminar", nil];
    
    alert.tag = sender.tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //Identificador del alert para semestres
    if (alertView.tag == 999) {
        if (buttonIndex == 1){
            //Se elimina del arreglo
            NSInteger semestreEliminar = [self.labelSemestre.text integerValue] - 1;
            [self purgeSemesterPage:semestreEliminar];
            
            semestres--;
            
            [semesterPages removeObjectAtIndex:semestreEliminar];
            [actividadesSemestre removeObjectAtIndex:semestreEliminar];
            
            //Se redibuja la view
            CGSize tamanoActual = self.semestreScrollView.contentSize;
            tamanoActual.width -= self.semestreScrollView.frame.size.width;
            
            self.semestreScrollView.contentSize = tamanoActual;
            
            [self recargarPVC];
        }
    }
    
    //Identificador del alert para actividades tag = actividad a borrar
    else {
        if (buttonIndex == 1){
            NSInteger semestreActual = [self.labelSemestre.text integerValue] - 1;
            NSInteger actividadActual = alertView.tag;
            
            //Se elimina del arreglo
            NSMutableArray *actividadesSemestreActual = [actividadesSemestre objectAtIndex:semestreActual];
            [actividadesSemestreActual removeObjectAtIndex:actividadActual];
            
            [actividadesSemestre replaceObjectAtIndex:semestreActual withObject:actividadesSemestreActual];
            
            //Se redibuja la view
            [self recargarPVC];
        }
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

- (void)agregarActividadesExistentes:(UIScrollView *)view pageNo:(NSInteger)semester {
    //Se va a encargar de obtener las actividades guardadas y ponerlas en el scrollview de cada semestre

    //Propiedades de las actividades
    NSInteger posX = 20;
    NSInteger posY = 20;
    NSInteger ancho = 280;
    NSInteger alto = 50;
    
    //Para fines de prueba, deberá de cargar las activiades de una base de datos o plist
    NSArray *actividades = [actividadesSemestre objectAtIndex:semester];
    NSInteger cantActividades = actividades.count;
    
    //Se determina el tamaño del ScrollView donde se desplegarán
    NSInteger pagActividades = ceil(cantActividades / 5.0);
    
    view.contentSize = CGSizeMake(view.frame.size.width, view.frame.size.height * pagActividades);
    
    view.backgroundColor = [UIColor greenColor]; //Para fines de visualización de prueba, cambiar acorde al diseño

    //Se crean views para cada actividad
    for (NSInteger i = 0; i < cantActividades; i++) {
        CGRect actividad;
        actividad.size.width = ancho;
        actividad.size.height = alto;
    
        actividad.origin.x = posX;
        actividad.origin.y = posY;
    
        UIView *viewActividad = [[UIView alloc] initWithFrame:actividad];
        viewActividad.backgroundColor = [UIColor whiteColor];
        
        
        //Se agrega a cada actividad su boton de eliminar
        UIButton *botonEliminar = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [botonEliminar setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        botonEliminar.tag = i;
        [botonEliminar addTarget:self action:@selector(eliminarActividad:) forControlEvents:UIControlEventTouchUpInside];

        botonEliminar.frame = CGRectMake(3,3, 8, 8);
        [viewActividad addSubview:botonEliminar];
        
        
        viewActividad.layer.cornerRadius = 5;
        viewActividad.layer.masksToBounds = YES;
    
        [view addSubview:viewActividad];

        posY = posY + alto + 20;
    }
}

- (void)refreshPage:(NSInteger) page {
    [self purgeSemesterPage:page];
    [self loadVisibleSemesterPages];
}

- (void) recargarPVC {
    
    for (NSInteger i = 0; i < semestres; i++) {
        [self purgeSemesterPage:i];
    }
    
    [self loadVisibleSemesterPages];
}

- (IBAction)agregarActividadNueva:(id)sender {
    //Semestre al cual guardar
    NSInteger semestreActual = [self.labelSemestre.text integerValue] - 1;
    NSMutableArray *actividades = [actividadesSemestre objectAtIndex:semestreActual];
    
    //Identificar cada accion mediante el tag y agregar al array de arrays...
    //Codigo de prueba
    NSDictionary *nuevaActividad = [[NSDictionary alloc] initWithObjectsAndKeys:@"Prueba", @"nombre", @"Esta es una prueba", @"descripcion", nil];
    
    [actividades addObject:nuevaActividad];
    
    [actividadesSemestre replaceObjectAtIndex:semestreActual withObject:actividades];
    
    //Se redibuja para apreciar el cambio (?)
    [self refreshPage:semestreActual];
}

- (void)cargarArchivo {
    
    //Se crea el path al archivo
    NSArray *paths = NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"datos.plist"];
    
    //Si existe, se carga
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        //Se actualiza el array;
        actividadesSemestre = [[NSMutableArray alloc] initWithContentsOfFile:fileName];
    }
    //Si no, se crea un array en blanco con 1 semestre
    else {
        NSMutableArray *semestreInicial = [[NSMutableArray alloc] init];
        actividadesSemestre = [[NSMutableArray alloc] initWithObjects:semestreInicial, nil];
    }
}

- (void) guardarArchivo {
    //Se crea el path al archivo
    NSArray *paths = NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"datos.plist"];
    
    //Se guarda el archivo
    [actividadesSemestre writeToFile:fileName atomically:YES];
}

- (void)aplicacionBackground:(NSNotification *)notification {
    [self guardarArchivo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        [self guardarArchivo];
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
