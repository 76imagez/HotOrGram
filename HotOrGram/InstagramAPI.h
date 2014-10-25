#import <Foundation/Foundation.h>
@class InstagramMedia;

@interface InstagramAPI : NSObject

- (void)loadRandomMediaWithResult:(void(^)(InstagramMedia* media))result;

@end
