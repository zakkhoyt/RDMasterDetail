//
//  DetailViewController.m
//  MasterDetailview
//
//  Created by Rasmus Styrk on 8/26/12.
//  Copyright (c) 2012 Styrk-IT. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterDetailController.h"

@implementation DetailViewController

- (IBAction)toggleMasterButtonTouchUpInside:(id)sender {
    [self.delegate detailViewControllerMasterButtonTouchUpInside:self];
}

@end
