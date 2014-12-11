//
//  NewPillViewController.m
//  MedsMinder
//
//  Created by Charles Northup on 12/3/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "NewPillViewController.h"
#import "MTBBarcodeScanner.h"
#import <AVFoundation/AVFoundation.h>


@interface NewPillViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dosageTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) MTBBarcodeScanner* scanner;
@property (strong, nonatomic) NSMutableArray* uniqueCodes;


@end

@implementation NewPillViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.view];
    //self.scanner = [[MTBBarcodeScanner alloc] initWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]previewView:self.view];

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
- (IBAction)scanBarcodeButtonPressed:(id)sender
{
    [self scanBarcode];
}

-(void)scanBarcode
{
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                NSLog(@"Found code: %@", code.stringValue);
                
                [self.scanner stopScanning];
            }];
            
        } else {
            // The user denied access to the camera
        }
    }];
//    NSLog(@"start scanning");
//    [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
//        for (AVMetadataMachineReadableCodeObject *code in codes) {
//            NSLog(@"scanning");
//            if ([self.uniqueCodes indexOfObject:code.stringValue] == NSNotFound) {
//                [self.uniqueCodes addObject:code.stringValue];
//                NSLog(@"Found unique code: %@", code.stringValue);
//            }
//        }
//    }];
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