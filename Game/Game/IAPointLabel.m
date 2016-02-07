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

    
    [pointSet setValue:[NSString stringWithFormat:@"%i", points] forKey:@"points"];
    [pointSet setValue: [[NSString alloc] initWithData:[NSData data] encoding:NSUTF8StringEncoding] forKey:@"data"];
    [pointSet setValue:curentUser forKey:@"userPoints"];
    //[curentUser setValue:pointSet forKeyPath:@"pointsScor"];
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    
        NSEntityDescription *entitys = [NSEntityDescription
                                       entityForName:@"ScorPoint" inManagedObjectContext:context];
        [fetchRequest setEntity:entitys];
        
        NSArray *fetchedObjects4 = [context executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *info in fetchedObjects4) {
            NSString *pointsuser = [info valueForKey:@"points"];
        }
        
    //self.number = points;
    //self. text = [NSString stringWithFormat:@"%i", self.number];
    
    
}

- (void) reset
{
    self.number = 0;
    self.text = @"0";
}



@end
