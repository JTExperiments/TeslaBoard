//
//  TBBeansManager.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const TBBeansManagerBeansDidUpdateNotification;
extern NSString *const TBBeansManagerBeanDidConnectNotification;


@class PTDBean;

@interface TBBeansManager : NSObject

@property (strong, nonatomic, readonly) PTDBean *bean;
- (NSArray *)currentBeans;

+ (instancetype)sharedInstance;
- (void)startScanning;
- (void)stopScanning;
- (void)connectBean:(PTDBean *)bean;
- (void)disconnectCurrentBean;

@end
