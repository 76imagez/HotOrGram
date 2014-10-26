#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

- (IBAction)voteHot:(id)sender;
- (IBAction)voteNot:(id)sender;

@end
