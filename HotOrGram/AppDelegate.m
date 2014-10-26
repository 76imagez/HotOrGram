#import "AppDelegate.h"
#import "DataStore.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DataStore prepare];
    
    return YES;
}

@end
