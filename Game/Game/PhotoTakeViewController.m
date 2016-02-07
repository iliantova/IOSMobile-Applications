//
//  PhotoTakeViewController.m
//  Game
//
//  Created by Iliyana Antova on 2/5/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "PhotoTakeViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@interface PhotoTakeViewController ()

@end

@implementation PhotoTakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIImage *imageUser = [IAPlayer takeUserPicture];
    
    self.imageView.image = imageUser;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)chosePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    AppDelegate *cdHelper = [[AppDelegate alloc] init];

    NSManagedObjectContext *context = [cdHelper managedObjectContext];

    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
   
    NSData *dataImage = UIImagePNGRepresentation(chosenImage);
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSString *nikName = delegate.nikNameData;
    
    for (NSManagedObject *info in fetchedObjects) {
         NSString *n = [info valueForKey:@"nikName"];
       
        if ( [n isEqualToString:nikName]) {
            [info setValue:dataImage forKey:@"picture"];
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }
    }
    
    self.imageView.image = chosenImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
