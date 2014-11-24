//
//  ViewController.m
//  MedsMinder
//
//  Created by Charles Northup on 9/15/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

//NYC cheek glow powder blush, color is central park pink

#import "CenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"

@interface CenterViewController ()<UITableViewDataSource, UITableViewDelegate>
            
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *myMenuButton;
@property bool medsOpen;
@property bool supsOpen;
@property (strong, nonatomic) NSMutableArray* medsArray;
@property (strong, nonatomic) NSMutableArray* supsArray;
@property (strong, nonatomic) UIColor* medsColor;
@property (strong, nonatomic) UIColor* supsColor;
@property (weak, nonatomic) IBOutlet UIView *medsColorView;
@property (weak, nonatomic) IBOutlet UIView *supsColorView;



@end

@implementation CenterViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.medsOpen = NO;
    self.supsOpen = NO;
    self.medsArray = [NSMutableArray arrayWithArray:@[@"dog", @"cat"]];
    self.supsArray = [NSMutableArray arrayWithArray:@[@"bird", @"turtle"]];
    self.supsColor = self.supsColorView.backgroundColor;
    self.medsColor = self.medsColorView.backgroundColor;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCellID"];
            cell.textLabel.text = @"Medication";
            cell.backgroundColor = self.medsColor;
            return cell;
        }
        else{
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCellID"];
            cell.textLabel.text = [self.medsArray objectAtIndex:indexPath.row - 1];
            cell.backgroundColor = self.medsColor;
            return cell;
        }

    }
    else{
        if (indexPath.row == 0) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCellID"];
            cell.textLabel.text = @"Supliments";
            cell.backgroundColor = self.supsColor;
            return cell;
        }
        else{
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCellID"];
            cell.textLabel.text = [self.supsArray objectAtIndex:indexPath.row - 1];
            cell.backgroundColor = self.supsColor;
            return cell;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if (self.medsOpen == YES) {
                return self.medsArray.count + 1;
            }
            else{
                return 1;
            }
            break;
        case 1:
            if (self.supsOpen) {
                return self.supsArray.count + 1;
            }
            else{
                return 1;
            }
            
        default:
            return 2;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                NSLog(@"selected");
                [self toggleMedsList];
            }
            else{
                
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                [self toggleSupsList];
            }
            else{
                
            }
        default:
            break;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(void)toggleMedsList
{
    self.medsOpen =! self.medsOpen;
    NSLog(@"hi");
    [self.myTableView reloadData];
}

-(void)toggleSupsList
{
    self.supsOpen =! self.supsOpen;
    [self.myTableView reloadData];
}

- (IBAction)menuButtonPressed:(id)sender {
//    MMDrawerController* draw = (id)self.view.window.rootViewController;
//    [draw toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//    [UIView animateWithDuration:0.25 animations:^{
//            CGAffineTransform cgaRotateHr = CGAffineTransformMakeRotation((3.141/2));
//        [self.myMenuButton setTransform:cgaRotateHr];
//    } completion:^(BOOL finished) {
//        
//    }];
}

//+(void)rotateMenu:(BOOL)closing
//{
//    if (closing)
//    {
//        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        CenterViewController* c = (CenterViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"CenterViewController"];
//        [c openMenu];
//    }
//    else
//    {
//        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        CenterViewController* c = (CenterViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"CenterViewController"];
//        [c openMenu];
//    }
//}

//-(void)openMenu
//{
//    [UIView animateWithDuration:0.25 animations:^{
//        CGAffineTransform cgaRotateHr = CGAffineTransformMakeRotation((3.141/2));
//        [self.myMenuButton setTransform:cgaRotateHr];
//    } completion:^(BOOL finished) {
//        
//    }];
//}

//-(void)closeMenu
//{
//    [UIView animateWithDuration:0.25 animations:^{
//        CGAffineTransform cgaRotateHr = CGAffineTransformMakeRotation(-(3.141/2));
//        [self.myMenuButton setTransform:cgaRotateHr];
//    } completion:^(BOOL finished) {
//        
//    }];
//}
@end
