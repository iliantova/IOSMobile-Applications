//
//  IAStars.m
//  Game
//
//  Created by Iliyana Antova on 2/4/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAStars.h"

@implementation IAStars

static const uint32_t starsCategori = 0x1 << 3;

+(id)stars
{
    NSMutableArray *shineStarsArray = [NSMutableArray array];
    
    
    
    NSArray *shineStarsFrames = [self createShineStars: shineStarsArray];
    SKTexture *starsFraim = shineStarsArray[0];
    IAStars* stars  = [IAStars spriteNodeWithTexture:starsFraim];
    [stars runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:shineStarsFrames
                                        timePerFrame:0.2f
                                              resize:YES
                                             restore:YES]] withKey:@"shineStars"];
    stars.xScale = 0.2;
    stars.yScale = 0.2;
    
    stars.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:stars.size];
    stars.physicsBody.categoryBitMask = starsCategori;
    stars.physicsBody.dynamic = NO;
    
    stars.name = @"stars";
    return stars;
}

+(NSMutableArray *)createShineStars: walkFrames {
    SKTextureAtlas *starsAnimatedAtlas = [SKTextureAtlas atlasNamed:@"stars"];
    
    for (int i=1; i <=4; i++) {
        NSString *textureName = [NSString stringWithFormat:@"stars_%d", i];
        SKTexture *temp = [starsAnimatedAtlas textureNamed:textureName];
        [walkFrames addObject:temp];
    }
    
    return walkFrames;
}

@end
