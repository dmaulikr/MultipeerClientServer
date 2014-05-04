//
//  ListDataSource.h
//  MultipeerClientServer
//
//  Created by Mark Stultz on 4/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

@class List;

@interface ListDataSource : NSObject

- (id)initWithCollectionView:(UICollectionView *)collectionView list:(List *)list;

@end
