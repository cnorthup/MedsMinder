//
//  MyMMDrawerController.m
//  MedsMinder
//
//  Created by Charles Northup on 9/15/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "MyMMDrawerController.h"
#import "CenterViewController.h"


@interface MyMMDrawerController ()


@end

@implementation MyMMDrawerController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//}

-(void)closeDrawerAnimated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    animated = YES;
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CenterViewController* centerVC = [storyBoard instantiateViewControllerWithIdentifier:@"CenterViewController"];
    [centerVC closeMenu];
    
}
-(void)openDrawerSide:(MMDrawerSide)drawerSide animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    drawerSide = MMDrawerSideLeft;
    animated = YES;
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CenterViewController* centerVC = [storyBoard instantiateViewControllerWithIdentifier:@"CenterViewController"];
    [centerVC openMenu];
}

@end