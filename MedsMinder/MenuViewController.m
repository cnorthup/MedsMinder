//
//  MenuViewController.m
//  MedsMinder
//
//  Created by Charles Northup on 9/15/14.
//  Copyright (c) 2014 Contract. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark-- TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
