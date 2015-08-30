//
//  MenuViewController.h
//  tcc-ios
//
//  Created by Diego on 7/30/15.
//  Copyright (c) 2015 ifsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField * textFieldURL;
@property (nonatomic, strong) IBOutlet UITextField * textFieldModel;
@property (nonatomic, strong) IBOutlet UITextField * textFieldUsername;
@property (nonatomic, strong) IBOutlet UITextField * textFieldPassword;

@property (nonatomic, strong) IBOutlet UITextField * textFieldParam1;
@property (nonatomic, strong) IBOutlet UITextField * textFieldParam2;
@property (nonatomic, strong) IBOutlet UITextField * textFieldParam3;
@property (nonatomic, strong) IBOutlet UITextView * textViewRequest;

@property (nonatomic, strong) IBOutlet UISegmentedControl * segmentedControl;

- (IBAction)enviarButtonTap:(id)sender;

@end
