Mopub-Mintegral-Sample-for-ios

This is a simple sample for test mopub-mintegral integration on ios platform

- you can modify the mopub unit id for every ad format under MopubMintegralDemo/Domain/MPAdInfo.m

the code where the mopub unit ids are set

```
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

```
