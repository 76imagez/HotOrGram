#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface InstagramMedia : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString* mediaId;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* link;
@property (nonatomic, strong) NSString* imageUrl; // image->standard_resolution->url
@property (nonatomic, strong) NSString* thumbUrl; // image->thumbnail->url

@end
