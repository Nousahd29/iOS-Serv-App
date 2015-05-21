//
//  ReservationVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "ReservationVC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "ReservationDetailVC.h"
#import "NIDropDown.h"

@interface ReservationVC ()

@end

@implementation ReservationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TappedOnSubmitBtn:(id)sender
{
    if (![self.lbl_Type.text isEqualToString:@""] && ![self.lbl_zipCode.text isEqualToString:@""])
    {
        ReservationDetailVC *reservationDetailView=[self.storyboard instantiateViewControllerWithIdentifier:@"ReservationDetailVC"];
        reservationDetailView.str_type=self.lbl_Type.text;
        reservationDetailView.str_restaurantName=self.lbl_zipCode.text;
        
        [self.navigationController pushViewController:reservationDetailView animated:YES];
    }
    else
    {
        alert(@"Alert!", @"Please fill mandetory fields.");
    }
   
}

- (IBAction)TappedOndropDwon:(id)sender
{
    array_type=[[NSMutableArray alloc]initWithObjects:@"Restaurant",@"Others",nil];
    
    if(dropDown == nil)
    {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:self.lbl_Type :&f :array_type :Nil :@"down"];
        dropDown.delegate = self;
        
    }
    else
    {
        [dropDown hideDropDown:self.lbl_Type];
        [self rel];
    }

}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    
    
    [self rel];
}

-(void)rel
{
    dropDown = nil;
}




@end
