#import <Foundation/Foundation.h>
@class InstagramMedia;

@interface DataStore : NSObject

+ (void)prepare;

- (void)postVoteForMedia:(InstagramMedia*)media withChoice:(BOOL)isHot;

@end
