//
//  ViewController.m
//  AnimationHomework
//
//  Created by 2 on 2/1/16.
//  Copyright © 2016 2. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)addSublayersToMainLayer {
    for (int i = 0; i < 78; i++) {
        CALayer *layer = [[CALayer alloc] init];
        layer.cornerRadius = 5.;
        
        if (i < 2 || (i >= 37 && i < 41) || i > 75) {
            layer.backgroundColor = [UIColor colorWithRed:32/255. green:87/255. blue:110/255. alpha:1].CGColor;
        }
        
        if ((i >= 2 && i < 6) || (i >= 33 && i < 37) || (i >= 41 && i < 45) || (i >= 72 && i < 76)) {
            layer.backgroundColor = [UIColor colorWithRed:70/255. green:154/255. blue:184/255. alpha:1].CGColor;
        }
        
        if ((i >= 6 && i < 10) || (i >= 29 && i < 33) || (i >= 45 && i < 49) || (i >= 68 && i < 72)) {
            layer.backgroundColor = [UIColor colorWithRed:109/255. green:179/255. blue:191/255. alpha:1].CGColor;
        }
        
        if ((i >= 10 && i < 14) || (i >= 25 && i < 29) || (i >= 49 && i < 53) || (i >= 64 && i < 68)) {
            layer.backgroundColor = [UIColor colorWithRed:149/255. green:207/255. blue:202/255. alpha:1].CGColor;
        }
        
        if ((i >= 14 && i < 18) || (i >= 21 && i < 25) || (i >= 53 && i < 57) || (i >= 60 && i < 64)) {
            layer.backgroundColor = [UIColor colorWithRed:207/255. green:233/255. blue:244/255. alpha:1].CGColor;
        }
        
        if ((i >= 18 && i < 21) || (i >= 57 && i < 60)) {
            layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
        }
        
        // mult on 18 becouse of 15 + 3, where 15 - is width of layer and 3 - is space between layers
        if (i < 39) {
            layer.frame = CGRectMake(3 + i * 18, 99, 15, 87);
        }
        else {
            layer.frame = CGRectMake(3 + (i - 39) * 18, 189.5, 15, 87);
        }
        
        [self.view.layer addSublayer:layer];
    }
}

- (void)resizeLayerFromTouch:(UITouch *)touch {
    CALayer *layer;
    CGPoint position = [touch locationInView:touch.view];
    
    for (CALayer *sublayer in self.view.layer.sublayers) {
        if (position.x > sublayer.frame.origin.x && position.x < sublayer.frame.origin.x + 15) {
            if (position.y <= 186.5) {
                layer = sublayer;
                break;
            }
            else {
                layer = sublayer;
            }
        }
    }
    
    if (position.y <= 186.5) {
        layer.frame = CGRectMake(layer.frame.origin.x, position.y, layer.frame.size.width, 186.5 - position.y);
    }
    else {
        layer.frame = CGRectMake(layer.frame.origin.x, layer.frame.origin.y, layer.frame.size.width, position.y - 186.5);
    }

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self resizeLayerFromTouch:touch];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self resizeLayerFromTouch:touch];
}

- (void)doubleTapAction {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"bounds.size.height";
    animation.values = @[ @0, @50, @20 ];
    animation.duration = 1.2;
    
    for( CALayer *sublayer in self.view.layer.sublayers) {
        [sublayer addAnimation:animation forKey:@"shake"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addSublayersToMainLayer];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
