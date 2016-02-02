//
//  ViewController.m
//  AnimationHomework
//
//  Created by 2 on 2/1/16.
//  Copyright © 2016 2. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) BOOL isAnimated;
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
        
        // disabling implicit bounds animation
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           [NSNull null], @"bounds",
                                           nil];
        layer.actions = newActions;
        
        // multiplication on 18 becouse 15 + 3, where 15 - is width of layer and 3 - is space between layers
        if (i < 39) {
            layer.anchorPoint = CGPointMake(0.5, 1);
            layer.frame = CGRectMake(3 + i * 18, 99, 15, 87);
        }
        else {
            layer.anchorPoint = CGPointMake(0.5, 0);
            layer.frame = CGRectMake(3 + (i - 39) * 18, 189.5, 15, 87);
        }
        
        [self.view.layer addSublayer:layer];
    }
}

- (void)resizeLayerOnTouch:(UITouch *)touch {
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

- (void)doubleTapAction {
    if (self.isAnimated) {
        self.view.backgroundColor = [UIColor colorWithRed:25/255. green:54/255. blue:66/255. alpha:1];

        for (int i = 0; i < self.view.layer.sublayers.count; i++) {
            [self.view.layer.sublayers[i] removeAnimationForKey: @"danceAnimation"];
            if (i <= self.view.layer.sublayers.count / 2) {
                self.view.layer.sublayers[i].frame = CGRectMake(self.view.layer.sublayers[i].frame.origin.x, 99, 15, 87);
            }
            else {
                self.view.layer.sublayers[i].frame = CGRectMake(self.view.layer.sublayers[i].frame.origin.x, 189.5, 15, 87);
            }
        }
        
        self.isAnimated = NO;
        NSLog(@"Animation stoped");
    }
    else {
        self.view.backgroundColor = [UIColor colorWithRed:32/255. green:87/255. blue:110/255. alpha:1];
        int i = 0;
        
        for (CALayer *sublayer in self.view.layer.sublayers) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
            animation.fromValue = @0.0;
            animation.toValue = @87;
            animation.duration = .7;
            animation.repeatCount = INFINITY;
            animation.beginTime = CACurrentMediaTime() + i/16.5;
            animation.autoreverses = YES;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            [sublayer addAnimation:animation forKey:@"danceAnimation"];
            
            i++;
        }
        
        self.isAnimated = YES;
        NSLog(@"Animation started");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.isAnimated) {
        UITouch *touch = [touches anyObject];
        [self resizeLayerOnTouch:touch];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self resizeLayerOnTouch:touch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAnimated = NO;
    self.view.backgroundColor = [UIColor colorWithRed:25/255. green:54/255. blue:66/255. alpha:1];
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
