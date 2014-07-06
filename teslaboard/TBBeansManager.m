//
//  TBBeansManager.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBBeansManager.h"
#import "PTDBeanManager.h"
#import "PTDBean.h"

NSString *const TBBeansManagerBeansDidUpdateNotification =  @"TBBeansManagerBeansDidUpdateNotification";

NSString *const TBBeansManagerBeanDidConnectNotification = @"TBBeansManagerBeanDidConnectNotification";


@interface TBBeansManager () <PTDBeanManagerDelegate>

@property (strong, nonatomic) PTDBeanManager *beansManager;
@property (strong, nonatomic) NSMutableArray *beans;
@property (strong, nonatomic) PTDBean *bean;

@property (assign, nonatomic) BOOL shouldStartScan;
@end

@implementation TBBeansManager


+ (instancetype)sharedInstance {
    static TBBeansManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance commonInit];
    });

    return _sharedInstance;
}

- (void)commonInit {
    self.shouldStartScan = YES;
#if ! TARGET_IPHONE_SIMULATOR
    self.beansManager = [[PTDBeanManager alloc] initWithDelegate:self];
#endif
}

- (void)startScanning {
    self.beans = [[NSMutableArray alloc] init];

    if (self.beansManager.state != CBCentralManagerStatePoweredOn) {
        self.shouldStartScan = YES;
    } else {
        NSError *error;
        [self.beansManager startScanningForBeans_error:&error];
    }
}

- (void)stopScanning {
    [self.beansManager stopScanningForBeans_error:NULL];
}

- (void)addBean:(PTDBean *)bean {
    [self.beans addObject:bean];
}

- (void)connectBean:(PTDBean *)bean {
    NSError *error;
    self.bean = bean;
    [self.beansManager connectToBean:bean error:&error];
}

- (void)disconnectCurrentBean {
    [self.beansManager disconnectBean:self.bean
                                error:NULL];
    self.bean = nil;
}

- (NSArray *)currentBeans {
    return [self.beans copy];
}

#pragma mark PTDBeanManagerDelegate

// check to make sure we're on
- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager {
    if (manager.state == CBCentralManagerStatePoweredOn) {
//        [self startScanning];

        if (self.shouldStartScan) {
            NSError *error;
            [self.beansManager startScanningForBeans_error:&error];

            NSLog(@"error %@", error);
        }
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
    NSLog(@"Updated Bean in Scan Window: %@",[((PTDBean *)self.beans[0]) name]);

    [[NSNotificationCenter defaultCenter] postNotificationName:TBBeansManagerBeansDidUpdateNotification object:aBean];
}
// bean connected
- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    if (error) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"连接失败"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"好" otherButtonTitles:nil];

        [alert show];

        PTDLog(@"%@", [error localizedDescription]);
        return;
    }
    // do stuff with your bean
    NSLog(@"Bean connected!");

    [[NSNotificationCenter defaultCenter] postNotificationName:TBBeansManagerBeanDidConnectNotification object:bean];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"巳连接"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"好" otherButtonTitles:nil];

    [alert show];

//    [self.delegate beansDataSource:self
//                     didSelectBean:bean];
    //[connectionProgress stopAnimation:self];
    //[connectedLabel setStringValue:connectedCheck];
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDisconnectBean:(PTDBean*)bean error:(NSError*)error {
    NSLog(@"Bean disconnected.");
    //[connectedLabel setStringValue:disconnectedX];
}

@end
