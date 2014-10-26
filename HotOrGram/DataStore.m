#import "DataStore.h"
#import <Parse/Parse.h>
#import "InstagramMedia.h"
#import "HotMedia.h"

@interface DataStore ()
@property (nonatomic, strong) NSArray* hotlistData;
@end

@implementation DataStore

+ (void)prepare {
    [HotMedia registerSubclass];
    [Parse setApplicationId:@"YvIl0ikFHeYtfEzpJrIaqwwmODpzygdIfRNLoegb"
                  clientKey:@"3V6TDsbYRpk7JCz4yqobe9SWj65vrNqY0uNI8TIW"];
}

- (void)postVoteForMedia:(InstagramMedia*)media withChoice:(BOOL)isHot {
    // TODO: this takes two HTTP calls, not acceptable for a produciton app (batch votes and process diff on server in the future)
    // try and find a current vote record
    PFQuery* query = [PFQuery queryWithClassName:@"Vote"];
    [query whereKey:@"mediaId" equalTo:media.mediaId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && objects.count > 0) {
            // UPDATE vote
            PFObject* vote = objects[0];
            [vote incrementKey:@"votes" byAmount:isHot ? @1 : @-1];
            [vote saveInBackground];
        } else {
            // CREATE vote
            PFObject* vote = [PFObject objectWithClassName:@"Vote"];
            vote[@"mediaId"] = media.mediaId;
            vote[@"link"] = media.link;
            vote[@"imageUrl"] = media.imageUrl;
            vote[@"thumbUrl"] = media.thumbUrl;
            vote[@"votes"] = isHot ? @1 : @-1;
            [vote saveInBackground];
        }
    }];
}

- (void)reloadHotList {
    // all positive votes ordered highest first
    PFQuery* query = [PFQuery queryWithClassName:@"Vote"];
    [query orderByDescending:@"votes"];
    [query whereKey:@"votes" greaterThan:@0];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.hotlistData = objects;
    }];
}

@end
