//
//  GameScene.m
//  Exercise6Group7
//
//  Created by Jared Jones on 10/15/15.
//  Copyright (c) 2015 team7. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"

@interface GameScene()

@property (atomic, strong) NSNumber *score;
@property double timerStart;
@property double timerEnd;

@property (nonatomic, strong) SKLabelNode *timerLabel;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, strong) SKSpriteNode *player;
@property (nonatomic, strong) NSMutableSet *eggs;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor greenColor];
    
    //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    _timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _player = [SKSpriteNode spriteNodeWithImageNamed:@"basket"];
    _eggs = [[NSMutableSet alloc]init];
    _score = @0;
    
    _timerStart = [[NSDate date] timeIntervalSince1970];
    _timerEnd = [[NSDate date] timeIntervalSince1970] + 20;
    
    _timerLabel.text = [@"Time Left: " stringByAppendingString: [NSString stringWithFormat:@"%d", (int)((_timerEnd - _timerStart) / 10)]];
    _timerLabel.fontSize = 45;
    _scoreLabel.fontColor = [UIColor whiteColor];
    _timerLabel.position = CGPointMake(_timerLabel.frame.size.width / 2 + 10,self.view.frame.size.height - 45);
    
    _scoreLabel.text = @"Score: 0";
    _scoreLabel.fontColor = [UIColor blackColor];
    _scoreLabel.fontSize = 45;
    _scoreLabel.position = CGPointMake(self.view.frame.size.width - (_scoreLabel.frame.size.width / 2), self.view.frame.size.height - 45);
    
    
    [_player setScale:0.5];
    _player.position = CGPointMake(CGRectGetMidX(self.view.frame), _player.frame.size.height / 2);
    
    [self addChild:_timerLabel];
    [self addChild:_scoreLabel];
    [self addChild:_player];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //_player.position = CGPointMake(location.x, _player.position.y);
        
        SKAction *moveAction = [SKAction moveByX:(location.x - _player.position.x) y:0 duration:0.5];
        moveAction.timingMode = SKActionTimingEaseInEaseOut;
        [_player runAction:moveAction];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    
}

-(void)update:(CFTimeInterval)currentTime {
    
    int cTime = [[NSDate date] timeIntervalSince1970];
    
    int timeDiff = (int)((_timerEnd - cTime));
    
    if (timeDiff < 1){
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        GameOverScene *gameOverScene = [[GameOverScene alloc]initWithSize:self.size];
        [self.view presentScene:gameOverScene transition:reveal];
    }
    
    _timerLabel.text = [@"Time Left: " stringByAppendingString: [NSString stringWithFormat:@"%d", timeDiff]];
    
    NSMutableSet *objectsToRemove = [[NSMutableSet alloc] init];
    
    for (SKSpriteNode *egg in _eggs){
        BOOL col = (egg.position.x < (_player.position.x + _player.frame.size.width / 2)) && (egg.position.x > (_player.position.x - _player.frame.size.width / 2)) && egg.position.y < _player.frame.size.height/2;
        
        if (col){
            _score = [NSNumber numberWithInteger:[_score integerValue]+1];
            [egg removeFromParent];
            [objectsToRemove addObject:egg];
            
            NSString *s = @"Score: ";
            _scoreLabel.text = [s stringByAppendingString:[_score stringValue]];
        }else if (egg.position.y < 0){
            [egg removeFromParent];
            [objectsToRemove addObject:egg];
        }
    }
    
    [_eggs minusSet:objectsToRemove];
    
    _timerLabel.position = CGPointMake(_timerLabel.frame.size.width / 2 + 10,self.view.frame.size.height - 45);
    _scoreLabel.position = CGPointMake(self.view.frame.size.width - (_scoreLabel.frame.size.width / 2), self.view.frame.size.height - 45);
    
    NSInteger rand = arc4random() % 100;
    if (rand > 5)
        return;
    
    SKSpriteNode *egg = [SKSpriteNode spriteNodeWithImageNamed:@"egg"];
    [egg setScale:0.1];
    egg.position = CGPointMake(arc4random() % (int)self.view.frame.size.width, self.view.frame.size.height);
    egg.physicsBody.dynamic = YES;
    egg.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:egg.size.width/2];
    egg.physicsBody.affectedByGravity = YES;
    
    [_eggs addObject:egg];
    [self addChild:egg];
}

@end
