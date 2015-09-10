//
//  Photo.m
//  InstaKilo
//
//  Created by Alp Eren Can on 09/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)init
{
    self = [super init];
    
    return self;
}

+ (instancetype)photoWithImage:(UIImage *)image location:(NSString *)location subject:(NSString *)subject {
    
    Photo *newPhoto = [Photo new];
    newPhoto.image = image;
    newPhoto.location = location;
    newPhoto.subject = subject;
    
    return newPhoto;
}

@end
