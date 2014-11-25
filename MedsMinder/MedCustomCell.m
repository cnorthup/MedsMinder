//
//  MedCustomCell.m
//  MedsMinder
//
//  Created by Charles Northup on 11/25/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "MedCustomCell.h"


@interface MedCustomCell ()


@end

@implementation MedCustomCell

-(MedCustomCell*)initWithMedication:(Medication*)med
{
    MedCustomCell* cell = [MedCustomCell new];
    cell.medNameLabel.text = med.name;
    cell.frequencyLabel.text = med.frequency;
    cell.dosageLabel.text = med.dosage;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"mm/dd/yyyy"];
    cell.lastRefillLabel.text = [formatter stringFromDate:med.lastRefill];
    return cell;
}

@end