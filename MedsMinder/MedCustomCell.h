//
//  MedCustomCell.h
//  MedsMinder
//
//  Created by Charles Northup on 11/25/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medication.h"

@interface MedCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *takenMedsImageView;
@property (weak, nonatomic) IBOutlet UILabel *medNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastRefillLabel;
@property (weak, nonatomic) IBOutlet UILabel *dosageLabel;
@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *quanityLabel;


-(MedCustomCell*)openCell:(MedCustomCell*)cell;
-(MedCustomCell*)closeCell:(MedCustomCell*)cell;


@end