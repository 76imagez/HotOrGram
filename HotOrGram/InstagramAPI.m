#import "InstagramAPI.h"
#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>
#import "InstagramMedia.h"

@interface InstagramAPI()
@property (nonatomic, strong) NSArray* media;
@end

@implementation InstagramAPI

- (instancetype)init {
    self = [super init];
    if (!self)
        return nil;
    
    [self loadPopularFeed];
    
    return self;
}

- (void)loadPopularFeed {
    NSString* endpoint = @"https://api.instagram.com/v1/media/popular?client_id=6b37654f9a8d4d00a9b2e8cca32a33a2";
    [[AFHTTPRequestOperationManager manager] GET:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSArray* data = responseObject[@"data"];
            NSMutableArray* results = [NSMutableArray array];
            for (NSDictionary* item in data) {
                InstagramMedia* media = [MTLJSONAdapter modelOfClass:InstagramMedia.class fromJSONDictionary:item error:NULL];
                if ([media.type isEqualToString:@"image"]) // strip out video, I ain't ready for that yet
                    [results addObject:media];
            }
            self.media = [results copy];
        } else {
            assert(false); // TODO: proper error handling
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        assert(false); // TODO: proper error handling
        
    }];
}

- (void)loadRandomMediaWithResult:(void (^)(InstagramMedia *))result {
    // TODO: pull a random item out of the media array until its empty
    // load more if it is
    
}

@end
