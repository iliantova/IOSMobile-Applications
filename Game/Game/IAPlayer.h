//
//  IAPlayer.h
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface IAPlayer : SKSpriteNode

+(id)player;

-(void) jump;

-(void)land;

-(void) start;

-(void) stop;

@end
