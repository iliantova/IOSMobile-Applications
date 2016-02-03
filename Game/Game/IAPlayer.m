//
//  IAPlayer.m
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAPlayer.h"

@implementation IAPlayer

static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;


+(id)player
{
    IAPlayer *player = [IAPlayer spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(40, 40)];
    SKSpriteNode *picture = [SKSpriteNode spriteNodeWithImageNamed:@"RcArrb4cL.jpg"];
    picture.position = CGPointMake(0, 8);
    [player addChild:picture];
    player.name = @"player";
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.contactTestBitMask = obstacleCategory | ~groundCategory;
    return player;
}

-(void) start {
    SKAction *incrementsMove = [SKAction moveByX:1.0 y:0 duration:0.01];
    SKAction *move = [SKAction repeatActionForever:incrementsMove];
    [self runAction:move];
}

-(void) jump {
    [self.physicsBody applyImpulse:CGVectorMake(0, 40)];
}

-(void) stop{
    [self removeAllActions];
}

@end
