//
//  ViewController.m
//  MedsMinder
//
//  Created by Charles Northup on 9/15/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "CenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"

@interface CenterViewController ()
            
@property (weak, nonatomic) IBOutlet UIButton *myMenuButton;



@end

@implementation CenterViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)menuButtonPressed:(id)sender {
    MMDrawerController* draw = (id)self.view.window.rootViewController;
    [draw toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [UIView animateWithDuration:0.25 animations:^{
            CGAffineTransform cgaRotateHr = CGAffineTransformMakeRotation((3.141/2));
        [self.myMenuButton setTransform:cgaRotateHr];
    } completion:^(BOOL finished) {
        
    }];
}

+(void)rotateMenu:(BOOL)closing
{
    if (closing)
    {
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CenterViewController* c = (CenterViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"CenterViewController"];
        [c openMenu];
    }
    else
    {
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CenterViewController* c = (CenterViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"CenterViewController"];
        [c openMenu];
    }
}

-(void)openMenu
{
    [UIView animateWithDuration:0.25 animations:^{
        CGAffineTransform cgaRotateHr = CGAffineTransformMakeRotation((3.141/2));
        [self.myMenuButton setTransform:cgaRotateHr];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)closeMenu
{
    [UIView animateWithDuration:0.25 animations:^{
        CGAffineTransform cgaRotateHr = CGAffineTransformMakeRotation(-(3.141/2));
        [self.myMenuButton setTransform:cgaRotateHr];
    } completion:^(BOOL finished) {
        
    }];
}
@end
