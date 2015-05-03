//
//  TipsEntrevistaTableViewController.m
//  App CVC
//
//  Created by Jose Kovacevich on 4/8/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "TipsEntrevistaTableViewController.h"
#import "DetailEntrevistaViewController.h"
#import "CustomTableViewCell.h"

@interface TipsEntrevistaTableViewController ()

@property NSArray *tipsEntrevista;

@end

@implementation TipsEntrevistaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Tips para Entrevista";
    
    NSString *pathPList = [[NSBundle mainBundle] pathForResource: @"TipsEntrevista" ofType: @"plist"];
    self.tipsEntrevista = [[NSArray alloc] initWithContentsOfFile:pathPList];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tipsEntrevista.count;
}


- (CustomTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = self.tipsEntrevista[indexPath.row];
    //    cell.textLabel.text = [object description];
    
    cell.lbTip.text = [object	objectForKey: @"nombre"];
    
    NSString *strImage = [object    objectForKey: @"imagen"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullImgPath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithString:strImage]];
    UIImage *imagen = [UIImage imageWithContentsOfFile:fullImgPath];
    
    cell.uiImage.image = imagen;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetailEntrevista"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.tipsEntrevista[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
