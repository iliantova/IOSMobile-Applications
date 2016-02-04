//
//  GameViewController.m
//  Game
//
//  Created by Iliyana Antova on 2/1/16.
//  Copyright (c) 2016 Iliyana Antova. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"maxresdefault.jpg"]];
    // Sprite Kit applies additional optimizations to improve rendering performance
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
    //GameScene *scene = [GameScene sceneWithSize:CGSizeMake(skView.frame.size.height, skView.frame.size.width)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    
    // Present the scene.
    [skView presentScene:scene];
    
}


/*- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}*/

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
