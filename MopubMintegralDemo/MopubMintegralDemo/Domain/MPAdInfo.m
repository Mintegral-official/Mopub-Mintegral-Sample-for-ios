//
//  MPAdInfo.m
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import "MPAdInfo.h"

#import <Foundation/Foundation.h>

NSString * const kAdInfoIdKey = @"adUnitId";
NSString * const kAdInfoFormatKey = @"format";
NSString * const kAdInfoKeywordsKey = @"keywords";
NSString * const kAdInfoNameKey = @"name";

@implementation MPAdInfo

+ (NSDictionary *)supportedAddedAdTypes
{
    static NSDictionary *adTypes = nil;

    static dispatch_once_t once;
    dispatch_once(&once, ^{
        adTypes = @{@"Banner":@(MPAdInfoBanner),  @"MRect":@(MPAdInfoMRectBanner), @"Leaderboard":@(MPAdInfoLeaderboardBanner), @"Native":@(MPAdInfoNative), @"Rewarded Video":@(MPAdInfoRewardedVideo), @"Rewarded":@(MPAdInfoRewardedVideo), @"NativeTablePlacer":@(MPAdInfoNativeTableViewPlacer), @"NativeCollectionPlacer":@(MPAdInfoNativeInCollectionView)};
    });

    return adTypes;
}

+ (NSArray *)bannerAds
{
    NSMutableArray *ads = [NSMutableArray array];

    [ads addObjectsFromArray:@[
                             
        [MPAdInfo infoWithTitle:@"Mintegral Banner Ad" ID:@"f428a1e597be48f496204e7265481dbf" type:MPAdInfoBanner],
                               

                               ]];//

    return ads;
}

+ (NSArray *)interstitialAds
{


    return @[
    [MPAdInfo infoWithTitle:@"Mintegral InterstitialVideo Ad" ID:@"d8f487b5f6074823b2cc56a5c691188a" type:MPAdInfoInterstitial],
    
    ];
}

+ (NSArray *)rewardedVideoAds
{

//      
    return @[
    [MPAdInfo infoWithTitle:@"Mintegral RewardVideo" ID:@"235677b0caf54f99882431a35222a21f" type:MPAdInfoRewardedVideo],
        
        ];
}

+ (NSArray *)nativeAds
{

    return @[
    [MPAdInfo infoWithTitle:@"Mintegral NativeAds" ID:@"2908be333ed944be81396ea732f603a8" type:MPAdInfoNative],
    ];
}



+ (MPAdInfo *)infoWithTitle:(NSString *)title ID:(NSString *)ID type:(MPAdInfoType)type {
    MPAdInfo *info = [[MPAdInfo alloc] init];
    info.title = title;
    info.ID = ID;
    info.type = type;
    return info;
}

+ (MPAdInfo *)infoWithDictionary:(NSDictionary *)dict
{
    // Extract the required fields from the dictionary. If either of the required fields
    // is invalid, object creation will not be performed.
    NSString * adUnitId = [[dict objectForKey:kAdInfoIdKey] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * formatString = [[dict objectForKey:kAdInfoFormatKey] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * keywords = [[dict objectForKey:kAdInfoKeywordsKey] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * name = [[dict objectForKey:kAdInfoNameKey] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if (adUnitId.length == 0 || formatString.length == 0 || (formatString != nil && [[self supportedAddedAdTypes] objectForKey:formatString] == nil)) {
        return nil;
    }

    MPAdInfoType format = (MPAdInfoType)[[[self supportedAddedAdTypes] objectForKey:formatString] integerValue];
    NSString * title = (name != nil ? name : adUnitId);
    MPAdInfo * info = [MPAdInfo infoWithTitle:title ID:adUnitId type:format];
    info.keywords = keywords;

    return info;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self != nil)
    {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.keywords = [aDecoder decodeObjectForKey:@"keywords"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:((self.keywords != nil) ? self.keywords : @"") forKey:@"keywords"];
}

@end
