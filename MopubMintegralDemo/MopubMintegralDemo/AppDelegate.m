//
//  AppDelegate.m
//  MopubMintegralDemo
//
//  Created by Damon on 2019/11/16.
//  Copyright © 2019 mintegral. All rights reserved.
//

#import "AppDelegate.h"
#import "MPAdPersistenceManager.h"
#import "MPAdTableViewController.h"
#import "MPAdSection.h"
#import "MPIdentityProvider.h"
#import "MPAdConversionTracker.h"
#import "MPAdInfo.h"
#import "MPLogging.h"
#import "MoPub.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MintegralAdapterConfiguration.h"

@interface AppDelegate ()
@property (nonatomic, strong) MPAdTableViewController * adTable;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"This device's advertisingIdentifier: %@", [MPIdentityProvider identifier]);


        MPMoPubConfiguration * sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization: @"24c6b489260e4588a6375348f041cad8"];//  0ac59b0996d947309c33f59d6676399f
        sdkConfig.globalMediationSettings = @[];
        sdkConfig.loggingLevel = MPBLogLevelDebug;
        sdkConfig.additionalNetworks = [NSArray arrayWithObject:[MintegralAdapterConfiguration class]];
        sdkConfig.mediatedNetworkConfigurations = nil;
        
        [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
            NSLog(@"SDK initialization complete");
        }];

        return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"mopub"] && [url.host isEqualToString:@"load"]) {
        // Convert the query parameters into a dictionary.
        NSDictionary * queryParameters = ({
            NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];

            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            for (NSURLQueryItem * queryItem in urlComponents.queryItems) {
                [params setObject:queryItem.value forKey:queryItem.name];
            }

            params;
        });

        // Extract the info needed to create the `MPAdInfo` object.
        MPAdInfo * adUnit = [MPAdInfo infoWithDictionary:queryParameters];
        if (adUnit == nil) {
            return NO;
        }

        // Dispatch the display of the ad unit onto the main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.adTable loadAd:adUnit];
            [[MPAdPersistenceManager sharedManager] addSavedAd:adUnit];
        });

        return YES;
    }
    return NO;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    
    

    
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
