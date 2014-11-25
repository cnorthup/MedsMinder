//
//  MedicationHeaderView.m
//  MedsMinder
//
//  Created by Charles Northup on 11/25/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "MedicationHeaderView.h"

@interface MedicationHeaderView ()

@end

@implementation MedicationHeaderView

+(MedicationHeaderView*)initFromNibFile:(NSString*)viewName
{
    NSArray* nibView = [[NSBundle mainBundle] loadNibNamed:viewName owner:nil options:nil];
    
    MedicationHeaderView* view = nibView.firstObject;
    view.quickAddMedButton.enabled = YES;
    return view;
    
}

- (IBAction)quickAddButtonPressed:(id)sender
{
    NSLog(@"hello");
}

@end
