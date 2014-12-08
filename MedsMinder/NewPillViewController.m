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
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation NewPillViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.typeLabel.text = @"Medication";
    self.nameTextField.enabled = YES;
    self.dosageTextField.enabled = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"typed %@", textField.text);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
- (IBAction)switchButtonPressed:(UISwitch*)sender
{
    if (sender.on) {
        self.typeLabel.text = @"Medication";
    }
    else{
        self.typeLabel.text = @"Suppliments";
    }
}

- (IBAction)addPillButtonPressed:(id)sender
{
    if ((![self.nameTextField.text isEqualToString:@""]) && (![self.dosageTextField.text isEqualToString:@""]))
    {
        Medication* newMeds = [NSEntityDescription insertNewObjectForEntityForName:@"Medication" inManagedObjectContext:self.managedObjectContext];
        newMeds.name = self.nameTextField.text;
        newMeds.dosage = self.dosageTextField.text;
        if (self.switchButton.on) {
            newMeds.type = @"Medication";
        }
        else
        {
            newMeds.type = @"Suppliments";
        }
        self.meds = newMeds;
        [self performSegueWithIdentifier:@"ComfirmPillSegue" sender:self];
    }
}


@end