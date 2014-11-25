//
//  MedicationHeaderView.h
//  MedsMinder
//
//  Created by Charles Northup on 11/25/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface MedicationHeaderView: UIView

@property (weak, nonatomic) IBOutlet UIButton *quickAddMedButton;

+(MedicationHeaderView*)initFromNibFile:(NSString*)viewName;

@end

