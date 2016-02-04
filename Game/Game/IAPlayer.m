//
//  IAPlayer.m
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAPlayer.h"

@interface IAPlayer()

@property BOOL *isJump;

@end

@implementation IAPlayer

static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;
static const uint32_t starsCategori = 0x1 << 3;


+(id)player
{
     NSMutableArray *walkFrames = [NSMutableArray array];
    
    
    
    NSArray *heroWalkingFrames = [self createWalkingSpirit: walkFrames];
    SKTexture *playerFraim = heroWalkingFrames[0];
    IAPlayer* player  = [IAPlayer spriteNodeWithTexture:playerFraim];
    [player runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:heroWalkingFrames
                                      timePerFrame:0.2f
                                            resize:YES
                                           restore:YES]] withKey:@"walkPlayer"];
    player.xScale = 0.8;
    player.yScale = 0.8;

    
    SKSpriteNode *picture = [SKSpriteNode spriteNodeWithImageNamed:@"RcArrb4cL.jpg"];
    picture.position = CGPointMake(0, 10);
    [player addChild:picture];
    player.name = @"player";
    player.zPosition = 15;
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(player.size.width -6, player.size.height - 6)];
    player.physicsBody.allowsRotation = NO;
    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.collisionBitMask = groundCategory | obstacleCategory;
    player.physicsBody.contactTestBitMask = obstacleCategory | groundCategory | starsCategori;
    return player;
}

-(void)start {
    SKAction *incrementsMove = [SKAction moveByX:1.0 y:0 duration:0.007];
    SKAction *move = [SKAction repeatActionForever:incrementsMove];
    [self runAction:move];
}

-(void)jump {
    if (!self.isJump) {
        [self.physicsBody applyImpulse:CGVectorMake(0, 110)];
        self.isJump = YES;
    }
}

-(void)land
{
    self.isJump = NO;
}

-(void)stop{
    [self removeAllActions];
}

+(NSMutableArray *)createWalkingSpirit: walkFrames {
    SKTextureAtlas *heroAnimatedAtlas = [SKTextureAtlas atlasNamed:@"spirit"];
    
    for (int i=1; i <=3; i++) {
        NSString *textureName = [NSString stringWithFormat:@"spirit_walk_%d", i];
        SKTexture *temp = [heroAnimatedAtlas textureNamed:textureName];
        [walkFrames addObject:temp];
    }
    
    return walkFrames;
}


@end
