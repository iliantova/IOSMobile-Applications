//
//  IAWorldGenerator.h
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface IAWorldGenerator : SKNode

+(id) generatorWithWorld: (SKNode *) world;

-(void)populate;

-(void)generate;

@end
