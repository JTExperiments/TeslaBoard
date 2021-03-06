//
//  TBClub.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVObject;

@interface TBClub : NSObject

@property (copy, nonatomic, readonly) NSString *name;
@property (copy, nonatomic, readonly) UIColor *color;
@property (copy, nonatomic, readonly) NSURL *logoURL;
@property (copy, nonatomic, readonly) UIImage *logo;

+ (TBClub *)clubWithAVObject:(AVObject *)obj;

@end
