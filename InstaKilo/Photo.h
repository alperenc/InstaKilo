//
//  Photo.h
//  InstaKilo
//
//  Created by Alp Eren Can on 09/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *subject;

- (instancetype)init;

+ (instancetype)photoWithImage:(UIImage *)image location:(NSString *)location subject:(NSString *)subject;

@end
