//
//  DetailViewController.h
//  MasterDetailview
//
//  Created by Rasmus Styrk on 8/26/12.
//  Copyright (c) 2012 Styrk-IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@protocol DetailViewControllerDelegate <NSObject>
-(void)detailViewControllerMasterButtonTouchUpInside:(DetailViewController*)sender;
@end

@interface DetailViewController : UIViewController
@property (nonatomic, weak) id <DetailViewControllerDelegate> delegate;
@end
