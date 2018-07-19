#import "AppDelegate.h"
#import "MJExampleWindow.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {




    NSArray *filterArray = @[@"ab", @"abc"];
    NSArray *array = @[@"a", @"ab", @"abc", @"abcd"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", filterArray];
    NSLog(@"%@", [array filteredArrayUsingPredicate:predicate]);
//    array[index]：返回array数组中index索引处的元素
//    array[FIRST]：返回array数组中第一个元素
//    array[LAST]：返回array数组中最后一个元素
//    array[SIZE]：返回array数组中元素的个数




    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MJExampleWindow show];
    });
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
