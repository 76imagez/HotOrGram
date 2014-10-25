#import "InstagramMedia.h"

@implementation InstagramMedia

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"mediaId" : @"id",
             @"image_url" : @"images.standard_resolution.url",
             @"thumb_url" : @"images.thumbnail.url"
             };
}

@end
