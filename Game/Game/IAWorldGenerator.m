//
//  IAWorldGenerator.m
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAWorldGenerator.h"

@interface IAWorldGenerator ()
@property double currentGroundX;
@property double currentObstacleX;
@property SKNode *world;

@end

@implementation IAWorldGenerator

static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;

+(id) generatorWithWorld: (SKNode *) world
{
    IAWorldGenerator *generator = [IAWorldGenerator node];
    generator.currentGroundX = 0;
    generator.currentObstacleX = 400;
    generator.world = world;
    return generator;
}

-(void)populate
{
    for (int i=0; i<3; i++) {
        [self generate];
    }
}
-(void)generate
{
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size: CGSizeMake(self.scene.frame.size.width, 100)];
    ground.name = @"ground";
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2 + ground.size.height/2);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.categoryBitMask = groundCategory;
    ground.physicsBody.dynamic = NO;
    [self.world addChild:ground];
    
    self.currentGroundX += ground.frame.size.width;
    
    SKSpriteNode *obtacle = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size: CGSizeMake(40, 70)];
    obtacle.name = @"obstacle";
    obtacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/2 + obtacle.frame.size.height/2);
    obtacle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obtacle.size];
    obtacle.physicsBody.categoryBitMask = obstacleCategory;
    obtacle.physicsBody.dynamic = NO;
    [self.world addChild:obtacle];
    
    self.currentObstacleX += 250;
}

@end
