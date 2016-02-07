//
//  IAPointLabel.h
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface IAPointLabel : SKLabelNode

@property int number;
+(id)pointsLabelWithFontName:(NSString *) fontName;

-(void)increments;
+(void) setPonts: (int) points;
- (void) reset;


@end
