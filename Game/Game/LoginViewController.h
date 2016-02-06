//
//  LoginViewController.h
//  Game
//
//  Created by Iliyana Antova on 2/6/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nikName;

- (IBAction)login:(id)sender;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@end
