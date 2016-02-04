//
//  IAWorldGenerator.m
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAWorldGenerator.h"
#import "IAStars.h"
#import "IAObtacle.h"

@interface IAWorldGenerator ()
@property double currentGroundX;
@property double currentObstacleX;
@property double currentStarsX;
@property double currentStarsY;
@property SKNode *world;

@end

@implementation IAWorldGenerator


static const uint32_t groundCategory = 0x1 << 2;
IAStars *stars;
IAObtacle *obtacleWheel;
IAObtacle *obtaclePuddle;

+(id) generatorWithWorld: (SKNode *) world
{
    IAWorldGenerator *generator = [IAWorldGenerator node];
    generator.currentGroundX = 0;
    generator.currentObstacleX = 400;
    generator.currentStarsX = 500;
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
    [self starsGenerate];
    
    //todo methot
    
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"images.jpeg" normalMapped:YES];
    ground.size = CGSizeMake(self.scene.frame.size.width, 100);
    ground.name = @"ground";
    ground.zPosition = -50;
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2 + ground.size.height/2);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.categoryBitMask = groundCategory;
    ground.physicsBody.dynamic = NO;
    [self.world addChild:ground];
    
    self.currentGroundX += ground.frame.size.width;
    
    int randomval = rand() % 2;
    
    if ((BOOL)randomval){
        obtacleWheel = [IAObtacle obtacleWithWheelImage];
        obtacleWheel.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height +obtacleWheel.frame.size.height/4);
        
        [self.world addChild:obtacleWheel];
    }
    else {
        obtaclePuddle = [IAObtacle obtacleWithPuddleImage];
        obtaclePuddle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/2 -obtaclePuddle.frame.size.height/2);
        
        [self.world addChild:obtaclePuddle];
    }
    
    //todo metod make
    
    int lowerBound = 300;
    int upperBound = 700;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    self.currentObstacleX += rndValue;
    self.currentStarsX += rndValue + 200;
    

}

-(void) starsGenerate
{
    
    for (int i=0; i<2; i++) {
        stars = [IAStars stars];
        stars.position = CGPointMake(self.currentStarsX, self.world.frame.size.height/2 + self.currentStarsY);
          self.currentStarsX += 30;
          self.currentStarsY += 10;
        [self.world addChild:stars];
    }
    for (int i=0; i<3; i++) {
        stars = [IAStars stars];
        stars.position = CGPointMake(self.currentStarsX, self.world.frame.size.height/2 + self.currentStarsY);
        self.currentStarsX += 30;
        self.currentStarsY -= 10;
        [self.world addChild:stars];
    }
    self.currentStarsY = 0;
    }

@end
