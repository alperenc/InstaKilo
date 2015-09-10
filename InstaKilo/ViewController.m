//
//  ViewController.m
//  InstaKilo
//
//  Created by Alp Eren Can on 09/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import "ViewController.h"
#import "HeaderCollectionReusableView.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic) NSMutableDictionary *sortedPhotos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photos = @[
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0241.jpg"] location:@"Istanbul" subject:@"Sunbathing"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0247.jpg"] location:@"Istanbul" subject:@"Picnic"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0256.jpg"] location:@"Istanbul" subject:@"Hiking"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0436.jpg"] location:@"Vancouver" subject:@"Picnic"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0438.jpg"] location:@"Vancouver" subject:@"Picnic"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0449.jpg"] location:@"Vancouver" subject:@"Seaside"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0456.jpg"] location:@"Vancouver" subject:@"Hiking"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0464.jpg"] location:@"Los Angeles" subject:@"Sunbathing"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0465.jpg"] location:@"Los Angeles" subject:@"Sunbathing"],
                    [Photo photoWithImage:[UIImage imageNamed:@"O14A0468.jpg"] location:@"Los Angeles" subject:@"Picnic"]];
    
    [self sortPhotosByLocation];
}



- (void)sortPhotosByLocation {
    self.sortedPhotos = [NSMutableDictionary dictionary];
    
    for (Photo *photo in self.photos) {
        NSMutableArray *photosAtLocation = self.sortedPhotos[photo.location];
        if (!photosAtLocation) photosAtLocation = [NSMutableArray array];
        [photosAtLocation addObject:photo];
        self.sortedPhotos[photo.location] = photosAtLocation;
    }
}

- (void)sortPhotosBySubject {
    self.sortedPhotos = [NSMutableDictionary dictionary];
    
    for (Photo *photo in self.photos) {
        NSMutableArray *photosWithSubject = self.sortedPhotos[photo.subject];
        if (!photosWithSubject) {
            photosWithSubject = [NSMutableArray array];
        }
        [photosWithSubject addObject:photo];
        self.sortedPhotos[photo.subject] = photosWithSubject;
    }
}

- (IBAction)sortPhotos:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self sortPhotosByLocation];
    } else if (sender.selectedSegmentIndex == 1) {
        [self sortPhotosBySubject];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sortedPhotos.allKeys count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sortedPhotos[self.sortedPhotos.allKeys[section]] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    Photo *photo = self.sortedPhotos.allValues[indexPath.section][indexPath.row];
    
    photoCell.imageView.image = photo.image;
    
    return photoCell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.sectionLabel.text = [NSString stringWithFormat:@"%@", self.sortedPhotos.allKeys[indexPath.section]];
        return headerView;
    }
    return nil;
}

@end
