//
//  NewPillViewController.h
//  MedsMinder
//
//  Created by Charles Northup on 12/3/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"
#import "Medication.h"

@interface NewPillViewController : UIViewController

@property (strong, nonatomic) Medication* meds;
@property (nonatomic) bool medication;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
