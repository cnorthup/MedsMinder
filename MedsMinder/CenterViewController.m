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
#import "MedicationHeaderView.h"
#import "Medication.h"
#import "MedCustomCell.h"

@interface CenterViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
            
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
@property (strong, nonatomic) UIView* headerView;
@property (nonatomic) CGRect orginalTablview;



@end

@implementation CenterViewController
            
-(void)viewDidLoad{
    [super viewDidLoad];
    self.orginalTablview = self.myTableView.frame;
    self.medsOpen = NO;
    self.supsOpen = NO;
    self.medsArray = [NSMutableArray arrayWithArray:@[@"dog", @"cat", @"mouse", @"dog", @"cat", @"mouse"]];
    self.supsArray = [NSMutableArray arrayWithArray:@[@"bird", @"turtle", @"shark"]];
    self.supsColor = self.supsColorView.backgroundColor;
    self.medsColor = self.medsColorView.backgroundColor;
    NSFetchRequest* request = [[NSFetchRequest alloc]initWithEntityName:@"Medication"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"type" cacheName:@"rogueNotion"];
    
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
    
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    
    [self.myTableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
    [self.myTableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    
    if (type == NSFetchedResultsChangeInsert) {
        [self.myTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    if (type == NSFetchedResultsChangeInsert) {
        [self.myTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeUpdate) {
        [self.myTableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedCustomCell* cell = (MedCustomCell*)[tableView dequeueReusableCellWithIdentifier:@"DetailCellID"];
    CGRect screen = [[UIScreen mainScreen]bounds];

    if (indexPath.section == 0) {
            cell.backgroundColor = self.medsColor;

    }
    else{
            cell.backgroundColor = self.supsColor;
    }
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if (self.medsOpen == YES) {
                return self.medsArray.count;

            }
            else{
                return 0;
            }
            break;

        default:
            if (self.supsOpen == YES) {
                return self.supsArray.count;
                
            }
            else{
                return 0;
            }
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                //[self toggleMedsList];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];

            }
            else{
                
            }
            break;
        case 1:
            if (indexPath.row == 0) {
               // [self toggleSupsList];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];

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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Medication";
            break;
            
        default:
            return @"Supliments";
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = tableView.frame;
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-60, 10, 50, 30)];
    addButton.backgroundColor = [UIColor redColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    UITapGestureRecognizer *medTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleMedsList)];
    medTapGesture.cancelsTouchesInView = YES;
    UITapGestureRecognizer *supTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleSupsList)];
    supTapGesture.cancelsTouchesInView = YES;
    [self.headerView addSubview:title];
    [self.headerView addSubview:addButton];
    
    switch (section) {
        case 0:
            title.text = @"Medication";
            [self.headerView addGestureRecognizer:medTapGesture];
            self.headerView.backgroundColor = self.supsColor;
            break;
            
        default:
            title.text = @"Supliments";
            [self.headerView addGestureRecognizer:supTapGesture];
            self.headerView.backgroundColor = self.medsColor;
            break;
    }
    return self.headerView;

}


-(void)toggleMedsList
{
    self.medsOpen =! self.medsOpen;
    [self.myTableView reloadData];
    self.myTableView.frame = [CenterViewController expandTableView:self.myTableView];

//    [UIView animateWithDuration:.5 animations:^{
//        [self.myTableView reloadData];
//        self.myTableView.frame = [CenterViewController expandTableView:self.myTableView];
//        
//    }];
}

-(void)toggleSupsList
{
    self.supsOpen =! self.supsOpen;
    [self.myTableView reloadData];
    self.myTableView.frame = [CenterViewController expandTableView:self.myTableView];

//    [UIView animateWithDuration:.5 animations:^{
//        [self.myTableView reloadData];
//        self.myTableView.frame = [CenterViewController expandTableView:self.myTableView];
//
//    }];
}

+(CGRect)expandTableView:(UITableView*)orignalFrame
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGRect view = CGRectZero;
    NSLog(@"%f", orignalFrame.contentSize.height);
    if (orignalFrame.contentSize.height < screen.size.height - 200) {
        view = CGRectMake(0, screen.size.height - orignalFrame.contentSize.height - 10, screen.size.width, orignalFrame.contentSize.height);
    }
    else
    {
        view = CGRectMake(0, 90, screen.size.width, screen.size.height - 100);
    }
    
    return view;
    
}

//-(CGRect)compressTableView:(BOOL)meds sups:(BOOL)sups
//{
//    if ((meds == YES) && (sups == NO))
//    {
//        sel
//    }
//    else if ((meds == NO) && (sups == NO))
//    {
//        return self.orginalTablview;
//    }
//}

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
