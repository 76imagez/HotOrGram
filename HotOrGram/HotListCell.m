#import "HotListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HotMedia.h"

@implementation HotListCell

- (void)setVote:(HotMedia*)vote {
    _vote = vote;
    
    // UI: can't set in IB
    _thumbImageView.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.3].CGColor;
    
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:vote.thumbUrl]];
    _voteCountLabel.text = [vote.votes stringValue];
}

@end
