//
//  NearbyServersDataSource.m
//  MultipeerClientServer
//
//  Created by Mark Stultz on 4/15/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "NearbyServersDataSource.h"
#import "UILabelCollectionViewCell.h"
#import "MCSMultipeerClient.h"
#import "MCSNearbyServer.h"

static void *NearbyServersContext = &NearbyServersContext;

@interface NearbyServersDataSource () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MCSMultipeerClient *multipeerClient;

@end

@implementation NearbyServersDataSource

- (id)initWithCollectionView:(UICollectionView *)collectionView multipeerClient:(MultipeerClient *)multipeerClient
{
	self = [super init];
	if (self)
	{
		self.collectionView = collectionView;
		self.collectionView.dataSource = self;
		self.multipeerClient = multipeerClient;
		
		[self.multipeerClient addObserver:self forKeyPath:@"nearbyServers" options:NSKeyValueObservingOptionNew context:NearbyServersContext];
	}
	
	return self;
}

- (void)dealloc
{
	[self.multipeerClient removeObserver:self forKeyPath:@"nearbyServers"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == NearbyServersContext) {
		[self.collectionView reloadData];
	}
	else {
		return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.multipeerClient.nearbyServers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nearbyServerCell" forIndexPath:indexPath];
	if (cell) {
		NSString *nearbyServerName = @"Untitled Server";
		if (indexPath.row < self.multipeerClient.nearbyServers.count) {
			MCSNearbyServer *nearbyServer = self.multipeerClient.nearbyServers[ indexPath.row ];
			nearbyServerName = nearbyServer.peerID.displayName;
		}
		
		cell.label.text = nearbyServerName;
	}
	
	return cell;
}

@end
