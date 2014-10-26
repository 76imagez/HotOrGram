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
    
    return self;
}

- (void)loadPopularFeedWithCompletion:(void(^)())completion {
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
        completion();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        assert(false); // TODO: proper error handling
        completion();
        
    }];
}

- (InstagramMedia*)pickRandomMedia {
    NSMutableArray* temp = [_media mutableCopy];
    // pick random item
    NSUInteger randomIndex = arc4random() % [_media count];
    InstagramMedia* retVal = _media[randomIndex];
    // remove it from the array
    [temp removeObjectAtIndex:randomIndex];
    self.media = [temp copy];
    // return it
    return retVal;
}

- (void)loadRandomMediaWithResult:(void(^)(InstagramMedia *))result {
    if (_media.count == 0) { // load if result set empty
        [self loadPopularFeedWithCompletion:^{
            result([self pickRandomMedia]);
        }];
    } else {
        result([self pickRandomMedia]);
    }
}

@end
