//
//  GameScene.m
//  Game
//
//  Created by Iliyana Antova on 2/1/16.
//  Copyright (c) 2016 Iliyana Antova. All rights reserved.
//

#import "GameScene.h"
#import "IAPlayer.h"
#import "IAWorldGenerator.h"
#import "IAPointLabel.h"

@interface GameScene()

@property BOOL isStarted;
@property BOOL isgameOver;

@end


@implementation GameScene

{
    IAPlayer *player;
    SKNode *world;
    IAWorldGenerator *generator;
   // IAPointLabel *pointsLabel;
}

/*-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize: size]) {
        
        self.anchorPoint =  CGPointMake(0.5, 0.5);
        
        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size: CGSizeMake(self.frame.size.width, 50)];
        ground.position = CGPointMake(0, -100);
        [self addChild:ground];
    }
    
    return self;
}*/

 -(void)didMoveToView:(SKView *)view {
//Setup your scene here
    //SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];

     self.anchorPoint =  CGPointMake(0.5, 0.5);
     
     self.physicsWorld.contactDelegate = self;
     
     world = [SKNode node];
     [self addChild:world];
     
     generator = [IAWorldGenerator generatorWithWorld:world];
     [self addChild:generator];
     [generator populate];
     
     player = [IAPlayer player];
     [world addChild:player];
     
    IAPointLabel *pointsLabel = [IAPointLabel pointsLabelWithFontName:@"Verdana"];
     pointsLabel.position = CGPointMake(0, 100);
     [self addChild:pointsLabel];
     
    //[self addChild:myLabel];
}

-(void)didSimulatePhysics
{
    [self centerOnNode:player];
    [self handlePoints];
    [self handleGenerator];
    [self handleCleanup];
    
}

-(void)centerOnNode:(SKNode *)node
{
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y);
}

-(void) start
{
    self.isStarted = YES;
    [player start];
}

-(void) clear
{
    GameScene *scene = [[GameScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:scene];
}

-(void)gameOver
{
    self.isgameOver = YES;
    [player stop];
    
    SKLabelNode *gameOverNode = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    gameOverNode.text = @"Over";
    gameOverNode.position = CGPointMake(0, 60);
    [self addChild:gameOverNode];
}

-(void)handlePoints
{
    
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < player.position.x) {
            IAPointLabel *pointsLabel = (IAPointLabel *) [self childNodeWithName:@"pointLabel"];
            [pointsLabel increments];
        }
    }];
}

-(void)handleGenerator
{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < player.position.x) {
        node.name = @"obstacle_canselled" ;
            [generator generate];
        }
    }];
}

-(void)handleCleanup
{
    
    [world enumerateChildNodesWithName:@"graund" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < player.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
    
    [world enumerateChildNodesWithName:@"obstacle_canselled" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < player.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    if (!self.isStarted) {
        [self start];
    }else if (self.isgameOver){
        [self clear];
    }
    else{
    [player jump];
    }
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    if ([contact.bodyA.node.name isEqualToString:@"ground"] || [contact.bodyB.node.name isEqualToString:@"ground"]) {
        [player land];
    }else
    {
        [self gameOver];
    }
    
}

-(void)animateWithPulse: (SKNode *)node
{
    SKAction *disappear = [SKAction fadeAlphaTo:0.0 duration:(0.6)];
    SKAction *appeare = [SKAction fadeAlphaTo:0.1 duration:(0.6)];
    SKAction *pulse = [SKAction sequence:@[disappear, appeare]];
    [node runAction:[SKAction repeatActionForever:pulse]];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
