//
//  TBBeansDataSource.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTDBeanManager;
@class PTDBean;
@class TBBeansDataSource;

@protocol TBBeansDataSourceDelegate <NSObject>

- (void)beansDataSource:(TBBeansDataSource *)dataSource
          didSelectBean:(PTDBean *)bean;

@end

@interface TBBeansDataSource : NSObject

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet id <TBBeansDataSourceDelegate> delegate;

@end
