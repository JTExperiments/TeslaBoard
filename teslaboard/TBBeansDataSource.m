//
//  TBBeansDataSource.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBBeansDataSource.h"
#import "PTDBeanManager.h"
#import "PTDBean.h"

@interface TBBeansDataSource () <
PTDBeanManagerDelegate
, UITableViewDataSource
, UITableViewDelegate
>

@property (strong, nonatomic) PTDBeanManager *beansManager;
@property (strong, nonatomic) NSMutableArray *beans;
@property (strong, nonatomic) PTDBean *bean;

@end



@implementation TBBeansDataSource

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit {
    self.beansManager = [[PTDBeanManager alloc] initWithDelegate:self];
    self.beans = [[NSMutableArray alloc] init];
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    [_tableView reloadData];

    [self startScanning];
}

- (void)startScanning {
    if ( ! self.bean) {
        NSError *error;
        [self.beansManager startScanningForBeans_error:&error];
    }
}

- (void)addBean:(PTDBean *)bean {

    [self.tableView beginUpdates];
    [self.beans addObject:bean];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.beans count] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
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
    [self.beansManager stopScanningForBeans_error:nil];

    PTDBean *bean = self.beans[indexPath.row];

    if (self.bean) {
        NSError *error;
        [self.beansManager disconnectBean:bean
                                    error:&error];

        if (self.bean && self.bean == bean) {
            self.bean = nil;
        } else {
            self.bean = bean;
        }
    } else {
        self.bean = bean;
    }

    if (self.bean) {
        [self.delegate beansDataSource:self
                         didSelectBean:self.bean];

        [self.beansManager connectToBean:self.bean error:nil];
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark PTDBeanManagerDelegate

// check to make sure we're on
- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager {
    if (manager.state == CBCentralManagerStatePoweredOn) {
        [self startScanning];
    }
}

// bean discovered
- (void)BeanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)aBean error:(NSError*)error{
    if (error) {
        PTDLog(@"%@", [error localizedDescription]);
        return;
    }
    if( ![self.beans containsObject:aBean] ){
        [self addBean:aBean];
    }
    //    [flipsideController.scanTable reloadData];
    NSLog(@"Updated Bean in Scan Window: %@",[((PTDBean *)self.beans[0]) name]);
    //[self.beanManager connectToBean:bean error:nil];
}
// bean connected
- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    if (error) {
        PTDLog(@"%@", [error localizedDescription]);
        return;
    }
    // do stuff with your bean
    NSLog(@"Bean connected!");
    [self.delegate beansDataSource:self
                     didSelectBean:bean];
    //[connectionProgress stopAnimation:self];
    //[connectedLabel setStringValue:connectedCheck];
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDisconnectBean:(PTDBean*)bean error:(NSError*)error {
    NSLog(@"Bean disconnected.");
    //[connectedLabel setStringValue:disconnectedX];
}

@end
