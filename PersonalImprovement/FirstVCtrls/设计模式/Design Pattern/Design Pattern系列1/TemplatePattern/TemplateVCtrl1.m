//
//  ViewController.m
//  TemplatePattern
//
//  Created by YouXianMing on 15/10/27.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "TemplateVCtrl1.h"
#import "Monopoly.h"
#import "Chess.h"

@interface TemplateVCtrl1 ()

@end

@implementation TemplateVCtrl1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // chess game
    id <GameProtocol> chess = [[Chess alloc] init];
    chess.playerCount       = 2;
    [chess initializeGame];
    [chess makePlay];
    [chess endOfGame];
    
    // monopoly game
    id <GameProtocol> monopoly = [[Monopoly alloc] init];
    monopoly.playerCount       = 4;
    [monopoly initializeGame];
    [monopoly makePlay];
    [monopoly endOfGame];
}

@end
