//
//  MedCustomCell.m
//  MedsMinder
//
//  Created by Charles Northup on 11/25/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "MedCustomCell.h"


@interface MedCustomCell ()
@property (weak, nonatomic) IBOutlet UILabel *lastRFTitle;
@property (weak, nonatomic) IBOutlet UILabel *frequencyTitle;
@property (weak, nonatomic) IBOutlet UILabel *quanityTitle;
@property (weak, nonatomic) IBOutlet UIButton *editButton;


@end

@implementation MedCustomCell

-(MedCustomCell*)initWithMedication:(Medication*)med
{
    MedCustomCell* cell = [MedCustomCell new];
    cell.medNameLabel.text = med.name;
    cell.dosageLabel.text = med.dosage;
    
//    cell.frequencyLabel.text = med.frequency;
//    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"mm/dd/yyyy"];
//    cell.lastRefillLabel.text = [formatter stringFromDate:med.lastRefill];
    return cell;
}

-(MedCustomCell*)openCell:(MedCustomCell*)cell
{
    cell.lastRefillLabel.hidden = NO;
    cell.quanityLabel.hidden = NO;
    cell.frequencyLabel.hidden = NO;
    cell.imageView.hidden = NO;
    cell.lastRFTitle.hidden = NO;
    cell.quanityTitle.hidden = NO;
    cell.frequencyTitle.hidden = NO;
    cell.editButton.hidden = NO;
    return cell;
}

-(MedCustomCell*)closeCell:(MedCustomCell*)cell
{
    cell.lastRefillLabel.hidden = YES;
    cell.quanityLabel.hidden = YES;
    cell.frequencyLabel.hidden = YES;
    cell.imageView.hidden = YES;
    cell.lastRFTitle.hidden = YES;
    cell.quanityTitle.hidden = YES;
    cell.frequencyTitle.hidden = YES;
    cell.editButton.hidden = YES;
    return cell;
}

@end