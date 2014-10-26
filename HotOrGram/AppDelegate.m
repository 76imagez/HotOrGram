#import "AppDelegate.h"
#import "DataStore.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

#define NAV_TEXT_COLOR                  [UIColor colorWithWhite:51.0f/255.0f alpha:1.0f]
#define NAV_BAR_TEXT                    @{NSForegroundColorAttributeName:NAV_TEXT_COLOR, NSFontAttributeName: [UIFont fontWithName:@"PTMono-Regular" size:24.0]}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DataStore prepare];
    
    // == GLOBAL STYLING ===================================================
    // navbar
    [[UINavigationBar appearance] setTitleTextAttributes:NAV_BAR_TEXT];
    // =====================================================================
    
    return YES;
}

@end
