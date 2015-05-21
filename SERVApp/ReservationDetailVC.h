//
//  ReservationDetailVC.h
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

@interface ReservationDetailVC : UIViewController<NIDropDownDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary *json;
    NIDropDown *dropDown;
    BOOL isDate;
    BOOL isBackupTime;
    NSString *strPhone;


    
}
@property(nonatomic,strong)IBOutlet UITextField *lbl_type;
@property(nonatomic,strong)IBOutlet UITextField *lbl_zipCode;

@property(nonatomic,strong)IBOutlet UITextField *lbl_restaurent;

@property(nonatomic,strong)IBOutlet UITextField *lbl_date;

@property(nonatomic,strong)IBOutlet UITextField *lbl_time;

@property(nonatomic,strong)IBOutlet UITextField *lbl_backUpTime;
@property(nonatomic,strong)NSMutableArray *array_restaurantNames;
@property(nonatomic,strong)NSString *str_restaurantName;
@property(nonatomic,strong)NSString *str_type;

@property(nonatomic,strong)IBOutlet UIView *view_picker;
@property(nonatomic,strong)IBOutlet UIDatePicker *picker_dateAndTime;
@property(nonatomic,strong)IBOutlet UILabel *lbl_pickerTitle;


//Yelp objects

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
