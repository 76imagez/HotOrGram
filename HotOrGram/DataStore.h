#import <Foundation/Foundation.h>
@class InstagramMedia;

/*
 * Hide as much Parse implementation behind this class as possible, we would probably drop Parse in the future.
 */
@interface DataStore : NSObject

@property (nonatomic, strong, readonly) NSArray* hotlistData;

+ (void)prepare;

- (void)postVoteForMedia:(InstagramMedia*)media withChoice:(BOOL)isHot;

- (void)reloadHotList;

@end
