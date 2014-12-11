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
#import "NewPillViewController.h"

@interface CenterViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>
            
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
@property (strong, nonatomic) NSIndexPath* selectedCell;



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
    else if (type == NSFetchedResultsChangeDelete){
        [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    if (type == NSFetchedResultsChangeInsert) {
        [self.myTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeUpdate) {
        [self.myTableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (type == NSFetchedResultsChangeDelete){
        [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedCustomCell* cell = (MedCustomCell*)[tableView dequeueReusableCellWithIdentifier:@"DetailCellID"];
    Medication* meds = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.medNameLabel.text = meds.name;
    cell.dosageLabel.text = [NSString stringWithFormat:@"%@ mg", meds.dosage];
    if (indexPath == self.selectedCell) {
        cell = [cell openCell:cell];
    }
    else
    {
        cell = [cell closeCell:cell];
    }
    //CGRect screen = [[UIScreen mainScreen]bounds];

    if ([meds.type isEqualToString:@"Medication"]) {
        cell.backgroundColor = self.medsColor;
    }
    else{
            cell.backgroundColor = self.supsColor;
    }
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedCell != nil) {
        if (self.selectedCell == indexPath) {
            self.selectedCell = nil;
            [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        }
        else{
            NSIndexPath* oldCell = self.selectedCell;
            self.selectedCell = indexPath;
            [self.myTableView reloadRowsAtIndexPaths:@[indexPath, oldCell] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else
    {
        self.selectedCell = indexPath;
        [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath == self.selectedCell) {
            return 118;
        }
        else
        {
            return 44;
        }


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections objectAtIndex:section] name];
}

- (IBAction)editButtonPressed:(id)sender
{
    UIAlertView* deleteView = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure you want to delete this?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [deleteView show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSError* error = [NSError errorWithDomain:@"Error" code:98 userInfo:nil];

    if ([alertView.title isEqualToString:@"Delete"]) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel");
                break;
                
            default:
                //Medication* med = [Medication new];
                NSLog(@"%@", [self.fetchedResultsController objectAtIndexPath:self.selectedCell]);
                [self.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:self.selectedCell]];
                self.selectedCell = nil;
                [self.managedObjectContext save:&error];
                //[];
                break;
        }
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CGRect frame = tableView.frame;
//    
//    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-60, 10, 50, 30)];
//    addButton.backgroundColor = [UIColor redColor];
//    
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
//    
//    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    UITapGestureRecognizer *medTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleMedsList)];
//    medTapGesture.cancelsTouchesInView = YES;
//    UITapGestureRecognizer *supTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleSupsList)];
//    supTapGesture.cancelsTouchesInView = YES;
//    [self.headerView addSubview:title];
//    [self.headerView addSubview:addButton];
//    
//    switch (section) {
//        case 0:
//            title.text = @"Medication";
//            [self.headerView addGestureRecognizer:medTapGesture];
//            self.headerView.backgroundColor = self.supsColor;
//            break;
//            
//        default:
//            title.text = @"Supliments";
//            [self.headerView addGestureRecognizer:supTapGesture];
//            self.headerView.backgroundColor = self.medsColor;
//            break;
//    }
//    return self.headerView;
//
//}


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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NewPillViewController* vc = segue.destinationViewController;
    vc.managedObjectContext = self.managedObjectContext;
    //vc.meds = sender;
}

-(IBAction)addPillButton:(id)sender
{
    //Medication* newMeds = [NSEntityDescription insertNewObjectForEntityForName:@"Medication" inManagedObjectContext:self.managedObjectContext];
    [self performSegueWithIdentifier:@"AddPillSegue" sender:self];
}

-(IBAction)confirmPill:(UIStoryboardSegue*)sender
{
    NewPillViewController* newPill = sender.sourceViewController;
    Medication* newMeds = newPill.meds;
    [self.managedObjectContext save:nil];
//    if (newPill.medication == YES) {
//        Medication* newMeds = newPill.meds;
//        [self.managedObjectContext save:nil];
//    }
//    else
//    {
//        Suppliments* newSups == newPill.sups;
//        [self.managedObjectContext save:nil];
//    }
    
}

-(IBAction)cancelPill:(UIStoryboardSegue*)sender
{
//    NewPillViewController* canceledPill = sender.sourceViewController;
//    
//    if (canceledPill.medication == YES) {
//        Medication* newMeds = canceledPill.meds;
//        [self.managedObjectContext deleteObject:newMeds];
//    }
//    else
//    {
//        Suppliments* newSups == canceledPill.sups;
//        [self.managedObjectContext deleteObject:newSups];
//    }
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
