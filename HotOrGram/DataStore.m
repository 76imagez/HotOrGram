#import "DataStore.h"
#import <Parse/Parse.h>
#import "InstagramMedia.h"

@implementation DataStore

+ (void)prepare {
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
            vote[@"image_url"] = media.image_url;
            vote[@"thumb_url"] = media.thumb_url;
            vote[@"votes"] = isHot ? @1 : @-1;
            [vote saveInBackground];
        }
    }];
}

@end
