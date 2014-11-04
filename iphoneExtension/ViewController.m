//
//  ViewController.m
//  iphoneExtensions
//
//  Created by niko on 11/3/14.
//  Copyright (c) 2014 niko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSDictionary *items;
@property (nonatomic, strong) NSArray *enabledItems;
@property (nonatomic, strong) NSArray *denabledItems;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iPhone Extension";
    self.tableView.editing = YES;
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.bumaociyuan.iphoneExtension"];
    [mySharedDefaults setObject:self.enabledItems forKey:@"on"];
}

- (NSDictionary *)items {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary *items = [NSDictionary dictionaryWithContentsOfFile:plistPath].mutableCopy;
    return items;
}

- (NSArray *)enabledItems {
    return self.items[@"on"];
}

- (NSArray *)denabledItems {
    return self.items[@"off"];
}

#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section) {
        return @"OFF";
    }else {
        return @"ON";
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section) {
        return self.denabledItems.count;
    }else {
        return self.enabledItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSDictionary *item = nil;
    if (section) {
        item = self.denabledItems[row];
    }else {
        item = self.enabledItems[row];
    }
    cell.textLabel.text = item[@"title"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSMutableArray *mDenabledItems = [self.denabledItems mutableCopy];
    NSMutableArray *mEnabledItems = [self.enabledItems mutableCopy];
    NSDictionary *sourceItem = nil;
    if (sourceIndexPath.section) {
        sourceItem = mDenabledItems[sourceIndexPath.row];
        [mDenabledItems removeObjectAtIndex:sourceIndexPath.row];
        [mEnabledItems insertObject:sourceItem atIndex:destinationIndexPath.row];
    }else {
        sourceItem = mEnabledItems[sourceIndexPath.row];
        [mEnabledItems removeObjectAtIndex:sourceIndexPath.row];
        [mDenabledItems insertObject:sourceItem atIndex:destinationIndexPath.row];
    }
    
    NSDictionary *items = @{@"on":mEnabledItems,@"off":mDenabledItems};
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    [items writeToFile:plistPath atomically:NO];
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zztx.iphoneExtensions"];
    [mySharedDefaults setObject:mEnabledItems forKey:@"on"];
}

@end
