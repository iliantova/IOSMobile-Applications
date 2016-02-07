//
//  PhotoTakeViewController.h
//  Game
//
//  Created by Iliyana Antova on 2/5/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAPlayer.h"

@interface PhotoTakeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IAPlayer *player;

- (IBAction)takePhoto:(id)sender;

- (IBAction)chosePhoto:(id)sender;

@end
