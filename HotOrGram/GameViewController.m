#import "GameViewController.h"
#import "InstagramAPI.h"

@interface GameViewController ()
@property (nonatomic, strong) InstagramAPI* insta;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.insta = [InstagramAPI new];
}

@end
