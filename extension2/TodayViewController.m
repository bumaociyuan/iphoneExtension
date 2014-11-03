//
//  TodayViewController.m
//  extension2
//
//  Created by niko on 11/3/14.
//  Copyright (c) 2014 niko. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "CTMessageCenter.h"

@interface TodayViewController () <NCWidgetProviding>
@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
#pragma mark - NCWidgetProviding
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)openURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
    }];
}

- (IBAction)fee:(id)sender {
//    [self location];
//}

- (IBAction)wifi {
    [self openURL:@"prefs:root=WIFI"];
}

- (void)cell {
    [self openURL:@"prefs:root=CELL"];
}

- (void)turnOnVPN {
    NSString *string = @"prefs:root=VPN";
    [self openURL:string];
}

- (IBAction)location {
    NSString *string = @"prefs:root=LOCATION_SERVICES";
    [self openURL:string];
}

- (IBAction)hotSpot {
    [self openURL:@"prefs:root=INTERNET_TETHERING"];
}

- (void)send {
    BOOL success = [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"3" serviceCenter:nil toAddress:@"1008611"];
    if (success) {
        NSLog(@"sended");
    } else {
        NSLog(@"message not send");
    }
}
@end
