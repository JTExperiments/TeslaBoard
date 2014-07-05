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
#import "SDWebImageManager.h"

@interface TBClub ()

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) UIColor *color;
@property (copy, nonatomic) NSURL *logoURL;
@property (copy, nonatomic) UIImage *logo;

@end

@implementation TBClub

+ (TBClub *)clubWithAVObject:(AVObject *)obj {
    TBClub *club = [[TBClub alloc] init];
    club.name = [obj objectForKey:@"name"];
    club.color = [UIColor colorWithHexString:[obj objectForKey:@"color"]];

    AVFile *logo = [obj objectForKey:@"logo"];
    club.logoURL = [NSURL URLWithString:logo.url];

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:club.logoURL
                     options:0
                    progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         // progression tracking code
     }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image)
         {
             // do something with image
             club.logo = [UIImage imageWithCGImage:image.CGImage
                                             scale:2
                                       orientation:UIImageOrientationUp];
         }
     }];

    return club;
}

@end
