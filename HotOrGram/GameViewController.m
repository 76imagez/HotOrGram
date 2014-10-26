#import "GameViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "InstagramAPI.h"
#import "InstagramMedia.h"
#import "DataStore.h"

@interface GameViewController ()
@property (nonatomic, strong) InstagramAPI* insta;
@property (nonatomic, strong) DataStore* store;
@property (nonatomic, strong) InstagramMedia* currentMedia;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    self.insta = [InstagramAPI new];
    // start game right away
    [self showNext];
    
    // stylize the TabBar
    // TODO: move to a better place in code
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:37.0f/255.0f green:95.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithWhite:230.0f/255.0f alpha:1.0f];
    self.tabBarController.tabBar.translucent = NO;
}

#pragma mark - Actions
- (IBAction)voteHot:(id)sender {
    [self vote:YES];
}

- (IBAction)voteNot:(id)sender {
    [self vote:NO];
}

#pragma mark - Game
- (void)vote:(BOOL)hot {
    if (!_store)
        _store = [DataStore new];
    
    // will continue processing in background to post vote
    [_store postVoteForMedia:_currentMedia withChoice:hot];
    
    [self showNext];
}

- (void)showNext {
    [SVProgressHUD show];
    [_insta loadRandomMediaWithResult:^(InstagramMedia* media) {
        self.currentMedia = media;
        [SVProgressHUD dismiss];
        
        // databind media to UI
        [_previewImageView sd_setImageWithURL:[NSURL URLWithString:media.imageUrl]];
    }];
}

@end
