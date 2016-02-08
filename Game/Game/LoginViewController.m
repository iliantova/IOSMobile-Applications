//
//  LoginViewController.m
//  Game
//
//  Created by Iliyana Antova on 2/6/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "LoginViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clock.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    
    NSString *name = self.nikName.text;
    
    AppDelegate *cdHelper = [[AppDelegate alloc] init];
    
    NSManagedObjectContext *context = [cdHelper managedObjectContext];
    NSManagedObject *user = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"User"
                                       inManagedObjectContext:context];
    
    NSError *error;
    BOOL isExist = NO;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSString *nnn = [info valueForKey:@"nikName"];
        if ([nnn isEqualToString:name]) {
            isExist = YES;
        }
    }
    
    if (!isExist) {
        [user setValue:name forKey:@"nikName"];
        
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    }
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.nikNameData = name;
}
@end
