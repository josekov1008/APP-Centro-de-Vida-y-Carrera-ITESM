//
//  DetailEntrevistaViewController.m
//  App CVC
//
//  Created by Mildred Gatica on 4/27/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "DetailEntrevistaViewController.h"

@interface DetailEntrevistaViewController ()

@end

@implementation DetailEntrevistaViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {

        self.lbNombre.text = [self.detailItem	objectForKey: @"nombre"];
        self.lbNombre.lineBreakMode = NSLineBreakByWordWrapping;
        self.lbNombre.numberOfLines = 0;
        
        self.txtDescription.text = [self.detailItem	objectForKey: @"descripcion"];
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
