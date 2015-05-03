//
//  AvisoViewController.m
//  App CVC
//
//  Created by alumno on 20/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "AvisoViewController.h"

@interface AvisoViewController ()

@end

@implementation AvisoViewController

#pragma mark - Managing the detail item



- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
        self.title = [self.detailItem objectForKey:@"aviso"];
    }
}

- (void)configureView {
    
    NSDate *fechaHoy;
    NSDateFormatter *formatoFecha;
    
    fechaHoy = [self.detailItem objectForKey:@"fecha"]; //obtengo la fecha de hoy.
    formatoFecha = [[NSDateFormatter alloc] init];
    
    [formatoFecha setDateFormat:@"dd/MMM/YYYY '-' h:mm a"];
    NSString *fechaMostrar = [formatoFecha stringFromDate: fechaHoy];
    
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.lbDetalle.text = [self.detailItem objectForKey:@"detalles"];
        self.lbDetalle.textColor = [UIColor colorWithRed:(185.0/255.0) green:(237.0/255.0) blue:(255.0/255.0) alpha:1];
        self.lbFecha.text = fechaMostrar;
        NSString *stringUrl = [self.detailItem objectForKey:@"urlFoto"];
        NSURL *nsurl = [NSURL URLWithString:stringUrl];
        NSData *data = [[NSData alloc]initWithContentsOfURL:nsurl];
        self.imgFoto.image = [UIImage imageWithData:data];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end