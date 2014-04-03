//  MasterDetailview
//  Created by Zakk Hoyt
//  Copyright (c) 2014 Threefold photos. All rights reserved.


#define MASTER_WIDTH 265

#import "MasterDetailController.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MasterDetailController () <DetailViewControllerDelegate>
@property BOOL masterVisible;
@property (nonatomic, retain) UIView *masterView;
@property (nonatomic, retain) UIView *detailView;
@property (nonatomic, assign) UIViewController *masterController;
@property (nonatomic, assign) DetailViewController *detailController;
@end

@implementation MasterDetailController


#pragma mark UIViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.detailController = (DetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    self.detailController.delegate = self;
    [self changeDetailView:self.detailController];
}


#pragma mark Private methods


- (void) changeDetailView:(UIViewController *)detailController
{
    // Setup view frame
    CGRect frameForView = self.view.frame;
    
    UIView *view = detailController.view;
    CGRect offscreenLeftFrame = frameForView;
    offscreenLeftFrame.origin.x = -offscreenLeftFrame.size.width;
    view.frame = offscreenLeftFrame;
    view.hidden = NO;
    view.alpha = 1.0;
    
    
    // Shadow
    detailController.view.layer.shadowOffset = CGSizeMake(-1, -1);
    detailController.view.layer.shadowRadius = 5;
    detailController.view.layer.shadowOpacity = 1.0;
    detailController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    detailController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:detailController.view.bounds].CGPath;
    
    
    // Add gesture recognizers
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(performSwipe:)];
    [swipe setNumberOfTouchesRequired:1];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [detailController.view addGestureRecognizer:swipe];
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(performSwipe:)];
    [swipe setNumberOfTouchesRequired:1];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [detailController.view addGestureRecognizer:swipe];
    
    // Add child view and animate in
    [self addChildViewController:detailController];
    [self.view addSubview:detailController.view];
    [detailController didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = frameForView;
    } completion:^(BOOL finished) {
        
    }];

}

-(void)performSwipe:(UISwipeGestureRecognizer*)swipe{
    UISwipeGestureRecognizerDirection direction = [swipe direction];
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            if(self.masterVisible)
                [self showMaster:NO];
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            if(!self.masterVisible)
                [self showMaster:YES];
            break;
        default:
            break;
    }
}

- (void) showMaster:(BOOL) shouldShow
{
    
    if(self.masterVisible == NO){
        self.masterVisible = YES;
        CGRect masterShowingRect = self.view.frame;
        masterShowingRect.origin.x += MASTER_WIDTH;
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.detailController.view.frame = masterShowingRect;
//            self.detailController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        self.masterVisible = NO;
        CGRect masterShowingRect = self.view.frame;
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.detailController.view.frame = masterShowingRect;
//            self.detailController.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

#pragma mark DetailViewControllerDelegate
-(void)detailViewControllerMasterButtonTouchUpInside:(DetailViewController*)sender{
    [self showMaster:!self.masterVisible];
}


@end
