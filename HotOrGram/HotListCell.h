#import <UIKit/UIKit.h>
@class HotMedia;

@interface HotListCell : UICollectionViewCell

@property (nonatomic, strong) HotMedia* vote;
@property (weak, nonatomic) IBOutlet UIImageView* thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *voteCountLabel;

@end
