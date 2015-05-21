//
//  FoodVCViewC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

#import "AppDelegate.h"
//#import <SpeechKit/SpeechKit.h>
//#import "YelpAPIService.h"

@interface FoodVCViewC : UIViewController<NIDropDownDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NIDropDown *dropDown;
    NSMutableArray *arr_dropDwonItems;
    NSMutableArray *arr_dropDwonItems2;
    BOOL isTouched;
    IBOutlet UIButton *btn_restaurantDropDown;
    NSString *str_customerServId;
}
@property(nonatomic,strong)IBOutlet UITextField *txtField_address;
@property(nonatomic,strong)IBOutlet UITextField *txtField_zipCode;
@property(nonatomic,strong)IBOutlet UITextField *txtField_selectedRestaurent;
@property(nonatomic,strong)IBOutlet UITextView *txtView_foodItems;

//Yelp objects

@property (strong, nonatomic) NSMutableArray *array_restaurantNames;


@property (strong, nonatomic) IBOutlet  UIView *view_tableBg;

@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *tableViewDisplayDataArray;
//@property (strong, nonatomic) SKRecognizer* voiceSearch;
//@property (strong, nonatomic) YelpAPIService *yelpService;
@property (strong, nonatomic) NSString* searchCriteria;
//@property (strong, nonatomic) SKVocalizer* vocalizer;
@property BOOL isSpeaking;

- (IBAction)recordButtonTapped:(id)sender;
- (NSString *)getYelpCategoryFromSearchText;
- (void)findNearByRestaurantsFromYelpbyCategory:(NSString *)categoryFilter;

//




- (IBAction)TappedOnBack:(id)sender;

@end
