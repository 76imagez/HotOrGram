#import "HotListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HotMedia.h"

@implementation HotListCell

- (void)setVote:(HotMedia*)vote {
    _vote = vote;
    
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:vote.thumbUrl]];
    _voteCountLabel.text = [vote.votes stringValue];
}

@end
