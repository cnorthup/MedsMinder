//
//  Medication.h
//  MedsMinder
//
//  Created by Charles Northup on 9/30/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "CoreData/CoreData.h"
#import "Foundation/Foundation.h"

@interface Medication : NSManagedObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* frequency;
@property (nonatomic, retain) NSDate* lastRefill;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* dosage;
@property (nonatomic, retain) id barcode;

@end

@interface Medication (CoreDataGeneratedAccessors)

-(void)setName:(NSString *)name;
-(void)setFrequency:(NSString *)frequency;
-(void)setLastTaken:(NSDate *)lastRefill;
-(void)setType:(NSString *)type;
-(void)setDosage:(NSString *)dosage;
-(void)setBarcode:(id)barcode;


@end