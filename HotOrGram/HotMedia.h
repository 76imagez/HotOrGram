#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface HotMedia : PFObject <PFSubclassing>

+ (NSString*)parseClassName;

@property (nonatomic, strong) NSString* mediaId;
@property (nonatomic, strong) NSNumber* votes;
@property (nonatomic, strong) NSString* link;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSString* thumbUrl;

@end
