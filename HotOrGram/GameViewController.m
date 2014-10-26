#import "GameViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "InstagramAPI.h"
#import "InstagramMedia.h"

@interface GameViewController ()
@property (nonatomic, strong) InstagramAPI* insta;
@property (nonatomic, strong) InstagramMedia* currentMedia;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.insta = [InstagramAPI new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // start game right away
    [self showNext];
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
    [self showNext];
}

- (void)showNext {
    [SVProgressHUD show];
    [_insta loadRandomMediaWithResult:^(InstagramMedia* media) {
        self.currentMedia = media;
        [SVProgressHUD dismiss];
        
        // databind media to UI
        [_previewImageView sd_setImageWithURL:[NSURL URLWithString:media.image_url]];
    }];
}

@end
