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
    
//    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zztx.iphoneExtensions"];
//    NSArray *enabledItems = [mySharedDefaults objectForKey:@"on"];
//    NSMutableArray *toolbarItems = [NSMutableArray new];
//    [enabledItems enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
//        UIBarButtonItem *barButtonItem = [self barButtonItemWithTitle:obj[@"title"] action:obj[@"action"]];
//        [toolbarItems addObject:barButtonItem];
//    }];
//    
//    if (toolbarItems.count) {
//        NSLog(@"%@",toolbarItems);
//    }
//    self.toolbar.items = toolbarItems;
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title action:(NSString *)action {
    UIBarButtonItem *result = nil;
    result = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(action)];
    return result;
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

- (IBAction)wifi {
    [self openURL:@"prefs:root=WIFI"];
}

- (IBAction)cell {
    [self openURL:@"prefs:root=MOBILE_DATA_SETTINGS_ID"];
}

- (IBAction)VPN {
    [self openURL:@"prefs:root=General&path=VPN"];
}

//- (void)turnOnVPN {
//    NSString *string = @"prefs:root=VPN";
//    [self openURL:string];
//}

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
