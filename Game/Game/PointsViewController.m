//
//  PointsViewController.m
//  Game
//
//  Created by Iliyana Antova on 2/6/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "PointsViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface PointsViewController ()

@end

@implementation PointsViewController

  NSSet *userPonts;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    AppDelegate *cdHelper = [[AppDelegate alloc] init];
    
    NSManagedObjectContext *context = [cdHelper managedObjectContext];
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSString *nikName = delegate.nikNameData;
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects4 = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects4) {
        
        NSString *n = [info valueForKey:@"nikName"];
        
        if ([n isEqualToString:nikName ]){
            
            userPonts = [info valueForKey:@"pointsScor"];
        }
    }
    
    [self.tableView reloadData];
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
    
    return 1; //userPonts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellM= @"TheCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellM];
    
    if(cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellM];
    }
    NSArray *aa= userPonts.allObjects;
    NSManagedObject *curentPoint = [aa objectAtIndex:indexPath.row];
    
    AppDelegate *cdHelper = [[AppDelegate alloc] init];
    
    NSManagedObjectContext *context = [cdHelper managedObjectContext];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ScorPoint" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

   //NSString *points = [curentPoint valueForKey:@"points"];
    NSString *pointsuser = [curentPoint valueForKey:@"points"];
    
    NSLog(pointsuser);
    
   NSString *data = [NSDateFormatter localizedStringFromDate:[curentPoint valueForKey:@"data"]
                                                          dateStyle:NSDateFormatterShortStyle
                                                         timeStyle:NSDateFormatterFullStyle];
    //NSString *points = @"RAbotq";
    //NSString *data = @"I oshte kak";
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", pointsuser, data];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
