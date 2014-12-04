//
//  NewPillViewController.m
//  MedsMinder
//
//  Created by Charles Northup on 12/3/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "NewPillViewController.h"


@interface NewPillViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dosageTextField;

@end

@implementation NewPillViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"typed %@", textField.text);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (IBAction)addPillButtonPressed:(id)sender
{
    if ((![self.nameTextField.text isEqualToString:@""]) && (![self.dosageTextField.text isEqualToString:@""]))
    {
        Medication* newMeds = [NSEntityDescription insertNewObjectForEntityForName:@"Medication" inManagedObjectContext:self.managedObjectContext];
        newMeds.name = self.nameTextField.text;
        newMeds.dosage = self.dosageTextField.text;
        newMeds.type = @"Medication";
        self.meds = newMeds;
        [self performSegueWithIdentifier:@"ComfirmPillSegue" sender:self];
    }
}


@end