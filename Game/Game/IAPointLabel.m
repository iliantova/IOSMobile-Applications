//
//  IAPointLabel.m
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAPointLabel.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@implementation IAPointLabel

+ (id)pointsLabelWithFontName:(NSString *) fontName
{
    IAPointLabel *pointsLabel = [IAPointLabel labelNodeWithFontNamed:fontName];
    pointsLabel.name = @"pointLabel";
    pointsLabel.text = @"0";
    pointsLabel.number = 0;
    return pointsLabel;
}
-(void)increments
{
    self.number ++;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

+(void) setPonts: (int) points
{
    AppDelegate *cdHelper = [[AppDelegate alloc] init];
    
    NSManagedObjectContext *context = [cdHelper managedObjectContext];
    
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSString *nikName = delegate.nikNameData;
    NSManagedObject *curentUser;
    
    for (NSManagedObject *info in fetchedObjects) {
        NSString *n = [info valueForKey:@"nikName"];
        
        if ( [n isEqualToString:nikName]) {
            curentUser = info;
            }
        }
    
    NSManagedObject *pointSet = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"ScorPoint"
                                 inManagedObjectContext:context];

    NSString *n = [NSString stringWithFormat:@"%i", points];
    [pointSet setValue:n forKey:@"points"];
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    [pointSet setValue: dateString forKey:@"data"];
    [pointSet setValue:curentUser forKey:@"userPoints"];
    
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}

- (void) reset
{
    self.number = 0;
    self.text = @"0";
}



@end
