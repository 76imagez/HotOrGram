#import "HotMedia.h"
#import <Parse/PFObject+Subclass.h>

@implementation HotMedia

@dynamic mediaId;
@dynamic votes;
@dynamic link;
@dynamic imageUrl;
@dynamic thumbUrl;

+ (NSString *)parseClassName {
    return @"Vote";
}

@end
