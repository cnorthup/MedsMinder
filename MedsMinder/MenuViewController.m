//
//  MenuViewController.m
//  MedsMinder
//
//  Created by Charles Northup on 9/15/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "MenuViewController.h"
#import "Medication.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>



@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFetchRequest* request = [[NSFetchRequest alloc]initWithEntityName:@"Medication"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"type" cacheName:@"rogueNotion"];
    
    
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
    
}



#pragma mark-- TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.fetchedResultsController.sections.count == 0)
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCellReuseID"];
        return cell;
    }
    else{
        Medication* medication = [self.fetchedResultsController objectAtIndexPath:indexPath];
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCellReuseID"];
        cell.textLabel.text = medication.name;
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
//    return self.fetchedResultsController.sections.count + 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
            
        case 1:
            if (self.fetchedResultsController.sections.count == 0)
            {
                return 2;
            }
            else{
                return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
            }
            break;
            
        case 2:
            if (self.fetchedResultsController.sections.count == 0)
            {
                return 2;
            }
            else{
                return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
            }
            break;
            
        default:
            return 1;
            break;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Options";
            break;
        
        case 1:
            return @"Medication";
            break;
        
        case 2:
            return @"Suppliments";
            break;
            
        default:
            return @"To Many Sections";
            break;
    }
}

@end
