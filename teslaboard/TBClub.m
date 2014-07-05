//
//  TBClub.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBClub.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIColor+HexString.h"

@interface TBClub ()

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) UIColor *color;
@property (copy, nonatomic) NSURL *logoURL;

@end

@implementation TBClub

+ (TBClub *)clubWithAVObject:(AVObject *)obj {
    TBClub *club = [[TBClub alloc] init];
    club.name = [obj objectForKey:@"name"];
    club.color = [UIColor colorWithHexString:[obj objectForKey:@"color"]];

    AVFile *logo = [obj objectForKey:@"logo"];
    club.logoURL = [NSURL URLWithString:logo.url];

    return club;
}

@end
