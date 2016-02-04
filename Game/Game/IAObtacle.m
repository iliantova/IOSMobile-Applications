//
//  IAObtacle.m
//  Game
//
//  Created by Iliyana Antova on 2/4/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAObtacle.h"

@implementation IAObtacle

static const uint32_t obstacleCategory = 0x1 << 1;

+(id) obtacleWithPuddleImage
{
    SKSpriteNode *obticleBuddle = [SKSpriteNode spriteNodeWithImageNamed:@"puddle.png" normalMapped:YES];
    obticleBuddle.size = CGSizeMake(100, 40);
    obticleBuddle.name = @"obstacle";
    obticleBuddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obticleBuddle.size];
    obticleBuddle.physicsBody.categoryBitMask = obstacleCategory;
    obticleBuddle.physicsBody.dynamic = NO;
    
    return obticleBuddle;
}

+(id) obtacleWithWheelImage
{
    SKSpriteNode *obticleWheel = [SKSpriteNode spriteNodeWithImageNamed:@"wheel.png" normalMapped:YES];
    obticleWheel.size = CGSizeMake(80, 80);
    obticleWheel.name = @"obstacle";
    obticleWheel.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obticleWheel.size];
    obticleWheel.physicsBody.categoryBitMask = obstacleCategory;
    obticleWheel.physicsBody.dynamic = NO;
    
    SKAction *oneRevolution = [SKAction rotateByAngle:M_PI*3 duration: 1.0];
    SKAction *repeat = [SKAction repeatActionForever:oneRevolution];
    [obticleWheel runAction:repeat];
    
    return obticleWheel;
}

@end
