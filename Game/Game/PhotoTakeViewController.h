//
//  PhotoTakeViewController.h
//  Game
//
//  Created by Iliyana Antova on 2/5/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTakeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;

- (IBAction)chosePhoto:(id)sender;

@end
