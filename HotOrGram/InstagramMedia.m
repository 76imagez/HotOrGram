#import "InstagramMedia.h"

@implementation InstagramMedia

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"mediaId" : @"id",
             @"imageUrl" : @"images.standard_resolution.url",
             @"thumbUrl" : @"images.thumbnail.url"
             };
}

@end
