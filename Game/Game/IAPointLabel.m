//
//  IAPointLabel.m
//  Game
//
//  Created by Iliyana Antova on 2/2/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

#import "IAPointLabel.h"

@implementation IAPointLabel

+ (id)pointsLabelWithFontName:(NSString *) fontName
{
    IAPointLabel *pointsLabel = [IAPointLabel labelNodeWithFontNamed:fontName];
    pointsLabel.name = @"pointLabel";
    pointsLabel.text = @"0";
    pointsLabel.number = 0;
    return pointsLabel;
}
-(void)increments
{
    self.number ++;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

-(void) setPints: (int) points
{
    self.number = points;
    self. text = [NSString stringWithFormat:@"%i", self.number];
}

- (void) reset
{
    self.number = 0;
    self.text = @"0";
}

@end
