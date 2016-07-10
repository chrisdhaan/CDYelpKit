//
//  CDViewController.m
//  CDYelpKit
//
//  Created by Christopher de Haan on 06/29/2016.
//  Copyright (c) 2016 Christopher de Haan. All rights reserved.
//

#import <CDYelpKit/CDYelpKit.h>
#import <MapKit/MapKit.h>

#import "CDViewController.h"

@interface CDViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITextField *searchTermTextField;
@property (nonatomic, weak) IBOutlet UITextField *limitTextField;
@property (nonatomic, weak) IBOutlet UITextField *offsetTextField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *sortTypeSegmentedControl;
@property (nonatomic, weak) IBOutlet UIButton *categoriesButton;
@property (nonatomic, weak) IBOutlet UITextField *radiusTextField;
@property (nonatomic, weak) IBOutlet UISwitch *dealsSwitch;
@property (nonatomic, weak) IBOutlet UIButton *searchYelpButton;

@end

@implementation CDViewController {
    CDYelpKit *yelpKit;
}

#pragma mark - Initialization Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    yelpKit = [[CDYelpKit alloc] initWithConsumerKey:@"tPaCOcHvMIo_aIDL4jFqPw"
                                      consumerSecret:@"W_q1ACetRjYbxnawi7F2R3VPXyc"
                                               token:@"9L_Mjmot-lNHcF4UNfxn7M60OwKEAjVH"
                                         tokenSecret:@"J-lVxUaPiAq2qOiRWJ-o4Yck0oY"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Methods

- (IBAction)categoriesButtonPressed:(id)sender {
    
}

- (IBAction)searchYelpButtonPressed:(id)sender {
    NSString *searchTerm = self.searchTermTextField.text;
    NSInteger limit = [self.limitTextField.text integerValue];
    NSInteger offset = [self.offsetTextField.text integerValue];
    CDYelpSortType sortType = self.sortTypeSegmentedControl.selectedSegmentIndex;
    NSArray *categories = @[];
    NSInteger radius = [self.radiusTextField.text integerValue];
    BOOL hasDeals = self.dealsSwitch.on;
    
    [yelpKit searchYelpBusinessesWithSearchTerm:searchTerm
                                      withLimit:limit
                                     withOffset:offset
                                   withSortType:sortType
                                 withCategories:categories withRadiusFilter:radius
                                withDealsFilter:hasDeals
                            withRequestLocation:nil completionBlock:^(BOOL successful, NSError * _Nullable error, NSMutableArray * _Nullable results) {
                                
                                NSLog(@"%@", results);
                            }];
}

@end
