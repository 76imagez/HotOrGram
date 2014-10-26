#import "HotListCollectionViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>
#import "DataStore.h"
#import "HotListCell.h"
#import "HotMedia.h"

@interface HotListCollectionViewController ()
@property (nonatomic, strong) DataStore* datastore;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@end

@implementation HotListCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datastore = [DataStore new];
    
    // RAC on datastore load
    @weakify(self);
    [RACObserve(_datastore, hotlistData) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
        [self.refreshControl endRefreshing];
    }];
    
    // add pull to refresh to UI
    self.refreshControl = [UIRefreshControl new];
//    self.refreshControl.tintColor = APP_HIGHLIGHT_COLOR;
    [_refreshControl addTarget:_datastore
                        action:@selector(reloadHotList)
              forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_datastore reloadHotList];
}

#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datastore.hotlistData.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    HotListCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.vote = _datastore.hotlistData[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // pop open safari with link to Instagram
    HotMedia* hot = _datastore.hotlistData[indexPath.item];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:hot.link]];
}

@end
