//
//  GameScene.m
//  Exercise6Group7
//
//  Created by Jared Jones on 10/15/15.
//  Copyright (c) 2015 team7. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Game Over!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        [touch description];
        
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        GameScene *gameScene = [[GameScene alloc]initWithSize:self.size];
        [self.view presentScene:gameScene transition:reveal];
        break;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
