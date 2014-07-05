//
//  TBBeansDataSource.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBBeansDataSource.h"
#import "PTDBean.h"
#import "TBBeansManager.h"

@interface TBBeansDataSource () <
UITableViewDataSource
, UITableViewDelegate
>

@property (strong, nonatomic) NSMutableArray *beans;
@property (strong, nonatomic) PTDBean *bean;

@end



@implementation TBBeansDataSource

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)commonInit {
    self.beans = [[TBBeansManager sharedInstance].currentBeans copy];
    self.bean = [TBBeansManager sharedInstance].bean;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(beansDidUpdateNotification:) name:TBBeansManagerBeansDidUpdateNotification
                                               object:nil];
}

#pragma mark Overrides

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    [_tableView reloadData];
}


#pragma mark Notifications

- (void)beansDidUpdateNotification:(NSNotification *)notification {
    self.beans = [[[TBBeansManager sharedInstance] currentBeans] copy];
    [self.tableView reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    PTDBean *newBean = [self.beans objectAtIndex:indexPath.row];
    cell.textLabel.text = [newBean name];

    if (self.bean == newBean) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.beans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"touched row %lu",(long)indexPath.row);
    // connect bean
    PTDBean *bean = self.beans[indexPath.row];

    if (self.bean) {
        [[TBBeansManager sharedInstance] disconnectCurrentBean];

        if (self.bean && self.bean == bean) {
            self.bean = nil;
        } else {
            self.bean = bean;
        }
    } else {
        self.bean = bean;
    }

    if (self.bean) {
        [[TBBeansManager sharedInstance] connectBean:bean];
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
