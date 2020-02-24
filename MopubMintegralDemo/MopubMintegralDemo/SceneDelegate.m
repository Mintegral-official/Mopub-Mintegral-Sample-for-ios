#import "SceneDelegate.h"
#import "MPAdPersistenceManager.h"
#import "MPAdTableViewController.h"
#import "MPAdSection.h"
#import "MPIdentityProvider.h"
#import "MPAdConversionTracker.h"
#import "MPAdInfo.h"
#import "MPLogging.h"
#import "MoPub.h"
@interface SceneDelegate ()
@property (nonatomic, strong) MPAdTableViewController * adTable;
@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.adTable = [[MPAdTableViewController alloc] initWithAdSections:[MPAdSection adSections]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.adTable];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    [[MPAdConversionTracker sharedConversionTracker] reportApplicationOpenForApplicationID:@"112358"];

    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1]};
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
