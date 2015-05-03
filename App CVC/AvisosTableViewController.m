//
//  AvisosTableViewController.m
//  App CVC
//
//  Created by Jose Kovacevich on 4/8/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "AvisosTableViewController.h"
#import "ViewController.h"
#import "AvisoViewController.h"

@interface AvisosTableViewController ()

@property NSArray *avisos;
@end

@implementation AvisosTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *pathPlist = [[NSBundle mainBundle] pathForResource:@"Avisos" ofType:@"plist"];
    self.avisos = [[NSArray alloc] initWithContentsOfFile:pathPlist];
    self.title = @"Avisos";
    
    self.view.backgroundColor = [UIColor colorWithRed:(54.0/255.0) green:(109.0/255.0) blue:(127.0/255.0) alpha:1]; //Color para las celdas vacias
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showAviso"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.avisos[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.avisos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = self.avisos[indexPath.row];
    cell.textLabel.text = [object objectForKey:@"aviso"];
    cell.textLabel.textColor = [UIColor colorWithRed:(185.0/255.0) green:(237.0/255.0) blue:(255.0/255.0) alpha:1];
    return cell;
}




@end
